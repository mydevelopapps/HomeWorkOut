//
//  UIViewController + Ext.swift
//  Wallpaper App Demo
//
//  Created by Sufyan Akhtar on 07/12/2022.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    func showActivity() {
        let hud:MBProgressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = UIColor.clear
        hud.bezelView.style = .solidColor
        hud.label.text = "Loading"
        hud.label.textColor = #colorLiteral(red: 0.9607843137, green: 0.03137254902, blue: 0.337254902, alpha: 1)
        hud.contentColor = .white
        //  hud.detailsLabel.text = "Please Wait"
        hud.hide(animated: true, afterDelay: 20.00)
        delay(durationInSeconds: 3.0) { [] in
        }
    }
    
    func dissmissActivity(){
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func showAlertWithTitle(title: String, message: String, options: String..., completion: ((Int) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                if completion != nil {
                    completion!(index)
                }
            }))
        }
        
        DispatchQueue.main.async {
            // your code here
            self.present(alertController, animated: true, completion: nil)
        }
    }
    

}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

