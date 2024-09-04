//
//  ForgotPasswordVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 19/09/2023.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet var txt_email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func apiCAllAction(_ sender: UIButton){
        
        let isEmailTrue = StaticClass.isValidEmail(email: txt_email.text!)
        if txt_email.text?.isEmpty ?? true
        {
            showAlertAction(message: "Email is required")
            
        }else if isEmailTrue == false{
            
            showAlertAction(message: "Email is not valid")
            
        }else{
            callForgotPasswordApi()
        }
       
    }
    
    func callForgotPasswordApi()
    {
        let parameters = ForgotPasswordRequest(email: self.txt_email.text!)
        
        let forgotViewModel = ForgotPasswordViewModel()
        
        forgotViewModel.callForgotPassword(parameters: parameters) { response in
            
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
                
                if message == "Forget password code sent to email address successfully"
                {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdatePasswordVC") as! UpdatePasswordVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            // ...
        }

        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func goToBackScreen()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
