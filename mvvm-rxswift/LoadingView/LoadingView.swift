 //
 //  LoadingView.swift
 //  loading-animation
 //
 //  Created by Cyan Villarin on 13/03/2019.
 //  Copyright © 2019 Cyan Villarin. All rights reserved.
 //

 import Foundation
 import NVActivityIndicatorView

 class LoadingView: UIView {
   
   private var contentBlurredEffectView = UIVisualEffectView()
   private var activityIndicator = NVActivityIndicatorView(frame: CGRect.zero)
   private var blurEffect = UIBlurEffect(style: .light)
   
   public class var sharedInstance: LoadingView {
     struct Singleton {
       static let instance = LoadingView(frame: CGRect.zero)
     }
     return Singleton.instance
   }
   
   public override init(frame: CGRect) {
     
     super.init(frame: frame)

     let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
     var statusBarHeight = CGFloat(0.0)
     if #available(iOS 13.0, *) {
       statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
     } else {
       statusBarHeight = UIApplication.shared.statusBarFrame.height
     }
     let statusBarYOrigin = -1 * statusBarHeight
     
     contentBlurredEffectView.effect = blurEffect
     contentBlurredEffectView.frame = CGRect(x: 0,
                                             y: statusBarYOrigin,
                                             width: UIScreen.main.bounds.width,
                                             height: UIScreen.main.bounds.height
                                               + statusBarHeight)
     
     activityIndicator.frame.size = CGSize(width: 50, height: 50)
     activityIndicator.color = UIColor.orange
     activityIndicator.type = NVActivityIndicatorType.audioEqualizer
     activityIndicator.startAnimating()
     
     addSubview(contentBlurredEffectView)
     addSubview(activityIndicator)
   }
   
   required public init?(coder aDecoder: NSCoder) {
     fatalError("Not coder compliant")
   }
   
   public class func show() {
     let loadingView = LoadingView.sharedInstance
     
     loadingView.contentBlurredEffectView.contentView.alpha = 1
     loadingView.activityIndicator.alpha = 1
     loadingView.contentBlurredEffectView.effect = loadingView.blurEffect
     
     if let topController = UIApplication.topViewController() {
       loadingView.activityIndicator.center = topController.view.center
       topController.tabBarController?.view.addSubview(loadingView)
     }
   }
   
   public class func hide() {
     let loadingView = LoadingView.sharedInstance
     
     UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseOut, animations: {
       
       loadingView.contentBlurredEffectView.contentView.alpha = 0
       loadingView.activityIndicator.alpha = 0
       loadingView.contentBlurredEffectView.effect = nil
       
     }, completion: {_ in
       loadingView.removeFromSuperview()
     })
   }
 }


