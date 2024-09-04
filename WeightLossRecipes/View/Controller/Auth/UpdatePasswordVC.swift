//
//  UpdatePasswordVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 19/09/2023.
//

import UIKit

class UpdatePasswordVC: UIViewController {

    @IBOutlet var txt_email: UITextField!
    @IBOutlet var txt_code: UITextField!
    @IBOutlet var txt_passwordnew: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func apiCAllAction(_ sender: UIButton){
        
        let isEmailTrue = StaticClass.isValidEmail(email: txt_email.text!)
        if txt_email.text?.isEmpty ?? true || txt_code.text?.isEmpty ?? true
            || txt_passwordnew.text?.isEmpty ?? true
        {
            showAlertAction(message: "All fields are required")
        }else if isEmailTrue == false{
            
            showAlertAction(message: "Email is not valid")
            
        }else{
            
            callUpdatePasswordApi()
        }
       
    }
    
    func callUpdatePasswordApi()
    {
        let parameters = UpdatePasswordRequest(email: txt_email.text!, code: txt_code.text!, new_password: txt_passwordnew.text!)
        
        let forgotViewModel = ForgotPasswordViewModel()
        
        forgotViewModel.callUpdatePassword(parameters: parameters) { response in
            
            if  response.success == "true"{
                print(response.message)
                
                self.showAlertAction(message: response.message)
                
                
            } else {
                print(response.success)
            }
            
        } onFailure: { error in
            
            print(error)
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
                
                if message == "Password updated successfully"
                {
                    StaticClass.setupHomeRoot()
                }
           
        }

        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func goToBackScreen()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
