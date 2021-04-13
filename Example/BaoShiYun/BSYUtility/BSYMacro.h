//
//  BSYMacro.h
//  BaoShiYun
//
//  Created by zddMac on 2021/3/24.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYUtility.h"
#import "UIColor+HexColor.h"


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define INT_RANDOM(from,to) ( from + ( arc4random() % ( to - from + 1 ) ) )

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define IS_IPhoneX ([BSYUtility iphoneSafeArea].bottom > 0.0)


#define IPHONE_MARGIN_TOP      (IS_IPhoneX?[BSYUtility iphoneSafeArea].top:[[UIApplication sharedApplication] statusBarFrame].size.height)
#define IPHONE_MARGIN_BOTTOM   ([BSYUtility iphoneSafeArea].bottom)


#define HexColor(s) [UIColor colorFromHex:s]
#define HexAlphaColor(s,a) [UIColor colorFromHex:s alpha:a]
#define HexStringColor(s) [UIColor colorFromHexString:s]
#define HexStringAlphaColor(s,a) [UIColor colorFromHexString:s alpha:a]


#define Framework_Bundle [NSBundle bundleForClass:self.class]
#define AssetsImage(name) [UIImage imageNamed:name]
