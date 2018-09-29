//
//  SearchViewContoller.swift
//  GiphySearch
//
//  Created by Yurii Kolesnykov on 2018-09-27.
//  Copyright © 2018 yurikoles. All rights reserved.
//

import UIKit
import GiphyCoreSDK
import AlamofireImage

protocol SearchViewControllerDelegate: class {
    func showDetails(_ originalURL: URL)
}

class SearchViewContoller: UITableViewController {
    fileprivate weak var delegate: SearchViewControllerDelegate?
    fileprivate var viewModelInputs: SearchViewModelInputs!
    fileprivate var viewModelOutputs: SearchViewModelOutputs!
    fileprivate let searchController = UISearchController(searchResultsController: nil)

    struct SearchViewContollerConstants {
        static let numberOfSections = 1
        static let cellHeight = CGFloat(100)
    }
}

// MARK: - Initialization
extension SearchViewContoller {
    class func searchViewController(_ delegate: SearchViewControllerDelegate) -> SearchViewContoller {
        let searchViewController = SearchViewContoller()
        searchViewController.delegate = delegate
        return searchViewController
    }

    func fillViewModel(inputs: SearchViewModelInputs,
                       outputs: SearchViewModelOutputs) {
        viewModelInputs = inputs
        viewModelOutputs = outputs
    }

    func setupTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GIFResultTableViewCell.self,
                           forCellReuseIdentifier: GIFResultTableViewCell.reuseIdentifier)
        tableView.reloadData()
    }

    func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type to search GIFs"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
    }
}

// MARK: - View ;ife cycle
extension SearchViewContoller {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search GIFs"
        setupTableView()
        setupSearchController()
    }
}

// MARK: - UITableViewDataSource
extension SearchViewContoller {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SearchViewContollerConstants.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelOutputs.modelsCount
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchViewContollerConstants.cellHeight
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let gifURL = viewModelOutputs.smallURL(for: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: GIFResultTableViewCell.reuseIdentifier,
                                                     for: indexPath) as? GIFResultTableViewCell
        else { return UITableViewCell() }

        cell.fillWithURL(gifURL)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewContoller {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let originalURL = viewModelOutputs.originalURL(for: indexPath) {
            delegate?.showDetails(originalURL)
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewContoller: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModelInputs.search(searchBar.text)
    }
}

// MARK: - SearchViewModelDelegate
extension SearchViewContoller: SearchViewModelDelegate {
    func handleError(_ error: NSError) {
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(title: "Oops!",
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert)

            let alertAction = UIAlertAction(title: "Ok",
                                            style: .default)
            alertController.addAction(alertAction)
            self?.present(alertController, animated: true)
        }
    }

    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
