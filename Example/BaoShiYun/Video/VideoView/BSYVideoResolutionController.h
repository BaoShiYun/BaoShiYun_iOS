//
//  BSYVideoResolutionController.h
//  KaiKeBa
//
//  Created by zddMac on 2019/4/24.
//  Copyright © 2019 kaikeba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSYAlertViewController.h"

@class BSYVideoResolutionDspModel;

typedef void(^VideoResolutionViewSelectBlock)(BSYVideoResolutionDspModel *resolutionDsp);
typedef void(^VideoResolutionViewCancelBlock)(void);

@interface BSYVideoResolutionController : BSYAlertViewController

@property (nonatomic, copy) VideoResolutionViewSelectBlock  resolutionSelectBlock;
@property (nonatomic, copy) VideoResolutionViewCancelBlock cancelBlock;


- (instancetype)initResolutionList:(NSArray<BSYVideoResolutionDspModel *> *)resolutionlist defaultResolution:(BSYVideoResolutionDspModel *)defautResolution;

@end

