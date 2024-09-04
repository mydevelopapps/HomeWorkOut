//
//  ViewController.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 13/11/2023.
//

import UIKit
import SDWebImage
import GoogleMobileAds
class PlayGif: UIViewController, GADBannerViewDelegate {

    @IBOutlet var gifImageView: UIImageView!
    @IBOutlet var stopGifImageView: UIImageView!
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var bg_view: UIView!
    @IBOutlet var lbl_timer: UILabel!
    @IBOutlet var btn_play: UIButton!
    var gifUrl: String!
    var ImgGifUrl: String!
    
    var timer = Timer()
    var counter = 40
    
    var gifData: Data?
     var gifImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerAd = BannerAd()
        bannerAd.setupBannerAd(pVc: self)
        
        lbl_timer.text = "40"
        bg_view.layer.cornerRadius = 10
        bg_view.layer.masksToBounds = true
        
        let gifURL = URL(string: gifUrl)!

        downloadGIF(from: gifURL) { [weak self] gifImageData in
                   guard let self = self else { return }
                   
                   if let gifImageData = gifImageData {
                       self.gifData = gifImageData
                       self.gifImage = UIImage.gif(data: gifImageData)
                       //self.gifImageView.image = self.gifImage
                       //self.playGIF()
                   } else {
                       print("Failed to download GIF")
                   }
               }
        stopGif()
        stopGifImageView.isHidden = false
        self.gifImageView.isHidden = true
    }
   
    func downloadGIF(from url: URL, completion: @escaping (Data?) -> Void) {
           URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data, error == nil else {
                   completion(nil)
                   return
               }
               
               DispatchQueue.main.async {
                   completion(data)
               }
           }.resume()
       }
     
    func playGIF() {
           if let gifData = self.gifData {
               let animatedImage = UIImage.gif(data: gifData)
               gifImageView.image = animatedImage
               gifImageView.startAnimating()
           }
       }
    
    func stopGif()
    {
        //Gif is not stop actually so we just show the image and hide the GifImageView
        if let url = URL(string: ImgGifUrl) {
            // this downloads the image asynchronously if it's not cached yet
            stopGifImageView.kf.setImage(with: url)
        }
    }
    
    @IBAction func playPauseTimer()
    {
    
        if btn_play.title(for: .normal) == "Pause"
        {
            btn_play.setTitle("Play", for: .normal)
            timer.invalidate()
            stopGifImageView.isHidden = false
            gifImageView.isHidden = true
            stopGif()
            
        }else if btn_play.title(for: .normal) == "Play"
        {
            btn_play.setTitle("Pause", for: .normal)
            startTimer()
            stopGifImageView.isHidden = true
            gifImageView.isHidden = false
            playGIF()
            
        }
    }
    
    
     func startTimer()
     {
         timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
         btn_play.setTitle("Pause", for: .normal)
     }
     
    
     @objc func updateTimer()
     {
         if counter == 1
         {
             timer.invalidate()
         }else
         {
             counter -= 1
             lbl_timer.text = "\(counter)"
         }
         
     }
     
    @IBAction func goToBackScreen()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
