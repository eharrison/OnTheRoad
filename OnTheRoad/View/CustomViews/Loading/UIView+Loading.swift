//
//  UIView+Loading.swift
//  Micro Learning App
//
//  Created by Evandro Harrison Hoffmann on 10/08/2016.
//  Copyright © 2016 Mindvalley. All rights reserved.
//

import UIKit

extension UIView {
    
    func startLoadingAnimationDelayed(_ delay: Double){
        let delayTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.startLoadingAnimation()
        }
    }
    
    func startLoadingAnimation(){
        stopLoadingAnimation()
        
        let loadingView = LoadingView.loadingView()
        loadingView.frame = self.bounds
        self.addSubview(loadingView)
        loadingView.show()
    }
    
    func stopLoadingAnimation(){
        for subview in subviews{
            if let subview = subview as? LoadingView {
                subview.hide()
            }
        }
    }
}
