//
//  BSYVideoResolutionDspModel.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYVideoResolutionDspModel : NSObject

@property (nonatomic, strong, readonly) NSString *resolution; //视频清晰度标示
@property (nonatomic, strong, readonly) NSString *resolutionName; //视频清晰度描述

-(instancetype)initWithResolution:(NSString *)resolution;



@end

NS_ASSUME_NONNULL_END
