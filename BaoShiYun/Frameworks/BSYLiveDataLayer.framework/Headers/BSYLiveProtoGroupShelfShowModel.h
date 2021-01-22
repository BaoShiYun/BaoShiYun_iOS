//
//  BSYLiveProtoGroupShelfShowModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "BSYLiveProtoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BSYLiveProtoGroupShelfShowType) {
    BSYLiveProtoGroupShelfShowType_None = 0, //无商品信息
    BSYLiveProtoGroupShelfShowType_Text=1, //文字
    BSYLiveProtoGroupShelfShowType_Pic=2, //图片
    
};

typedef NS_ENUM(NSUInteger, BSYLiveProtoGroupShelfShowWay) {
    BSYLiveProtoGroupShelfShowWay_None = 0,
    BSYLiveProtoGroupShelfShowWay_Pop = 1,
    BSYLiveProtoGroupShelfShowWay_Page = 2,
    
};

@interface BSYLiveProtoGroupShelfShowModel : BSYLiveProtoBaseModel

@property (nonatomic, strong)NSString *timGroupId;  //timgroupID
@property (nonatomic, strong)NSString *shelfId;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *mobileActionUrl; //
@property (nonatomic, strong)NSString *webActionUrl; //
@property (nonatomic, assign)BSYLiveProtoGroupShelfShowWay showWay;
@property (nonatomic, assign)BSYLiveProtoGroupShelfShowType entranceStyle;
@property (nonatomic, strong)NSString *entranceContent;

@end

NS_ASSUME_NONNULL_END
