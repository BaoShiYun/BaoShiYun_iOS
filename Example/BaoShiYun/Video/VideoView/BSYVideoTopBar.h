//
//  BSYVideoTopBar.h
//  KaiKeBa
//
//  Created by zddMac on 2019/3/14.
//  Copyright © 2019 kaikeba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BSYVideoTopBarNetworkIcon) {
    BSYVideoTopBarNetworkIcon_Wifi = 0,
    BSYVideoTopBarNetworkIcon_4G,
    BSYVideoTopBarNetworkIcon_Local,
};


@protocol BSYVideoTopBarDelegate <NSObject>

- (void)topBarReturnBtnAction;

@end

@interface BSYVideoTopBar : UIView
@property (nonatomic, weak) id<BSYVideoTopBarDelegate> delegate;

- (void)setVideoTopBarTitle:(NSString *)title;
- (void)switchNetworkState:(BSYVideoTopBarNetworkIcon)state;

@end




NS_ASSUME_NONNULL_END
