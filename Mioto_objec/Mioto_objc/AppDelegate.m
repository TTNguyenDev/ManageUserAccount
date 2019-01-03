//
//  AppDelegate.m
//  Mioto_objc
//
//  Created by TT Nguyen on 11/28/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
     Menu_1_ViewController *menuVC = [Menu_1_ViewController new];
    
    UINavigationController *nvController = [UINavigationController new];
    [nvController pushViewController:menuVC animated:true];
    UINavigationBar *bar = [nvController navigationBar];
    bar.barTintColor = [UIColor blackColor];
    bar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self.window setRootViewController: nvController];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
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
}


@end
