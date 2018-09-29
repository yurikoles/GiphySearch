//
//  FullGIFViewController.swift
//  Giphy Search
//
//  Created by Yurii Kolesnykov on 2018-09-29.
//  Copyright © 2018 yurikoles. All rights reserved.
//

import UIKit

class FullGIFViewController: UIViewController {
    fileprivate var fullGIFURL: URL!

    class func fullGIFViewController(_ fullGIFURL: URL) -> FullGIFViewController {
        let fullGIFViewController = FullGIFViewController()
        fullGIFViewController.fullGIFURL = fullGIFURL
        return fullGIFViewController
    }

    fileprivate lazy var gifImageView: UIImageView = {
        let resultImageView = UIImageView()
        self.view.addSubview(resultImageView)
        resultImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        resultImageView.contentMode = .scaleAspectFit
        return resultImageView
    }()

    fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .black
        gifImageView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })
        return activityIndicator
    }()

}

// MARK: - View life cycle
extension FullGIFViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadImgage()
    }
}

// MARK: Loading image
extension FullGIFViewController {
    func loadImgage() {
        activityIndicator.startAnimating()
        gifImageView.af_setImage(withURL: fullGIFURL,
                                 placeholderImage: nil,
                                 filter: nil,
                                 progress: nil,
                                 progressQueue: DispatchQueue.main,
                                 imageTransition: .noTransition,
                                 runImageTransitionIfCached: false) { [weak self ] _ in
            self?.activityIndicator.stopAnimating()
        }
    }
}
