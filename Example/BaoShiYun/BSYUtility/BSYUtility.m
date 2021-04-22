//
//  BSYUtility.m
//  BaoShiYun
//
//  Created by zddMac on 2021/3/24.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYUtility.h"

@implementation BSYUtility

+ (UIEdgeInsets)iphoneSafeArea {
    static UIEdgeInsets gSafeArea = {0.5, 0, 0, 0};

    gSafeArea = UIEdgeInsetsMake(0, 0, 0, 0);
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return gSafeArea;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[UIApplication sharedApplication].delegate window];
        gSafeArea = mainWindow.safeAreaInsets;
    }
    return gSafeArea;
}

+ (NSString *)mainBundleDirectory {
    NSString* path = [[NSBundle mainBundle] bundlePath];
    return path;
}

@end
