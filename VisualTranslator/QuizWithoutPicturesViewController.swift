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
    
    var isCorrect: Bool = false
    var correctAnswer: String = ""
    
    // MARK: - Outlets
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var correctLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.setTitle("Next", for: .normal)
            nextButton.backgroundColor = .black
            nextButton.tintColor = .white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }

    func configure() {
        wordLabel.text = question.originalText
        correctAnswer = question.translatedText
    }
}
