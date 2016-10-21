//
//  IntroductionViewController.swift
//  OnTheRoad
//
//  Created by Evandro Harrison Hoffmann on 21/10/2016.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {

    @IBOutlet weak var onOriginLabel: UILabel!
    @IBOutlet weak var onDestinationLabel: UILabel!
    @IBOutlet weak var theOriginLabel: UILabel!
    @IBOutlet weak var theDestinationLabel: UILabel!
    @IBOutlet weak var roadOriginLabel: UILabel!
    @IBOutlet weak var roadDestinationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareForAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIn()
    }
    
    // MARK: - Animations
    
    func prepareForAnimation(){
        onDestinationLabel.isHidden = true
        theDestinationLabel.isHidden = true
        roadDestinationLabel.isHidden = true
        
        onOriginLabel.isHidden = true
        theOriginLabel.isHidden = true
        roadOriginLabel.isHidden = true
    }
    
    func animateIn(){
        //animate on
        animateAlpha(forView: onOriginLabel, withDuration: 0.4) {
            self.animate(view: self.onOriginLabel, toView: self.onDestinationLabel, withDuration: 0.3, completion: nil)
        }
        
        //animate the
        animateAlpha(forView: theOriginLabel, withDuration: 0.2) {
            self.animate(view: self.theOriginLabel, toView: self.theDestinationLabel, withDuration: 0.5, completion: nil)
        }
        
        //animate road
        animateAlpha(forView: roadOriginLabel, withDuration: 0.3, delay: 0.1, animationOption: .curveEaseIn) {
            self.animate(view: self.roadOriginLabel, toView: self.roadDestinationLabel, withDuration: 0.9, completion: {
                self.performSegue(withIdentifier: "ticketsSegue", sender: self)
            })
        }
        
    }
}

// MARK: - Animation Helpers

extension IntroductionViewController {
    func animateAlpha(forView view: UIView, withDuration duration: Double, delay: Double = 0,animationOption: UIViewAnimationOptions = .curveLinear, completion: (()->Void)?){
        view.isHidden = false
        view.alpha = 0
        UIView.animate(withDuration: duration, delay: delay, options: animationOption, animations: {
            view.alpha = 1
            }, completion: { (completed) in
                if completed {
                    completion?()
                }
        })
    }
    
    func animate(view originView: UIView, toView destinationView: UIView, withDuration duration: Double, completion: (()->Void)?){
        let growth = destinationView.frame.size.width/originView.frame.size.width
        
        UIView.animate(withDuration: duration, animations: {
            originView.center = destinationView.center
            originView.transform = CGAffineTransform(scaleX: growth,y: growth)
            }, completion: { (completed) in
                if completed {
                    originView.isHidden = true
                    destinationView.isHidden = false
                    
                    completion?()
                }
        })
    }
}
