//
//  BSYLiveInviteBroadcastMsgModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2021/3/4.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveInviteBroadcastMsgModel : BSYMediaModel
@property (nonatomic, strong)NSString *liveId; //
@property (nonatomic, strong)NSString *fromId; //邀请人id

@end

NS_ASSUME_NONNULL_END
