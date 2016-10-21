//
//  LoadingView.swift
//  Micro Learning App
//
//  Created by Evandro Harrison Hoffmann on 10/08/2016.
//  Copyright © 2016 Mindvalley. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var animating = false
    var maxScale: CGFloat = 1.0
    
    static func loadingView() -> LoadingView{
        return Bundle(for: self).loadNibNamed("LoadingView", owner: self, options: nil)![0] as! LoadingView
    }
    
    override func awakeFromNib() {
        self.isHidden = true
    }
    
    //MARK: - Animations
    
    func show(){
        animating = true
        
        if self.frame.size.width < self.activityIndicatorView.frame.size.width*1.2 {
            maxScale = self.frame.size.width/(self.activityIndicatorView.frame.size.width*1.2)
        }
        
        self.isHidden = false
        self.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }, completion: { (Bool) in
            
        }) 
        
        self.alpha = 0
        self.activityIndicatorView.transform = CGAffineTransform(scaleX: self.maxScale*0.1, y: self.maxScale*0.1)
        UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseOut, animations: {
            self.alpha = 1
            self.activityIndicatorView.transform = CGAffineTransform(scaleX: self.maxScale*1.1, y: self.maxScale*1.1)
        }) { (Bool) in
            UIView.animate(withDuration: 0.1, animations: {
                self.activityIndicatorView.transform = CGAffineTransform(scaleX: self.maxScale*1, y: self.maxScale*1)
            })
        }
    }
    
    func hide(){
        animating = false
        
        UIView.animate(withDuration: 0.1, animations: {
            self.activityIndicatorView.transform = CGAffineTransform(scaleX: self.maxScale*0.9, y: self.maxScale*0.9)
        }, completion: { (Bool) in
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(scaleX: self.maxScale*1.2, y: self.maxScale*1.2)
                self.alpha = 0
            }, completion: { (Bool) in
                self.removeFromSuperview()
            }) 
        }) 
    }
}
