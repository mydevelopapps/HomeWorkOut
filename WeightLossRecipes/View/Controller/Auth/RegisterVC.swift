//
//  RegisterVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 06/09/2023.
//

import Foundation
import UIKit

class RegisterVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var regViewModel = RegisterViewModel()
    @IBOutlet var txt_firstname:UITextField!
    @IBOutlet var txt_lastname :UITextField!
    @IBOutlet var txt_email :UITextField!
    @IBOutlet var txt_password :UITextField!
    
    @IBOutlet var img_profile : UIImageView!
    
    let imagePicker = UIImagePickerController()
    var deviceID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))

        img_profile.addGestureRecognizer(tapGesture)
        
        // Usage example:
        let profileImage = UIImage(named: "profile_image.jpg") // Replace with your image
        let registerURL = registerURL // Replace with your registration endpoint URL
       // regViewModel.uploadProfileImage(image: profileImage!, registerURL: registerURL)
        
        //regViewModel.callRegisterPostApi()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToBackScreen()
    {
        self.navigationController?.popViewController(animated: true)
    }
 
    @IBAction func registerUserAction(_ sender: UIButton)
    {
        let isEmailTrue = StaticClass.isValidEmail(email: txt_email.text!)
        
        if txt_firstname.text?.isEmpty ?? true ||
            txt_lastname.text?.isEmpty ?? true ||
            txt_email.text?.isEmpty ?? true ||
            txt_password.text?.isEmpty ?? true {
            showAlertAction(message: "All fields must be filled out")
            
            }else if isEmailTrue == false{
                
                showAlertAction(message: "Email is not valid")
                
            } else {
                  signUpApiCall()
              }
        
    }
    
    func showAlertAction(message: String)
    {
        let alertController = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )

     
        let confirmAction = UIAlertAction(
            title: "OK", style: UIAlertAction.Style.default) { (action) in
            
            if message == "User register successfully"
                {
                StaticClass.setupHomeRoot()
            }
                
        }

        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
    
   
    
    func signUpApiCall(){
       
        if let deviceId = StaticClass.getDeviceUUID()
        {
            deviceID = deviceId
        }else
        {
            deviceID = "ababababababab"
        }
        let profileImage = img_profile.image! // Get the selected image from your UIImageView
        let signupParameters = SignUp(first_name: txt_firstname.text, last_name: txt_lastname.text, email: txt_email.text, password: txt_password.text, device_type: "ios", device_id: deviceID, timezone: StaticClass.getTimeZone())
        
        let userViewModel = RegisterViewModel()
        userViewModel.signupApirequest(signUpParameters: signupParameters, image: profileImage)
        { userModel in

            if userModel.success == "true"
            {
                print(userModel.data)
                self.showAlertAction(message: "User register successfully")
            } else {
                print(userModel.success)
            }
//            self.parentVC.dissmissActivity()
        }onFailure: { error in

            print(error)
            self.showAlertAction(message: error)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer)
    {
        showImagePicker()
    }

    func showImagePicker() {
        
        let alertController = UIAlertController(title: "choose photo", message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "camera", style: .default) { (_) in
            
            self.openCamera()
        }
        
        let gallery = UIAlertAction(title: "gallery", style: .default) { (_) in
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
            img_profile.image = pickedImage
            img_profile.layer.cornerRadius = img_profile.frame.size.width / 2
            img_profile.clipsToBounds = true
            img_profile.image = image(with: img_profile.image!, scaledTo: CGSize(width: 120, height: 120))
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func image(with image: UIImage, scaledTo newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    
   
}
