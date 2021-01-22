//
//  BSYLiveImageItemModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BSYLiveImageItemType) {
    
    BSYLiveImageItemType_Org=1, //原图
    BSYLiveImageItemType_Big=2,//大图
    BSYLiveImageItemType_Thumb=3,//缩略图
    
};

@interface BSYLiveImageItemModel : BSYMediaModel

@property (nonatomic, assign)BSYLiveImageItemType Type;
@property (nonatomic, assign)NSUInteger Size;
@property (nonatomic, assign)NSUInteger Width;
@property (nonatomic, assign)NSUInteger Height;
@property (nonatomic, strong)NSString *URL;

@end

NS_ASSUME_NONNULL_END
