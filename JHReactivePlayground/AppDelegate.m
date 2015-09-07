//
//  AppDelegate.m
//  JHReactivePlayground
//
//  Created by piglikeyoung on 15/9/7.
//  Copyright (c) 2015年 pikeYoung. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // style the navigation bar
    UIColor* navColor = [UIColor colorWithRed:0.175f green:0.458f blue:0.831f alpha:1.0f];
    [[UINavigationBar appearance] setBarTintColor:navColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    // make the status bar white
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    return YES;
}



@end
