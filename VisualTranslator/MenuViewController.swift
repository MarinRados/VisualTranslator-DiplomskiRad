//
//  MenuViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 07/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

final class MenuViewController: BaseViewController {

    
    @IBOutlet weak var easyQuizWithPicturesButton: UIButton! {
        didSet {
            easyQuizWithPicturesButton.setTitle("Easy quiz with pictures", for: .normal)
            easyQuizWithPicturesButton.backgroundColor = .black
            easyQuizWithPicturesButton.tintColor = .white
        }
    }
    
    @IBOutlet weak var hardQuizWithPicturesButton: UIButton! {
        didSet {
            hardQuizWithPicturesButton.setTitle("Hard quiz with pictures", for: .normal)
            hardQuizWithPicturesButton.backgroundColor = .black
            hardQuizWithPicturesButton.tintColor = .white
        }
    }
    
    @IBOutlet weak var easyQuizWithoutPictures: UIButton! {
        didSet {
            easyQuizWithoutPictures.setTitle("Easy quiz without pictures", for: .normal)
            easyQuizWithoutPictures.backgroundColor = .black
            easyQuizWithoutPictures.tintColor = .white
        }
    }
    
    @IBOutlet weak var hardQuizWithoutPicturesButton: UIButton!{
        didSet {
            hardQuizWithoutPicturesButton.setTitle("Hard quiz without pictures", for: .normal)
            hardQuizWithoutPicturesButton.backgroundColor = .black
            hardQuizWithoutPicturesButton.tintColor = .white
        }
    }
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Take a quiz"
    }

}
