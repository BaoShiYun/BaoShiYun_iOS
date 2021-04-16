//
//  BSYVideoRateController.h
//  BSYPlayer
//
//  Created by zddMac on 2019/3/14.
//  Copyright © 2019 kaikeba. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BSYAlertViewController.h"

typedef void(^VideoRateViewSelectBlock)(float rate);
typedef void(^VideoRateViewCancelBlock)(void);


@interface BSYVideoRateController : BSYAlertViewController
@property (nonatomic, copy) VideoRateViewSelectBlock  rateSelectBlock;
@property (nonatomic, copy) VideoRateViewCancelBlock cancelBlock;

- (instancetype)initWithDefaultRate:(float)rate;
@end
