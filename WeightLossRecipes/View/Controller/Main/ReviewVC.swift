//
//  ReviewVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 07/10/2023.
//

import UIKit
import HCSStarRatingView
import Alamofire
import GoogleMobileAds
class ReviewVC: UIViewController, UITextViewDelegate, GADBannerViewDelegate {

    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var txt_msg: UITextView!
    @IBOutlet var btn_rating: UIButton!
    @IBOutlet var btn_submit: UIButton!
    @IBOutlet var bannerView: GADBannerView!
    var selectedObjId: Int!
    var ratingValue: CGFloat!

    var reviewList = [ReviewInfoModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let bannerAd = BannerAd()
        bannerAd.setupBannerAd(pVc: self)
       
        let starRatingView = HCSStarRatingView(frame: CGRect(x: 210, y: 260, width: 150, height: 50))
        starRatingView.maximumValue = 5
        starRatingView.minimumValue = 0
        starRatingView.value = 0
        starRatingView.tintColor = UIColor.yellow
        starRatingView.backgroundColor = UIColor.clear
        starRatingView.addTarget(self, action: #selector(changeRatingValue(_:)), for: .valueChanged)
        
        view.addSubview(starRatingView)
        
        self.txt_msg.text = "write a comment here"
        self.txt_msg.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.txt_msg.layer.cornerRadius = 10
        self.txt_msg.layer.masksToBounds = true
        self.txt_msg.layer.borderWidth = 2
        self.txt_msg.layer.borderColor = UIColor.white.cgColor
        self.indicator.startAnimating()
        
        btn_submit.layer.cornerRadius = 8
        btn_submit.layer.masksToBounds = true
        
        
        self.callGetReviewsApi()
    }
    

    @objc func changeRatingValue(_ sender: HCSStarRatingView)
    {
        ratingValue = sender.value
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        txt_msg.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction func callRateRecipeApi(_sender: UIButton)
    {
        if ratingValue == 0
        {
            showAlertAction(message: "please give rating")
            
        }else if txt_msg.text.isEmpty
        {
            showAlertAction(message: "please give comment")
        }else
        {
          
            let params = RateRequest(recipe_id: String(selectedObjId), comment: txt_msg.text, rating: String(format: "%.2f", ratingValue))
            
            let reviewViewModel = ReviewViewModel()
            reviewViewModel.callRateApi(parameters: params) { response in
                self.indicator.stopAnimating()
                
                if response.success == "true"
                {
                    self.showAlertAction(message: response.message!)
                    self.callGetReviewsApi()
                   self.txt_msg.text = "write a comment here"
                    
                }else if response.error == "true"
                {
                    self.showAlertAction(message: response.error!)
                }
                
            } onFailure: { error in
                print(error)
            }
        }
     
    }

    func callGetReviewsApi()
    {
        let params = ReviewRequest(recipe_id: String(selectedObjId), page: "0", limit: "10")
     
            let reviewViewModel = ReviewViewModel()
            reviewViewModel.callGetReviewApi(parameters: params) { response in
                
                if response.success == "true"
                {
                    self.indicator.stopAnimating()
                    print(response.reviews)
                    if response.reviews.count > 0{
                        
                        for info in response.reviews
                        {
                            let infoModal = ReviewInfoModal(id:String(info.id!) , comment:info.comment! , profileImage: info.user.profileImage!, firstName: info.user.firstName!, lastName: info.user.lastName!)
                            self.reviewList.append(infoModal)
                        }
                        self.tableView.reloadData()
                    }
                   
                }
                self.indicator.stopAnimating()
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

extension ReviewVC: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return reviewList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        
        let info = reviewList[indexPath.row]
        
        print(info.comment)
        cell.lbl_title.text = info.firstName + info.lastName
        cell.lbl_review.text = info.comment
        cell.thumbnail.layer.cornerRadius = cell.thumbnail.layer.frame.width / 2
        cell.thumbnail.clipsToBounds = true
        
        // Replace this URL with the actual image URL you want to load
        let imageUrlString = "\(baseImageURL)\(info.profileImage)"

                // Use Alamofire to download the image data
                AF.request(imageUrlString).responseData { response in
                    switch response.result {
                    case .success(let data):
                        // Create a UIImage from the downloaded data
                        if let image = UIImage(data: data) {
                            // Update the UI on the main thread
                            DispatchQueue.main.async {
                                // Set the downloaded image to the UIImageView
                              
                                cell.thumbnail.image = image
                            }
                        }
                    case .failure(let error):
                        // Handle the error, e.g., show a placeholder image
                        print("Error downloading image: \(error.localizedDescription)")
                    }
                }
        
        cell.layer.cornerRadius = 8.0
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
