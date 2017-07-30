//
//  LanguageViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 14/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

final class LanguageViewController: BaseViewController {
    
    var viewModel: LanguageViewModel!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .background
        
        let dismissItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_clear_white"), style: .plain, target: self, action: #selector(dismissTapped))
        navigationItem.leftBarButtonItem = dismissItem
        
        navigationItem.title = "Choose a language"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = .tintColor
        tableView.tableFooterView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        tableView.tableFooterView?.backgroundColor = .tintColor
        
        style()
    }
    
    // MARK: - User interaction
    
    @objc
    private func dismissTapped() {
        viewModel.cancel()
    }
    
    // MARK: - Utility
    
    func style() {
        tableView.backgroundColor = .background
    }
}

extension LanguageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
        
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        cell.selectionStyle = .none
        cell.languageLabel.text = viewModel.languages[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.changeCurrentLanguage(to: viewModel.languages[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
