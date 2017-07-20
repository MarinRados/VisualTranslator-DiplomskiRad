//
//  QuizWithPicturesViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 14/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

class QuizWithPicturesViewController: BaseViewController, UITextFieldDelegate {
    
    var question: QuizQuestion!
    var onNextPage: ((Bool) -> Void)?
    var isCorrect: Bool = false
    var correctAnswer: String = ""
    var delay = DispatchTime.now()
    let correctAnswerNotification: [String] = ["Correct!", "Great!", "Nice! Keep it up.", "Good job!", "Excellent!"]
    let incorrectAnswerNotification: [String] = ["Incorrect!", "You can do it next time!", "Try again!", "Wrong answer!"]
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var correctLabel: UILabel! {
        didSet {
            correctLabel.text = ""
        }
    }
    
    @IBOutlet weak var answerLabel: UILabel! {
        didSet {
            answerLabel.text = ""
        }
    }
    
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.setTitle("Next", for: .normal)
            nextButton.backgroundColor = .grayBlue
            nextButton.tintColor = .white
            nextButton.layer.cornerRadius = 5
            nextButton.layer.borderWidth = 1
            nextButton.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    // MARK: - User interaction
    
    @IBAction func goToNextPage(_ sender: Any) {
        view.isUserInteractionEnabled = false
        if textField.text?.lowercased() == correctAnswer.lowercased() {
            isCorrect = true
            correctLabel.textColor = .cyan
            let randomIndex = Int(arc4random_uniform(UInt32(correctAnswerNotification.count)))
            correctLabel.text = correctAnswerNotification[randomIndex]
            delay = DispatchTime.now() + 1
        } else {
            isCorrect = false
            correctLabel.textColor = .darkRed
            let randomIndex = Int(arc4random_uniform(UInt32(incorrectAnswerNotification.count)))
            correctLabel.text = incorrectAnswerNotification[randomIndex]
            answerLabel.text = "Correct answer was: \(correctAnswer)"
            delay = DispatchTime.now() + 1.5
        }
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.onNextPage?(self.isCorrect)
        }
    }
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        configure()
        
        textField.delegate = self
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    // MARK: - Utility
    
    func configure() {
        wordLabel.text = question.originalText
        correctAnswer = question.translatedText
        if let data = question.image {
            let image = UIImage(data: data)?.fixOrientation()
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
