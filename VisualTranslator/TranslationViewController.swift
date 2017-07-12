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
    
    @IBOutlet weak var firstChoiceButton: UIButton! {
        didSet {
            firstChoiceButton.backgroundColor = .black
            firstChoiceButton.tintColor = .white
        }
    }
    
    @IBOutlet weak var secondChoiceButton: UIButton! {
        didSet {
            secondChoiceButton.backgroundColor = .black
            secondChoiceButton.tintColor = .white
        }
    }
    
    @IBOutlet weak var thirdChoiceButton: UIButton! {
        didSet {
            thirdChoiceButton.setTitle("", for: .normal)
            thirdChoiceButton.backgroundColor = .black
            thirdChoiceButton.tintColor = .white
        }
    }
    
    @IBOutlet weak var fourthChoiceButton: UIButton! {
        didSet {
            fourthChoiceButton.setTitle("", for: .normal)
            fourthChoiceButton.backgroundColor = .black
            fourthChoiceButton.tintColor = .white
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
    
    // MARK: - User Interaction
    
    @IBAction func changeTranslation(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        viewModel.translate(title)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Translation"
        
        viewModel.getRecognition { [weak self] recognitions in
            self?.firstChoiceButton.setTitle(recognitions[0], for: .normal)
            self?.secondChoiceButton.setTitle(recognitions[1], for: .normal)
            self?.thirdChoiceButton.setTitle(recognitions[2], for: .normal)
            self?.fourthChoiceButton.setTitle(recognitions[3], for: .normal)
        }
        
        viewModel.onTranslation = { [weak self] translation in
            self?.translationLabel.text = translation
        }
    }

}
