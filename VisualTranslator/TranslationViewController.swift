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
                let image = UIImage(data: data)?.fixOrientation()
                imageView.image = image
                imageView.contentMode = .scaleAspectFit
            }
        }
    }
    
    @IBOutlet weak var recognitionLabel: UILabel! {
        didSet {
            recognitionLabel.text = "Recognition"
            recognitionLabel.textAlignment = .center
            recognitionLabel.textColor = .black
            recognitionLabel.font = .languageLabel
        }
    }
    
    @IBOutlet weak var translationLabel: UILabel! {
        didSet {
            translationLabel.text = "Translation"
            translationLabel.textAlignment = .center
            translationLabel.textColor = .black
            translationLabel.font = .languageLabel
        }
    }
    
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.setTitle("Save", for: .normal)
            saveButton.backgroundColor = .black
            saveButton.tintColor = .white
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
