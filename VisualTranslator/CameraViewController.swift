//
//  CameraViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 07/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

final class CameraViewController: BaseViewController, ImagePickerControllerPresenter {

    //MARK: - Outlets
    
    @IBOutlet weak var cameraButton: UIButton! {
        didSet {
            cameraButton.tintColor = .white
            cameraButton.backgroundColor = .lightGray
            cameraButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
            cameraButton.layer.cornerRadius = 0.5 * cameraButton.bounds.size.width
            cameraButton.clipsToBounds = true
            cameraButton.setImage(#imageLiteral(resourceName: "ic_photo_camera_white").withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    @IBOutlet weak var changeLanguageButton: UIButton! {
        didSet {
            changeLanguageButton.setTitle("Change language", for: .normal)
            changeLanguageButton.backgroundColor = .black
            changeLanguageButton.tintColor = .white
        }
    }
    
    @IBOutlet weak var currentLanguageLabel: UILabel! {
        didSet {
            currentLanguageLabel.text = "Current language: German"
            currentLanguageLabel.textAlignment = .center
            currentLanguageLabel.textColor = .black
            currentLanguageLabel.font = .languageLabel
        }
    }
    
    // MARK: - Dependencies
    
    var viewModel: CameraViewModel!
    
    // MARK: - User interaction
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        presentImagePickerController { [weak self] image in
            if let data = image.uploadData(resizedToWidth: (self?.view.bounds.width)! - 40) {
                //TODO: - unwrap
                self?.viewModel.goToTranslation(image: data)
            }
        }
    }
    
    @IBAction func languageButtonTapped(_ sender: Any) {
            viewModel.goToLanguage()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Take a picture"
    }

}
