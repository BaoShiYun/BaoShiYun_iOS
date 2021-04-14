//
//  BSYBaseNavigationController.m
//  BaoShiYun
//
//  Created by zddMac on 2021/4/14.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYBaseNavigationController.h"

@interface BSYBaseNavigationController ()

@end

@implementation BSYBaseNavigationController

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

-(BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end
