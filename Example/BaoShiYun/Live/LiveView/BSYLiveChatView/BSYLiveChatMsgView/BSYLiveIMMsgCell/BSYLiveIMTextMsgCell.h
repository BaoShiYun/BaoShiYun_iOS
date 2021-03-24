//
//  BSYLiveIMTextMsgCell.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMMsgCell.h"

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveIMTextMsgCellData;

@interface BSYLiveIMTextMsgCell : BSYLiveIMMsgCell

@property (nonatomic, strong) UILabel *textContent;
@property (readonly)BSYLiveIMTextMsgCellData *textData;

- (void)fillWithData:(BSYLiveIMTextMsgCellData *)data;


@end

NS_ASSUME_NONNULL_END
