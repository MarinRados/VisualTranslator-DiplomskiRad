//
//  InfoViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 19/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

class InfoViewController: BaseViewController {
    
    
    @IBOutlet weak var infoLabel: UILabel! {
        didSet {
            infoLabel.textAlignment = .left
            infoLabel.text = "1. Choose a language you want to learn.\n\n2. Take a picture.\n\n3. Accept one of the recognition results and save the item.\n\n4. Take quizes to test your knowledge in the selected language.\nNote: Quizes require at least 10 items in your library.\n\n5. You can take easy or a hard quiz, with pictures or without. \nQuizes are formed out of 10 questions. \nEach quiz has a multiplier that applies to the score. Easy with pictures x1, hard with pictures x2, easy without pictures x3 and hard without pictures x4.\n\n6. Your score is added to your total score.\n\nHave fun learning new languages!"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Info"
    }
}
