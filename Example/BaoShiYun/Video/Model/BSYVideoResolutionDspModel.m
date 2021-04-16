//
//  BSYVideoResolutionDspModel.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/18.
//

#import "BSYVideoResolutionDspModel.h"


@interface BSYVideoResolutionDspModel ()
@property (nonatomic, strong, readwrite) NSString *resolution; //视频清晰度标示
@property (nonatomic, strong, readwrite) NSString *resolutionName; //视频清晰度描述

@end


@implementation BSYVideoResolutionDspModel


-(instancetype)initWithResolution:(NSString *)resolution {
    self = [super init];
    if(self) {
        self.resolution = resolution;
        if(resolution) {
            if([resolution isEqualToString:@"lud"]) {
                self.resolutionName = @"超清";
            } else if ([resolution isEqualToString:@"lhd"]) {
                self.resolutionName = @"高清";
            } else if ([resolution isEqualToString:@"lsd"]) {
                self.resolutionName = @"标清";
            }
        }
    }
    return self;
}


@end
