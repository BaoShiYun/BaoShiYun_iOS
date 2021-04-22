//
//  BSYBaseViewController.m
//  BaoShiYun
//
//  Created by zddMac on 2021/4/22.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYBaseViewController.h"
#import <objc/runtime.h>

@interface BSYBaseViewController ()

@end

@implementation BSYBaseViewController

+ (void)load {
    Method oldMethod = class_getInstanceMethod(BSYBaseViewController.class, @selector(viewDidLoad));
    Method newMethod = class_getInstanceMethod(BSYBaseViewController.class, @selector(hook_viewDidLoad));
    method_exchangeImplementations(oldMethod, newMethod);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)hook_viewDidLoad {
    [self hook_viewDidLoad];
    [self.view setNeedsUpdateConstraints];
}


#pragma mark 屏幕旋转控制

-(BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
