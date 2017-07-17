//
//  QuizWithPicturesViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 14/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

class QuizWithPicturesViewController: BaseViewController {
    
    var question: QuizQuestion!
    var onNextPage: (() -> Void)?
    var isCorrect: Bool = false
    var correctAnswer: String = ""
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
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
    
    @IBAction func goToNextPage(_ sender: Any) {
        onNextPage?()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        configure()
    }
    
    func configure() {
        wordLabel.text = question.originalText
        correctAnswer = question.translatedText
        if let data = question.image {
            let image = UIImage(data: data)?.fixOrientation()
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
        }
    }
}
