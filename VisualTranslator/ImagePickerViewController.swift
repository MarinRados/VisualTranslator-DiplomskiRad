//
//  ImagePickerViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 08/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

protocol ImagePickerControllerPresenter: class {
    func presentImagePickerController(onImagePicked: @escaping (UIImage) -> Void)
}

extension ImagePickerControllerPresenter where Self: UIViewController {
    
    func presentImagePickerController(onImagePicked: @escaping (UIImage) -> Void) {
        
        let actionController = UIAlertController(title: "Image", message: nil, preferredStyle: .actionSheet)
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { _ in
            self.showImagePicker(.gallery, onImagePicked: onImagePicked)
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.showImagePicker(.camera, onImagePicked: onImagePicked)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionController.addAction(galleryAction)
        actionController.addAction(cameraAction)
        actionController.addAction(cancelAction)
        
        present(actionController, animated: true, completion: nil)
    }
    
    private func showImagePicker(_ type: ImagePickerViewController.PickerType, onImagePicked: @escaping (UIImage) -> Void) {
        
        let viewController = ImagePickerViewController()
        viewController.pickerType = type
        
        viewController.onImagePicked(onImagePicked)
        present(viewController, animated: true, completion: nil)
    }
}

class ImagePickerViewController: UIViewController, UINavigationControllerDelegate {
    
    enum PickerType {
        case camera
        case gallery
    }
    
    // MARK: - Customization
    
    var pickerType: PickerType = .camera
    
    // MARK: - Callbacks
    
    fileprivate var imagePickedCallback: ((UIImage) -> Void)?
    fileprivate var cancelCallback: (() -> Void)?
    
    func onImagePicked(_ callback: @escaping (UIImage) -> Void) {
        self.imagePickedCallback = callback
    }
    
    func didCancel(_ callback: @escaping () -> Void) {
        self.cancelCallback = callback
    }
    
    // MARK: - Dependencies
    
    private var imagePickerController = UIImagePickerController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imagePickerController.view)
        view.bringSubview(toFront: imagePickerController.view)
        
        imagePickerController.delegate = self
        view.backgroundColor = .black
        
        switch pickerType {
        case .camera: showCamera()
        case .gallery: showGallery()
        }
    }
    
    private func showCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showGallery()
            return
        }
        
        imagePickerController.sourceType = .camera
    }
    
    private func showGallery() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            cancelCallback?()
            return
        }
    }
}

extension ImagePickerViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickedCallback?(image)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
