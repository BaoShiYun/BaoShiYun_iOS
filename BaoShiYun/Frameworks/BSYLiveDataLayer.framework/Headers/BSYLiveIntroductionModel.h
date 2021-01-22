//
//  BSYLiveIntroductionModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveIntroductionModel : BSYMediaModel

@property (nonatomic, strong)NSString *liveId; //教室直播间标识
@property (nonatomic, strong)NSString *coverType; //封面图类型 0:贴链接 1:传长图
@property (nonatomic, strong)NSString *pcCoverUrl;
@property (nonatomic, strong)NSString *mobileCoverUrl;

@end

NS_ASSUME_NONNULL_END
