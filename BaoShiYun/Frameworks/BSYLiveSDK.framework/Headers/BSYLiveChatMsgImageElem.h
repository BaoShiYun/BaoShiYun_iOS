//
//  BSYLiveChatMsgImageElem.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/17.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveChatMsgImageElem : NSObject

@property (nonatomic, strong, readonly)NSString *imageFormat;   //图片格式 JPG=1, Gif=2, PNG=3, BMP=4, 其他=255

@property (nonatomic, assign, readonly)NSUInteger orgSize; //原图大小
@property (nonatomic, assign, readonly)NSUInteger orgWidth; //原图宽
@property (nonatomic, assign, readonly)NSUInteger orgHeight; //原图高
@property (nonatomic, strong, readonly)NSString *orgURL; //原图URL

@property (nonatomic, assign, readonly)NSUInteger thumbSize; //缩略大小
@property (nonatomic, assign, readonly)NSUInteger thumbWidth;//缩略图宽
@property (nonatomic, assign, readonly)NSUInteger thumbHeight;//缩略图高
@property (nonatomic, strong, readonly)NSString *thumbURL; //缩略图URL

@end

NS_ASSUME_NONNULL_END
