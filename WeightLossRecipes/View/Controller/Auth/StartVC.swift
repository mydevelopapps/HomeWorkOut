//
//  StartVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 13/09/2023.
//

import UIKit

class StartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(KeychainManager.shared.getUserName())
        print(KeychainManager.shared.getUserEmail())
        print(KeychainManager.shared.getDeviceToken())
        
        // Do any additional setup after loading the view.
    }
    

   
    

}
