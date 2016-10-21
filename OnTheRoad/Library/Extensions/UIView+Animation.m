//
//  UIView+Animation.m
//  Kirb
//
//  Created by Evandro Harrison Hoffmann on 5/30/16.
//  Copyright © 2016 Dogtown Media. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

-(void)animatePopUp{
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }completion:^(BOOL finished) {
        
    }];
}

-(void)animatePopUpChange{
    [UIView animateWithDuration:0.05f animations:^{
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        }completion:^(BOOL finished) {
            
        }];
    }];
}

-(void)animateTouchDownWithCompletion:(void (^)())completion{
    [UIView animateWithDuration:0.1f animations:^{
        self.transform = CGAffineTransformMakeScale(0.9, 0.9);
        self.alpha = 0.8;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2f animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
            self.alpha = 1;
        }completion:^(BOOL finished) {
            if(completion)
                completion();
        }];
    }];
}

-(void)animateBackgroundChangeTo:(UIColor*)color{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = color;
    }completion:^(BOOL finished) {
        
    }];
}

@end
