//
//  SideMenuVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 18/09/2023.
//

import UIKit
import Alamofire

class SideMenuVC: UIViewController {

    @IBOutlet var userProfile: UIImageView!
    @IBOutlet var lbl_userName: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var parentView: UIView!
    
    var menuData = [sideMenuModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismisSideMenu))
                
                // Add the gesture recognizer to the view
        self.parentView.addGestureRecognizer(tapGesture)
      
        // create model
    var model = sideMenuModel(menu_title: "", menu_imgOptions: "", profileImage: KeychainManager.shared.getUserProfileImage(), userName: KeychainManager.shared.getUserName())
        menuData.append(model)
        
    model = sideMenuModel(menu_title: "Rate Us", menu_imgOptions: "rate", profileImage: "", userName: "")
         menuData.append(model)
        
     model = sideMenuModel(menu_title: "Terms and Conditions", menu_imgOptions: "termsconditions", profileImage: "", userName: "")
      menuData.append(model)
    
     model = sideMenuModel(menu_title: "Privacy Policy", menu_imgOptions: "privacypolicy", profileImage: "", userName: "")
      menuData.append(model)
    
        if StaticClass.isUserLogin() == true{
            
            model = sideMenuModel(menu_title: "Log Out", menu_imgOptions: "signout", profileImage: "", userName: "")
             menuData.append(model)
           
            model = sideMenuModel(menu_title: "Delete Account", menu_imgOptions: "rate", profileImage: "", userName: "")
             menuData.append(model)
            
        }
     
    }
    
    @objc func dismisSideMenu() {
           // Dismiss the side menu view controller
           dismiss(animated: true, completion: nil)
       }

}

extension SideMenuVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = SideMenuTableViewCell()
        
        var modelInfo = menuData[indexPath.row]
        
        if indexPath.row == 0{
             cell = tableView.dequeueReusableCell(withIdentifier: "pCell") as! SideMenuTableViewCell
            
            cell.indicator.startAnimating()
            cell.lbl_userName.text = modelInfo.userName
           
            // Replace this URL with the actual image URL you want to load
            let imageUrlString = "\(baseImageURL)\(modelInfo.profileImage)"

                    // Use Alamofire to download the image data
                    AF.request(imageUrlString).responseData { response in
                        switch response.result {
                        case .success(let data):
                            // Create a UIImage from the downloaded data
                            if let image = UIImage(data: data) {
                                // Update the UI on the main thread
                                DispatchQueue.main.async {
                                    // Set the downloaded image to the UIImageView
                                    cell.img_profile.image = image
                                    cell.indicator.stopAnimating()
                                }
                            }
                        case .failure(let error):
                            // Handle the error, e.g., show a placeholder image
                            print("Error downloading image: \(error.localizedDescription)")
                        }
                    }
            
        
            cell.img_profile.layer.cornerRadius = cell.img_profile.frame.width / 2
            cell.img_profile.clipsToBounds = true
            cell.img_profile.layer.borderWidth = 2
            cell.img_profile.layer.borderColor = (UIColor.white).cgColor
            
        }else{
            
            cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SideMenuTableViewCell
            
            cell.lbl_title.text = modelInfo.menu_title
            cell.img_options.image = UIImage(named: modelInfo.menu_imgOptions)
        }
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        var modelInfo = menuData[indexPath.row]
        
        if modelInfo.menu_title == "Rate Us"
        {
            
        }else if modelInfo.menu_title == "Terms and Conditions"{
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsConditionsVC") as! TermsConditionsVC
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
        }else if modelInfo.menu_title == "Privacy Policy"
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
        }else if modelInfo.menu_title == "Log Out"
        {
            StaticClass.logoutUser()
            StaticClass.setupAuthRoot()
        }else if modelInfo.menu_title == "Delete Account"
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeleteMyAccount") as! DeleteMyAccount
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the desired height for the row at the given indexPath
        // You can use indexPath to determine which row should have a different height
        if indexPath.row == 0 {
            return 215 // Set a custom height for the first row
        } else {
            return 92 // Default height for other rows
        }
    }
    
    
}
