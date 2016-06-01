//
//  AppDelegate.m
//  ChatDemo
//
//  Created by lwx on 16/5/26.
//  Copyright © 2016年 lwx. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[TableViewController new]];
    [self.window makeKeyAndVisible];
    return YES;
}




@end
