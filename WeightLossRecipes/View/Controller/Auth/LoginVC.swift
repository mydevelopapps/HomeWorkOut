//
//  LoginVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 06/09/2023.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {

    @IBOutlet var txt_email: UITextField!
    @IBOutlet var txt_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func validateForm()-> (Bool, String){
        
        guard let email = txt_email.text, email != "" else {
            return (false,"please enter email address")
        }
        
        guard let password = txt_password.text, password != "" else {
           return (false,"please enter password")
        }
        
        return (true,"")
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
                
                if message == "Logged in successfully"
                {
                    StaticClass.setupHomeRoot()
                }
            // ...
        }

        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func apiCAllAction(_ sender: UIButton){
        
        let isEmailTrue = StaticClass.isValidEmail(email: txt_email.text!)
        if txt_email.text?.isEmpty ?? true || txt_password.text?.isEmpty ?? true
            
        {
            showAlertAction(message: "All fields are required")
            
        }else if isEmailTrue == false{
            
            showAlertAction(message: "Email is not valid")
            
        }else{
            
            callLoginApi()
        }
       
    }
    
    func callLoginApi()
    {
        let parameters = LoginRequest(email: txt_email.text, password: txt_password.text, device_type: "ios", device_id: StaticClass.getDeviceUUID(), timezone: StaticClass.getTimeZone())
        
        let loginViewModel = LoginViewModel()
        
        loginViewModel.callLoginApi(parameters: parameters) { response in
            
            if  response.success == "true"{
                print(response.data)
                
                print(response.data.user.firstName!)
                print(response.data.user.lastName!)
                print(response.data.token!)
                print(response.data.user.email!)
                print(response.data.user.profileImage!)
                print("\(response.data.user.firstName!) \(response.data.user.lastName!)")
                
                KeychainManager.shared.setUserName("\(response.data.user.firstName!) \(response.data.user.lastName!)")
                KeychainManager.shared.setUserEmail(response.data.user.email!)
                //KeychainManager.shared.setDeviceToken(response.data.token)
                KeychainManager.shared.setUserToken(response.data.token!)
                KeychainManager.shared.setUserId(response.data.user.id!)
                KeychainManager.shared.setUserProfileImage(response.data.user.profileImage!)
               
                self.showAlertAction(message: response.message!)
                
            } else {
                
                print(response.success)
                self.showAlertAction(message: response.message!)
            }
            
        } onFailure: { error in
            
            print(error)
            self.showAlertAction(message: error)
        }
    }
    
    @IBAction func goToBackScreen()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerVC(_ sender: UIButton)
    {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    @IBAction func skipVC(_ sender: UIButton)
    {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
}
