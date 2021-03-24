//
//  BSYLiveIMMsgCell.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMCommonCell.h"

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveIMMsgCellData;
typedef void(^BSYLiveIMMsgTapBlock)(void);
@interface BSYLiveIMMsgCell : BSYLiveIMCommonCell

@property (nonatomic, strong)UIView *container;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *roleLabel;
@property (nonatomic, strong)UIImageView *avartarImage;
@property (nonatomic, strong) UIView *bubbleView;
@property (readonly)BSYLiveIMMsgCellData *messageData;
@property (nonatomic, copy, nullable)BSYLiveIMMsgTapBlock tapHandle;


- (void)fillWithData:(BSYLiveIMMsgCellData *)data;

@end

NS_ASSUME_NONNULL_END
