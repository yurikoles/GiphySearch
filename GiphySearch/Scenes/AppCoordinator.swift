//
//  AppCoordinator.swift
//  GiphySearch
//
//  Created by Yurii Kolesnykov on 2018-09-27.
//  Copyright © 2018 yurikoles. All rights reserved.
//

import Foundation
import UIKit

protocol CoodinatorDelegate: class {
    func needsChangeCoordinator(to coordinatorType: CoordinatorFlow)
}

enum CoordinatorFlow {
    case Search
}

class AppCoordinator {

    let window: UIWindow
    private let navigationController = UINavigationController()
    private var childCoordinators = [AnyObject]()
    private var isLogined = false

    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        self.start()
    }

    fileprivate func searchFlow() {
        self.navigationController.navigationBar.isHidden = false
        let mainCoordinator = SearchCoordinator(mainDelegate: self)
        childCoordinators.append(mainCoordinator)
        mainCoordinator.start(nc: navigationController)
    }

    func start() {
        changeFlow(type: .Search)
    }

    func changeFlow(type: CoordinatorFlow) {
        _ = childCoordinators.popLast()
        switch type {
        case .Search:
            searchFlow()
        }
    }
}

extension AppCoordinator: CoodinatorDelegate {
    func needsChangeCoordinator(to coordinatorType: CoordinatorFlow) {
        changeFlow(type: coordinatorType)
    }
}
