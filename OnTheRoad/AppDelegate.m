//
//  AppDelegate.m
//  OnTheRoad
//
//  Created by Evandro Harrison Hoffmann on 21/10/2016.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

#import "AppDelegate.h"
#import "OnTheRoad-swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Disable auto layout logs
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:@"_UIConstraintBasedLayoutLogUnsatisfiable"];
    
    //Configure coredata
    [AwesomeData setDatabase:@"OnTheRoad"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [AwesomeData saveContext];
}

@end
