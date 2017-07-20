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
    
    // MARK: - Outlets
    
    @IBOutlet weak var menuButton: UIButton! {
        didSet {
            menuButton.setTitle("Done", for: .normal)
            menuButton.backgroundColor = .grayBlue
            menuButton.tintColor = .white
            menuButton.layer.cornerRadius = 5
            menuButton.layer.borderWidth = 1
            menuButton.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @IBOutlet weak var infoLabel: UILabel! {
        didSet {
            infoLabel.textAlignment = .center
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            scoreLabel.textAlignment = .center
        }
    }
    
    @IBOutlet weak var modifierLabel: UILabel! {
        didSet {
            modifierLabel.textAlignment = .center
        }
    }
    
    @IBOutlet weak var totalScoreLabel: UILabel! {
        didSet {
            totalScoreLabel.textAlignment = .center
        }
    }
    
    @IBAction func goBackToMenu(_ sender: Any) {
        viewModel.goToMenu()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Score"
        
        navigationItem.setHidesBackButton(true, animated:true)
        
        viewModel.getTotalPoints()
        
        configure()
    }
    
    // MARK: - Utility
    
    func configure() {
        infoLabel.text = "Your score was:"
        scoreLabel.text = "\(viewModel.points)/10"
        modifierLabel.text = "\(viewModel.modifier)"
        totalScoreLabel.text = "Total score so far: \(viewModel.persistenceService.totalScore)"
    }
}
