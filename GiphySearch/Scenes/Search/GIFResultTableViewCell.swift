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
    
    lazy var gifImageView: UIImageView = {
        let resultImageView = UIImageView()
        self.addSubview(resultImageView)
        resultImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        resultImageView.contentMode = .scaleAspectFit
        return resultImageView
    }()
    
    func fillWithURL(_ gifURL: URL) {
        gifImageView.image = nil
        gifImageView.af_cancelImageRequest()
        gifImageView.af_setImage(withURL: gifURL)
    }
}
