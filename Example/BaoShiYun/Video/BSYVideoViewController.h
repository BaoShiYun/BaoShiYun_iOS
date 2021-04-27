//
//  BSYVideoViewController.h
//  BaoShiYun
//
//  Created by zddMac on 2021/4/8.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYVideoViewController : BSYBaseViewController

- (instancetype)initWithMediaId:(NSString *)mediaId;
- (instancetype)initWithLocalVideo:(BSYDownloadModel *)downLoadModel;

@end

NS_ASSUME_NONNULL_END
