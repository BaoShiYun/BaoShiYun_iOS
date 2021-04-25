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


+ (NSString *)fileSizeToString:(NSUInteger)llBytes {
    double bytes = (double)llBytes;
    int cIter = 0;
    char* pszUnits[] = { ("B"), ("K"), ("M"), ("G"), ("T") };
    int cUnits = sizeof(pszUnits) / sizeof(pszUnits[0]);
    
    // move from bytes to KB, to MB, to GB and so on diving by 1024
    while(bytes >= 1024 && cIter < (cUnits-1))
    {
        bytes /= 1024;
        cIter++;
    }
    
    return [NSString stringWithFormat:@"%.2f%s", bytes, pszUnits[cIter]];
}
@end
