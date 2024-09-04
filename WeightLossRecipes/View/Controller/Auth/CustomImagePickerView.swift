//
//  CustomImagePickerView.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 07/09/2023.
//

import UIKit

class CustomImagePickerView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the delegate to self to handle image picker events
        imagePicker.delegate = self
    }
    
    func showImagePicker() {
        
        let alertController = UIAlertController(title: "choose photo", message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "open camera", style: .default) { (_) in
            
            self.openCamera()
        }
        
        let gallery = UIAlertAction(title: "open gallery", style: .default) { (_) in
            self.openGallery()
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel) { (_) in
            
        }
        
        // Add the actions to the alert controller
        alertController.addAction(camera)
        alertController.addAction(gallery)
        alertController.addAction(cancel)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
      
    }
    
    
    func openCamera()
    {
        
        if  UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true)
            
        }else{
            // camera not available
        }
        
    }
    
    func openGallery()
    {
        if  UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true)
            
        }else{
            // photo library not available
        }
        
    }
    // Implement UIImagePickerControllerDelegate methods here
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Handle the selected image
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Do something with the picked image
            
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Additional custom view controller logic here
}
