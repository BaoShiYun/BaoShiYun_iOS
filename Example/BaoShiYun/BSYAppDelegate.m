//
//  BSYAppDelegate.m
//  BaoShiYun
//
//  Created by duanguangming@gmail.com on 12/25/2020.
//  Copyright (c) 2020 duanguangming@gmail.com. All rights reserved.
//

#import "BSYAppDelegate.h"
#import "BSYViewController.h"
#import "BSYBaseNavigationController.h"
#import "BSYConfig.h"

@interface  BSYAppDelegate()

@property (nonatomic, strong) BSYBaseNavigationController *navigationController;
@property (nonatomic, strong) BSYViewController *viewController;

@end

@implementation BSYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (@available(iOS 13.0, *)) {
        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
    self.viewController = [[BSYViewController alloc] init];
    self.navigationController = [[BSYBaseNavigationController alloc] initWithRootViewController:self.viewController];
    self.navigationController.navigationBarHidden = YES;
    
    [self.window setRootViewController:self.navigationController];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    [BSYVodSdk configTenantId:[BSYConfig tencentId] customUid:@"12345678" token:[BSYConfig vodToken]];
    [[BSYDownloadSessionManager sharedInstance] setupWithUserId:@"12345678" withBaseStorePath:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/DownloadStoreData/Default"]]];
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
