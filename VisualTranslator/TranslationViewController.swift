//
//  TranslationViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 08/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

final class TranslationViewController: UIViewController {
    
    var currentOriginalText: String?

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
            firstChoiceButton.backgroundColor = .gray
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
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let translation = translationLabel.text else { return }
        guard let image = viewModel.image else { return }
        guard let original = currentOriginalText else { return }
        viewModel.saveItem(original: original, translation: translation, image: image)
    }
    
    @IBAction func translationButtonTapped(_ sender: UIButton) {
        resetAllButtons()
        sender.backgroundColor = .gray
        sender.tintColor = .white
        currentOriginalText = sender.currentTitle
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Translation"
        
        viewModel.getRecognition { [weak self] recognitions in
            self?.firstChoiceButton.setTitle(recognitions[0], for: .normal)
            guard let firstButtonTitle = self?.firstChoiceButton.currentTitle else { return }
            self?.currentOriginalText = firstButtonTitle
            self?.viewModel.translate(firstButtonTitle)
            self?.secondChoiceButton.setTitle(recognitions[1], for: .normal)
            self?.thirdChoiceButton.setTitle(recognitions[2], for: .normal)
            self?.fourthChoiceButton.setTitle(recognitions[3], for: .normal)
        }
        
        viewModel.onTranslation = { [weak self] translation in
            self?.translationLabel.text = translation
        }
        
        viewModel.onError = { [weak self] error in
            self?.showAlert(title: error)
        }
    }

    // MARK: - Utility
    
    private func resetAllButtons() {
        firstChoiceButton.backgroundColor = .black
        firstChoiceButton.tintColor = .white
        secondChoiceButton.backgroundColor = .black
        secondChoiceButton.tintColor = .white
        thirdChoiceButton.backgroundColor = .black
        thirdChoiceButton.tintColor = .white
        fourthChoiceButton.backgroundColor = .black
        fourthChoiceButton.tintColor = .white
    }
}
