//
//  BSYLiveImageInfoModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveImageItemModel;
@interface BSYLiveImageInfoModel : BSYMediaModel

@property (nonatomic, strong)NSString *imageFormat;   //图片格式 JPG=1, Gif=2, PNG=3, BMP=4, 其他=255
@property (nonatomic, strong)NSArray <BSYLiveImageItemModel *> *imageInfoList;

- (BSYLiveImageItemModel *)getOrgImage;   //获取原图
- (BSYLiveImageItemModel *)getThumbImage; //获取缩率图

@end

NS_ASSUME_NONNULL_END
