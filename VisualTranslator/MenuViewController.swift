//
//  MenuViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 07/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

final class MenuViewController: BaseViewController {

    var viewModel: MenuViewModel!
    
    @IBOutlet weak var easyQuizWithPicturesButton: UIButton! {
        didSet {
            easyQuizWithPicturesButton.setTitle("Easy quiz with pictures", for: .normal)
            easyQuizWithPicturesButton.backgroundColor = .buttons
            easyQuizWithPicturesButton.tintColor = .buttonTitle
            easyQuizWithPicturesButton.layer.cornerRadius = 5
            easyQuizWithPicturesButton.layer.borderWidth = 1
            easyQuizWithPicturesButton.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @IBOutlet weak var hardQuizWithPicturesButton: UIButton! {
        didSet {
            hardQuizWithPicturesButton.setTitle("Hard quiz with pictures", for: .normal)
            hardQuizWithPicturesButton.backgroundColor = .buttons
            hardQuizWithPicturesButton.tintColor = .buttonTitle
            hardQuizWithPicturesButton.layer.cornerRadius = 5
            hardQuizWithPicturesButton.layer.borderWidth = 1
            hardQuizWithPicturesButton.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @IBOutlet weak var easyQuizWithoutPictures: UIButton! {
        didSet {
            easyQuizWithoutPictures.setTitle("Easy quiz without pictures", for: .normal)
            easyQuizWithoutPictures.backgroundColor = .buttons
            easyQuizWithoutPictures.tintColor = .buttonTitle
            easyQuizWithoutPictures.layer.cornerRadius = 5
            easyQuizWithoutPictures.layer.borderWidth = 1
            easyQuizWithoutPictures.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @IBOutlet weak var hardQuizWithoutPicturesButton: UIButton!{
        didSet {
            hardQuizWithoutPicturesButton.setTitle("Hard quiz without pictures", for: .normal)
            hardQuizWithoutPicturesButton.backgroundColor = .buttons
            hardQuizWithoutPicturesButton.tintColor = .buttonTitle
            hardQuizWithoutPicturesButton.layer.cornerRadius = 5
            hardQuizWithoutPicturesButton.layer.borderWidth = 1
            hardQuizWithoutPicturesButton.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    // MARK: - User interaction
    
    @IBAction func createEasyQuizWithPictures(_ sender: Any) {
        viewModel.goToQuizWith(pictures: true, difficulty: .easy)
    }
    
    @IBAction func createHardQuizWithPictures(_ sender: Any) {
        viewModel.goToQuizWith(pictures: true, difficulty: .hard)
    }
    
    @IBAction func createEasyQuizWithoutPictures(_ sender: Any) {
        viewModel.goToQuizWith(pictures: false, difficulty: .easy)
    }
    
    @IBAction func createHardQuizWithoutPictures(_ sender: Any) {
        viewModel.goToQuizWith(pictures: false, difficulty: .hard)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .background
        
        navigationItem.title = "Take a quiz"
        
        viewModel.onError = { [weak self] error in
            self?.showAlert(title: error)
        }
    }

}
