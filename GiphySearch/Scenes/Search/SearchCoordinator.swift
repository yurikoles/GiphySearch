//
//  SearchCoordinator.swift
//  GiphySearch
//
//  Created by Yurii Kolesnykov on 2018-09-27.
//  Copyright © 2018 yurikoles. All rights reserved.
//

import UIKit

class SearchCoordinator {
    weak var mainDelegate: CoodinatorDelegate?
    var navigationController: UINavigationController!

    init(mainDelegate: CoodinatorDelegate) {
        self.mainDelegate = mainDelegate
    }

    func start(nc: UINavigationController) {
        navigationController = nc
        navigationController.pushViewController(searchViewContoller, animated: true)
    }

    lazy var searchViewContoller: SearchViewContoller = {
        let searchViewContoller = SearchViewContoller.searchViewController(self)
        let searchViewModel = SearchViewModel(searchViewContoller)

        searchViewContoller.fillViewModel(inputs: searchViewModel,
                                          outputs: searchViewModel)
        return searchViewContoller
    }()
}

// MARK: - SearchViewControllerDelegate
extension SearchCoordinator: SearchViewControllerDelegate {
    func showDetails(_ originalURL: URL) {
        let fullGIFViewController = FullGIFViewController.fullGIFViewController(originalURL)

        navigationController.pushViewController(fullGIFViewController,
                                                    animated: true)
    }
}
