//
//  BSYLiveIMImageMsgCell.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMMsgCell.h"

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveIMImageMsgCellData;
@interface BSYLiveIMImageMsgCell : BSYLiveIMMsgCell

@property (nonatomic, strong) UILabel *textContent;
@property (nonatomic, strong) UIImageView *thumbImageView;
@property (readonly)BSYLiveIMImageMsgCellData *imageData;



- (void)fillWithData:(BSYLiveIMImageMsgCellData *)data;

@end

NS_ASSUME_NONNULL_END
