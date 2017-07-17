//
//  QuizWithoutPicturesViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 17/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

class QuizWithoutPicturesViewController: BaseViewController {

    var question: QuizQuestion!
    var onNextPage: (() -> Void)?
    var isCorrect: Bool = false
    var correctAnswer: String = ""
    
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
        if textField.text == correctLabel.text {
            correctLabel.textColor = .green
            correctLabel.text = "Correct!"
        } else {
            correctLabel.textColor = .red
            correctLabel.text = "Incorrect!"
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
    }

    func configure() {
        wordLabel.text = question.originalText
        correctAnswer = question.translatedText
    }
}
