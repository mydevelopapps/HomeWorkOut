# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'WeightLossRecipes' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

pod 'Alamofire'
pod 'KeychainSwift', '~> 20.0'
pod 'SDWebImage', '~> 5.0'
pod 'MBProgressHUD', '~> 1.2.0'
pod ‘SwiftyStoreKit’
pod 'HCSStarRatingView'
pod 'Google-Mobile-Ads-SDK'
pod 'LZViewPager', '~> 1.2.5'
pod 'Firebase/Core'
pod 'Firebase/Messaging'
pod 'SwiftGifOrigin'
pod 'Kingfisher', '~> 7.0'
pod 'Purchases'
pod 'ProgressHUD'

  # Pods for WeightLossRecipes

  post_install do |installer_representation|
        installer_representation.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
  
end
