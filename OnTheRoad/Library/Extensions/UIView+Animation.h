//
//  UIView+Animation.h
//  Kirb
//
//  Created by Evandro Harrison Hoffmann on 5/30/16.
//  Copyright © 2016 Dogtown Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

-(void)animatePopUp;
-(void)animatePopUpChange;
-(void)animateTouchDownWithCompletion:(void (^)())completion;
-(void)animateBackgroundChangeTo:(UIColor*)color;

@end
