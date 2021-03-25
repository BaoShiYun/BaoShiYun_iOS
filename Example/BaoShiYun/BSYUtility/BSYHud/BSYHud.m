//
//  BSYHud.m
//  BSYUILib
//
//  Created by Duane on 2020/11/4.
//

#import "BSYHud.h"
#import "SVProgressHUD.h"

#define kDefaultHUDDuration 2

@implementation BSYHud

+ (void)setHUDStyle {
    UIImage *success = AssetsImage(@"hud_success");
    [SVProgressHUD setSuccessImage:success];
    UIImage *error = AssetsImage(@"hud_warning");
    [SVProgressHUD setErrorImage:error];
    UIImage *info = AssetsImage(@"hud_info");
    [SVProgressHUD setInfoImage:info];
    [SVProgressHUD setMinimumDismissTimeInterval:kDefaultHUDDuration];
    [SVProgressHUD setMaximumDismissTimeInterval:kDefaultHUDDuration*2];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setCornerRadius:6];
    [SVProgressHUD setBackgroundColor:[UIColor.blackColor colorWithAlphaComponent:0.75]];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:14]];
    [SVProgressHUD setForegroundColor:UIColor.whiteColor];
    [SVProgressHUD setMaxSupportedWindowLevel:UIWindowLevelAlert];
}

+ (void)showHUDLoading:(NSString *)message {
    [SVProgressHUD showWithStatus:message];
}

+ (void)showHUDSuccess:(NSString *)message {
    [SVProgressHUD showSuccessWithStatus:message];
}

+ (void)showHUDError:(NSString *)message {
    [SVProgressHUD showErrorWithStatus:message];
}

+ (void)showHUDMessage:(NSString *)message {
    [SVProgressHUD showInfoWithStatus:message];
}

+ (void)hideHUD {
    [SVProgressHUD dismiss];
}

@end
