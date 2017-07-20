//
//  QuizPageViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 14/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

class QuizPageViewController: UIPageViewController {

    var viewModel: QuizPageViewModel!
    var questionViewControllers: [UIViewController] = []
    var currentIndex = 0
    var points = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        prepareQuestions()
        
        if let firstVC = questionViewControllers.first {
            self.navigationItem.title = "\(currentIndex + 1)/10"
            setViewControllers([firstVC],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            currentIndex += 1
        }
    }
    
    func prepareQuestions() {
        let questions = viewModel.getQuestions(language: viewModel.language, difficulty: viewModel.pickedDifficulty)
        
        if viewModel.withImage {
            for question in questions {
                let vc = QuizWithPicturesViewController.instance()
                vc.question = question
                vc.onNextPage = { isCorrect in
                    self.goToNextQuestion(isCorrect)
                }
                questionViewControllers.append(vc)
            }
        } else {
            for question in questions {
                let vc = QuizWithoutPicturesViewController.instance()
                vc.question = question
                vc.onNextPage = { isCorrect in
                    self.goToNextQuestion(isCorrect)
                }
                questionViewControllers.append(vc)
            }
        }
    }
    
    func goToNextQuestion(_ isCorrect: Bool) {
        if isCorrect {
            points += 1
        }
        if currentIndex == questionViewControllers.count {
            viewModel.goToScore(points: points, image: viewModel.withImage, difficulty: viewModel.pickedDifficulty)
        } else {
            self.navigationItem.title = "\(currentIndex + 1)/10"
            let vc = questionViewControllers[currentIndex]
            setViewControllers([vc],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            currentIndex += 1
        }
    }
}
