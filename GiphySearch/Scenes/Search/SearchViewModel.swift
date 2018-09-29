//
//  SearchViewModel.swift
//  Giphy Search
//
//  Created by Yurii Kolesnykov on 2018-09-29.
//  Copyright © 2018 yurikoles. All rights reserved.
//

import Foundation
import GiphyCoreSDK

protocol SearchViewModelDelegate: class {
    func handleError(_ error: NSError)
    func reload()
}

protocol SearchViewModelInputs: class {
    func search(_ searchTerm: String?)
}

protocol SearchViewModelOutputs: class {
    var modelsCount: Int {get}

    func smallURL(for indexPath: IndexPath) -> URL?
    func originalURL(for indexPath: IndexPath) -> URL?
}

class SearchViewModel {
    fileprivate var smallURLs: [URL?]?
    fileprivate var originalURLs: [URL?]?

    fileprivate weak var delegate: SearchViewModelDelegate?

    init(_ delegate: SearchViewModelDelegate) {
        self.delegate = delegate
    }

    fileprivate var operation: Operation?

}

// MARK: - SearchViewModelInputs
extension SearchViewModel: SearchViewModelInputs {
    func search(_ searchTerm: String?) {
        guard let searchTerm = searchTerm,
            searchTerm.count > 0
            else {
                return
        }

        if let operation = operation {
            operation.cancel()
        }

        operation = GiphyCore.shared.search(searchTerm) {[weak self] (response, error) in
            guard let self = self else { return }

            if let error = error as NSError? {
                self.delegate?.handleError(error)
            }

            if let response = response,
                let data = response.data,
                let pagination = response.pagination {
                self.smallURLs = response.data?.map({ (media) -> URL? in
                    guard let gifURLString = media.images?.downsized?.gifUrl,
                        let gifURL = URL(string: gifURLString)
                    else { return nil }
                    return gifURL
                })

                self.originalURLs = response.data?.map({ (media) -> URL? in
                    guard let gifURLString = media.images?.original?.gifUrl,
                        let gifURL = URL(string: gifURLString)
                        else { return nil }
                    return gifURL
                })

                print(response.meta)
                print(pagination)
                for result in data {
                    print(result)
                }

                self.delegate?.reload()

            } else {
                print("No Results Found")
            }
        }
    }
}

// MARK: - SearchViewModelOutputs
extension SearchViewModel: SearchViewModelOutputs {
    var modelsCount: Int {
        guard let smallURLs = smallURLs
            else { return 0 }
        return smallURLs.count
    }

    func smallURL(for indexPath: IndexPath) -> URL? {
        let index = indexPath.row

        guard index < (smallURLs?.count ?? 0),
            let smallURL = smallURLs?[index]
            else { return nil }

        return smallURL
    }

    func originalURL(for indexPath: IndexPath) -> URL? {
        let index = indexPath.row

        guard index < (originalURLs?.count ?? 0),
            let originalURL = originalURLs?[index]
        else { return nil }
        return originalURL
    }
}
