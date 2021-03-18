//
//  BSYLiveRemoveHandQueueMsgModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2021/3/4.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveRemoveHandQueueMsgModel : BSYMediaModel
@property (nonatomic, strong)NSString *liveId; //
@property (nonatomic, strong)NSString *fromId; //移除人id
@end

NS_ASSUME_NONNULL_END
