//
//  QuizWithoutPicturesViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 17/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

class QuizWithoutPicturesViewController: BaseViewController, UITextFieldDelegate {

    var question: QuizQuestion!
    var onNextPage: (() -> Void)?
    var isCorrect: Bool = false
    var correctAnswer: String = ""
    let correctAnswerNotification: [String] = ["Correct!", "Great!", "Nice! Keep it up.", "Good job!", "Excellent!"]
    let incorrectAnswerNotification: [String] = ["Incorrect!", "You can do it next time!", "Close, try again!", "Wrong answer!"]
    
    // MARK: - Outlets
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var correctLabel: UILabel! {
        didSet {
            correctLabel.text = ""
        }
    }
    
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.setTitle("Next", for: .normal)
            nextButton.backgroundColor = .black
            nextButton.tintColor = .white
        }
    }
    
    @IBAction func goToNextPage(_ sender: Any) {
        view.isUserInteractionEnabled = false
        if textField.text?.lowercased() == correctAnswer.lowercased() {
            correctLabel.textColor = .green
            let randomIndex = Int(arc4random_uniform(UInt32(correctAnswerNotification.count)))
            correctLabel.text = correctAnswerNotification[randomIndex]
        } else {
            correctLabel.textColor = .red
            let randomIndex = Int(arc4random_uniform(UInt32(incorrectAnswerNotification.count)))
            correctLabel.text = incorrectAnswerNotification[randomIndex]
        }
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.onNextPage?()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        configure()
        
        textField.delegate = self
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    func configure() {
        wordLabel.text = question.originalText
        correctAnswer = question.translatedText
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
