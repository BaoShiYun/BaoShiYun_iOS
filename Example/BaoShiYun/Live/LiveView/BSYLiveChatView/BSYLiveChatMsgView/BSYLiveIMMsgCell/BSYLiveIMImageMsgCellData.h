//
//  BSYLiveIMImageMsgCellData.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMMsgCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveIMImageMsgCellLayout : BSYLiveIMMsgCellLayout

/**
* 消息边距
*/

@property (nonatomic, assign)UIEdgeInsets contentInsets;
@property (nonatomic, assign)UIEdgeInsets imageInsets;


+ (BSYLiveIMImageMsgCellLayout *_Nullable)liveImageMessageCellLayout;

@end


@class BSYLiveChatMsgImageElem;
@class BSYLiveIMImageMsgCellLayout;
@class BSYLiveImageItemModel;

@interface BSYLiveIMImageMsgCellData : BSYLiveIMMsgCellData

@property (nonatomic, strong) NSAttributedString *attributedString;
@property (readonly) CGSize textSize;
@property (readonly) CGPoint textOrigin;

@property (nonatomic, strong)BSYLiveChatMsgImageElem *imageInfo;
@property (readonly) CGSize imageSize;
@property (readonly) CGPoint imageOrigin;

@property (nonatomic, strong)BSYLiveIMImageMsgCellLayout *cellImageLayout;

- (instancetype)init;
- (NSURL *)thumbImageUrl;

- (NSURL *)orgImageUrl;


@end

NS_ASSUME_NONNULL_END
