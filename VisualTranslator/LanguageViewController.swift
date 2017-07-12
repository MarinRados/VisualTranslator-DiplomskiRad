//
//  LanguageViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 14/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

final class LanguageViewController: UIViewController {
    
    var viewModel: LanguageViewModel!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dismissItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_clear_white"), style: .plain, target: self, action: #selector(dismissTapped))
        navigationItem.leftBarButtonItem = dismissItem
        
        navigationItem.title = "Choose a language"
        
        style()
    }
    
    @objc
    private func dismissTapped() {
        viewModel.cancel()
    }
    
    func style() {
        tableView.backgroundColor = .white
    }
}

extension LanguageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
        
        return cell
    }
}
