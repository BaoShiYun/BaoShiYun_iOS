//
//  BSYLivePullStreamModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLivePullStreamModel : BSYMediaModel

@property (nonatomic, strong)NSString *protocol; //拉流协议 rtmp、flv、hls
@property (nonatomic, strong)NSString *resolution; //清晰度 org-原始 lsd-超清  lhd-高清  lud-清晰
@property (nonatomic, strong)NSString *resolutionName;
@property (nonatomic, strong)NSString *url; //直播地址

- (NSString *)resolutionDes;

- (BOOL)isResolutionOrg;//当前清晰度为原画

@end

NS_ASSUME_NONNULL_END
