//
//  ViewController.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 19/09/2023.
//

import UIKit

class DeleteMyAccount: UIViewController {

    @IBOutlet var txt_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func apiCAllAction(_ sender: UIButton){
        
        if txt_password.text?.isEmpty ?? true
        {
            showAlertAction(message: "Password is required")
            
        }else{
            
            callDeleteMyAccountApi()
        }
       
    }
    
    func callDeleteMyAccountApi()
    {
        let parameters = DeleteAccountRequest(password: txt_password.text!)
        
        let deleteViewModel = DeleteAccountViewModal()
        
        deleteViewModel.callDeleteAccountApi(parameters: parameters) { response in
            
            if  response.success == "true"{
                print(response.message)
                
                self.showAlertAction(message: response.message!)
                
                
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
                
                if message == "User account removed."
                {
                    KeychainManager.shared.deleteKeychain(for: "Email")
                    KeychainManager.shared.deleteKeychain(for: "Password")
                    KeychainManager.shared.deleteKeychain(for: "userToken")
                    KeychainManager.shared.deleteKeychain(for: "userId")
                    KeychainManager.shared.deleteKeychain(for: "devicetoken")
                    KeychainManager.shared.deleteKeychain(for: "profileImage")
                    StaticClass.setupAuthRoot()
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
