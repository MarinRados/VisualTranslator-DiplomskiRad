//
//  LanguageCell.swift
//  VisualTranslator
//
//  Created by Marin Rados on 14/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell {
    
    @IBOutlet weak var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        style()
    }
    
    private func style() {
        backgroundColor = .background
        languageLabel.textColor = .white
    }
}
