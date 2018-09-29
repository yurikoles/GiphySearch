//
//  GIFResultTableViewCell.swift
//  Giphy Search
//
//  Created by Yurii Kolesnykov on 2018-09-29.
//  Copyright © 2018 yurikoles. All rights reserved.
//

import UIKit
import SnapKit

class GIFResultTableViewCell: UITableViewCell {
    static let reuseIdentifier = "GIFResultTableViewCell"

    fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .black
        gifImageView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })
        return activityIndicator
    }()

    fileprivate lazy var gifImageView: UIImageView = {
        let gifImageView = UIImageView()
        self.addSubview(gifImageView)
        gifImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        gifImageView.contentMode = .scaleAspectFit
        return gifImageView
    }()
}

// MARK: Fill image
extension GIFResultTableViewCell {
    func fillWithURL(_ gifURL: URL) {
        gifImageView.image = nil
        gifImageView.af_cancelImageRequest()
        activityIndicator.startAnimating()
        gifImageView.af_setImage(withURL: gifURL,
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
