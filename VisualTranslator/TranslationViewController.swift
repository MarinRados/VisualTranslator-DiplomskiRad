//
//  TranslationViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 08/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

final class TranslationViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            if let data = viewModel.image {
                imageView.image = UIImage(data: data)
            }
        }
    }
    
    // MARK: - Dependencies
    
    var viewModel: TranslationViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Translation"
    }

}
