//
//  BSYLiveCommonMsgDetailModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2021/3/4.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

/*直播间通用消息信令*/
#define kBSYLiveSeatConfigUpdate           @"seat_config_update"
#define kBSYLiveSeatListInvite             @"seat_list_invite"
#define kBSYLiveQueueRemovePerson          @"queue_remove_person"
#define kBSYLiveSeatListUpdate             @"seat_list_update"
#define kBSYLiveSeatStatusUpdate           @"seat_status_update"
#define kBSYLiveSeatAudioDisableUpdate     @"seat_audio_disable_update"
#define kBSYLiveSeatVideoDisableUpdate     @"seat_video_disable_update"

@interface BSYLiveCommonMsgDetailModel : BSYMediaModel
@property (nonatomic, strong)NSString *scope; //业务来源
@property (nonatomic, strong)NSString *action; //事件
@property (nonatomic, strong)id data; //与action 相匹配的数据结构

@end

NS_ASSUME_NONNULL_END
