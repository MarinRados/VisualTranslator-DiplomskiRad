//
//  CameraViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 07/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

class CameraViewController: BaseViewController, ImagePickerControllerPresenter {

    // Outlets
    
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
    
    // MARK: - User interaction
    
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        presentImagePickerController { [weak self] image in
            if let data = image.uploadData(resizedToWidth: 100) {
                //self?.viewModel.imageData = data
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Take a picture"
    }

}
