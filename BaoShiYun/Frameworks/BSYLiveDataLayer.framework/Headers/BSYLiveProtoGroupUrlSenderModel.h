//
//  BSYLiveProtoGroupUrlSenderModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "BSYLiveProtoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveProtoGroupUrlSenderModel : BSYLiveProtoBaseModel

@property (nonatomic, strong)NSString *timGroupId;  //timGroupID
@property (nonatomic, strong)NSString *ext;
@property (nonatomic, strong)NSString *mobileActionUrl; //NA红包、评测地址
@property (nonatomic, strong)NSString *webActionUrl; //Web红包、评测地址
@property (nonatomic, strong)NSString *title;
@property (nonatomic, assign)NSInteger *showWay;

@end

NS_ASSUME_NONNULL_END
