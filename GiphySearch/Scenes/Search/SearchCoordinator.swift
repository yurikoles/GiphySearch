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
    var rootNavigationController: UINavigationController!

    init(mainDelegate: CoodinatorDelegate) {
        self.mainDelegate = mainDelegate
    }

    func start(nc: UINavigationController) {
        rootNavigationController = nc
        nc.pushViewController(SearchViewContoller.searchViewController(self), animated: true)
    }
}

//MARK: - SearchViewControllerDelegate
extension SearchCoordinator: SearchViewControllerDelegate {
    func showDetails(_ originalURL: URL) {
        let fullGIFViewController = FullGIFViewController()
        fullGIFViewController.fullGIFURL = originalURL
        
        rootNavigationController.pushViewController(fullGIFViewController,
                                                    animated: true)
    }
}
