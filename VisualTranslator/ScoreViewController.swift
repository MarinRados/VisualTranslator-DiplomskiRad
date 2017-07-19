//
//  ScoreViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 19/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

class ScoreViewController: BaseViewController {

    var viewModel: ScoreViewModel!
    
    @IBOutlet weak var menuButton: UIButton! {
        didSet {
            menuButton.setTitle("Done", for: .normal)
            menuButton.backgroundColor = .black
            menuButton.tintColor = .white
            menuButton.layer.cornerRadius = 5
            menuButton.layer.borderWidth = 1
            menuButton.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    
    @IBAction func goBackToMenu(_ sender: Any) {
        viewModel.goToMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Score"
        
        navigationItem.setHidesBackButton(true, animated:true)
    }
}
