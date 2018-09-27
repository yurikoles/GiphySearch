//
//  FullGIFViewController.swift
//  Giphy Search
//
//  Created by Yurii Kolesnykov on 2018-09-29.
//  Copyright © 2018 yurikoles. All rights reserved.
//

import UIKit

class FullGIFViewController: UIViewController {
    fileprivate lazy var gifImageView: UIImageView = {
        let resultImageView = UIImageView()
        self.view.addSubview(resultImageView)
        resultImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        resultImageView.contentMode = .scaleAspectFit
        return resultImageView
    }()
    
    open var fullGIFURL: URL? = nil {
        didSet {
            guard let fullGIFURL = fullGIFURL else {return}
            gifImageView.af_setImage(withURL: fullGIFURL)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
