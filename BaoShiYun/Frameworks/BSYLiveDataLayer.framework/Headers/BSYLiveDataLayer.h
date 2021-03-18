//
//  BSYLiveDataLayer.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for BSYLiveDataLayer.
FOUNDATION_EXPORT double BSYLiveDataLayerVersionNumber;

//! Project version string for BSYLiveDataLayer.
FOUNDATION_EXPORT const unsigned char BSYLiveDataLayerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <BSYLiveDataLayer/PublicHeader.h>


#import <BSYLiveDataLayer/BSYLiveRequestConfigure.h>
#import <BSYLiveDataLayer/BSYLiveDataTokenManager.h>


/*
 * Model
 */
#import <BSYLiveDataLayer/BSYLiveInfoModel.h>
#import <BSYLiveDataLayer/BSYRtcLiveInfoModel.h>
#import <BSYLiveDataLayer/BSYLiveIntroductionModel.h>
#import <BSYLiveDataLayer/BSYLiveRouteModel.h>
#import <BSYLiveDataLayer/BSYLiveCameraSeatModel.h>
#import <BSYLiveDataLayer/BSYLivePullStreamModel.h>
#import <BSYLiveDataLayer/BSYLiveQuestionModel.h>
#import <BSYLiveDataLayer/BSYLiveQestionTokenModel.h>
#import <BSYLiveDataLayer/BSYLiveRedPackageModel.h>
#import <BSYLiveDataLayer/BSYLiveIMModel.h>
#import <BSYLiveDataLayer/BSYLiveRoleModel.h>
#import <BSYLiveDataLayer/BSYLiveEventNotifyTextStyleModel.h>
#import <BSYLiveDataLayer/BSYLiveImageInfoModel.h>
#import <BSYLiveDataLayer/BSYLiveImageItemModel.h>
#import <BSYLiveDataLayer/BSYLiveScriptMsgModel.h>
#import <BSYLiveDataLayer/BSYLiveProtocalModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoBaseModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoCustomMsgModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoGroupEventNotifyModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoGroupLikeNumModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoGroupShelfHideModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoGroupShelfShowModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoGroupAllMuteModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoGroupUrlSenderModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoKeywordsWinnerModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoLiveStatusChangedModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoOnlineNumModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoOnlineNumSwitchModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoMulitPushAddressChangedModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoMulitPullAddressChangedModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoTopicAskModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoGroupCommonControlModel.h>
#import <BSYLiveDataLayer/BSYLiveCameraStreamStatusModel.h>
#import <BSYLiveDataLayer/BSYLiveSwitchMasterCameraModel.h>
#import <BSYLiveDataLayer/BSYLiveInteractiveSeatModel.h>
#import <BSYLiveDataLayer/BSYLiveProtoLiveCommonMsg.h>
#import <BSYLiveDataLayer/BSYLiveCommonMsgDetailModel.h>
#import <BSYLiveDataLayer/BSYLiveRtcRoomConfigModel.h>
#import <BSYLiveDataLayer/BSYLiveInviteBroadcastMsgModel.h>
#import <BSYLiveDataLayer/BSYLiveRemoveHandQueueMsgModel.h>
#import <BSYLiveDataLayer/BSYLiveSelfSeatUpdateModel.h>
#import <BSYLiveDataLayer/BSYLiveSelfSeatAudioDisableModel.h>
#import <BSYLiveDataLayer/BSYLiveSelfSeatVideoDisableModel.h>


/*
 * Request
 */

#import <BSYLiveDataLayer/BSYLiveEnterClassRequest.h>
#import <BSYLiveDataLayer/BSYLiveBaseRequest.h>
#import <BSYLiveDataLayer/BSYLiveInfoRequest.h>
#import <BSYLiveDataLayer/BSYLiveIntroductionRequest.h>
#import <BSYLiveDataLayer/BSYLiveFeedbackRequest.h>
#import <BSYLiveDataLayer/BSYLiveRedPackageListRequest.h>
#import <BSYLiveDataLayer/BSYLiveRedPackageReceiveRequest.h>
#import <BSYLiveDataLayer/BSYLiveQuestionListRequest.h>
#import <BSYLiveDataLayer/BSYLiveQuestionTokenRequest.h>

#import <BSYLiveDataLayer/BSYLiveRtcSeatInviteRespondRequest.h>
#import <BSYLiveDataLayer/BSYLiveRtcQueueLinkRequest.h>
#import <BSYLiveDataLayer/BSYLiveRtcQueueUnLinkRequest.h>
#import <BSYLiveDataLayer/BSYLiveRtcSeatUpdateRequest.h>
#import <BSYLiveDataLayer/BSYLiveRtcQueueStatusRequest.h>
#import <BSYLiveDataLayer/BSYLiveRtcSeatListRequest.h>
