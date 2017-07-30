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
    private var activityIndicator: UIActivityIndicatorView?
    var spinnerRelativeOffsetY: CGFloat = 0.9
    
    var viewModel: TranslationViewModel!

    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            if let data = viewModel.image {
                guard let image = UIImage(data: data) else { return }
                if (image.size.height > image.size.width) {
                    let fixedImage = UIImage(cgImage: (image.cgImage)!, scale: image.scale, orientation: UIImageOrientation.right)
                    imageView.image = fixedImage
                } else {
                    imageView.image = image
                }
                imageView.contentMode = .scaleAspectFit
            }
        }
    }
    
    @IBOutlet weak var firstChoiceButton: UIButton! {
        didSet {
            firstChoiceButton.backgroundColor = .selected
            firstChoiceButton.tintColor = .white
            firstChoiceButton.layer.cornerRadius = 5
            firstChoiceButton.layer.borderWidth = 1
            firstChoiceButton.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @IBOutlet weak var secondChoiceButton: UIButton! {
        didSet {
            secondChoiceButton.backgroundColor = .buttons
            secondChoiceButton.tintColor = .buttonTitle
            secondChoiceButton.layer.cornerRadius = 5
            secondChoiceButton.layer.borderWidth = 1
            secondChoiceButton.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @IBOutlet weak var thirdChoiceButton: UIButton! {
        didSet {
            thirdChoiceButton.setTitle("", for: .normal)
            thirdChoiceButton.backgroundColor = .buttons
            thirdChoiceButton.tintColor = .buttonTitle
            thirdChoiceButton.layer.cornerRadius = 5
            thirdChoiceButton.layer.borderWidth = 1
            thirdChoiceButton.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @IBOutlet weak var fourthChoiceButton: UIButton! {
        didSet {
            fourthChoiceButton.setTitle("", for: .normal)
            fourthChoiceButton.backgroundColor = .buttons
            fourthChoiceButton.tintColor = .buttonTitle
            fourthChoiceButton.layer.cornerRadius = 5
            fourthChoiceButton.layer.borderWidth = 1
            fourthChoiceButton.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @IBOutlet weak var translationLabel: UILabel! {
        didSet {
            translationLabel.text = "Translation"
            translationLabel.textAlignment = .center
            translationLabel.textColor = .tintColor
            translationLabel.font = .mediumLabel
        }
    }
    
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.setTitle("Save", for: .normal)
            saveButton.backgroundColor = .buttons
            saveButton.tintColor = .buttonTitle
            saveButton.layer.cornerRadius = 5
            saveButton.layer.borderWidth = 1
            saveButton.layer.borderColor = UIColor.clear.cgColor
        }
    }

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
        sender.backgroundColor = .selected
        sender.tintColor = .white
        currentOriginalText = sender.currentTitle
    }
    
    @objc
    private func dismissTapped() {
        viewModel.cancel()
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Translation"
        
        self.view.backgroundColor = .background
        
        viewModel.onStartedActivity  = { [weak self] in
            self?.showSpinner()
            self?.view.isUserInteractionEnabled = false
            self?.saveButton.backgroundColor = UIColor.buttons.withAlphaComponent(0.5)
        }
        
        viewModel.onEndedActivity = { [weak self] in
            self?.stopSpinner()
            self?.view.isUserInteractionEnabled = true
            self?.saveButton.backgroundColor = .buttons
        }
        
        viewModel.onTranslation = { [weak self] translation in
            self?.translationLabel.text = translation
        }
        
        viewModel.onError = { [weak self] error in
            let alert = UIAlertController(title: error, message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self?.viewModel.cancel()
            }))
            
            self?.present(alert, animated: true, completion: nil)
        }
        
        viewModel.onItemSaved = { [weak self] in
            self?.view.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.1, animations: {
                self?.saveButton.backgroundColor = UIColor.buttons.withAlphaComponent(0.5)
                self?.saveButton.setTitle("SAVED!", for: .normal)
            })
        }
        
        viewModel.getRecognition { [weak self] recognitions in
            self?.firstChoiceButton.setTitle(recognitions[0], for: .normal)
            guard let firstButtonTitle = self?.firstChoiceButton.currentTitle else { return }
            self?.currentOriginalText = firstButtonTitle
            self?.viewModel.translate(firstButtonTitle)
            self?.secondChoiceButton.setTitle(recognitions[1], for: .normal)
            self?.thirdChoiceButton.setTitle(recognitions[2], for: .normal)
            self?.fourthChoiceButton.setTitle(recognitions[3], for: .normal)
        }
    }

    // MARK: - Utility
    
    private func resetAllButtons() {
        firstChoiceButton.backgroundColor = .buttons
        firstChoiceButton.tintColor = .buttonTitle
        secondChoiceButton.backgroundColor = .buttons
        secondChoiceButton.tintColor = .buttonTitle
        thirdChoiceButton.backgroundColor = .buttons
        thirdChoiceButton.tintColor = .buttonTitle
        fourthChoiceButton.backgroundColor = .buttons
        fourthChoiceButton.tintColor = .buttonTitle
    }
    
    func showSpinner() {
        spinner.startAnimating()
        view.bringSubview(toFront: spinner)
    }
    
    func stopSpinner() {
        guard activityIndicator != nil else { return }
        spinner.stopAnimating()
    }
    
    private var spinner: UIActivityIndicatorView {
        if let spinner = activityIndicator {
            return spinner
        } else {
            return createSpinnerIfNeeded()
        }
        
    }
    
    private func createSpinnerIfNeeded() -> UIActivityIndicatorView {
        guard activityIndicator == nil else { return activityIndicator!}
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.color = .white
        view.addSubview(spinner)
        spinner.center = CGPoint(x: view.center.x, y: view.center.y * spinnerRelativeOffsetY * 2.0 )
        activityIndicator = spinner
        return spinner
    }
}
