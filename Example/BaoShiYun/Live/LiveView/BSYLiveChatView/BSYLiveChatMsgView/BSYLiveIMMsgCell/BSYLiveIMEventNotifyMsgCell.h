//
//  BSYLiveIMEventNotifyMsgCell.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMMsgCell.h"

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveIMEventNotifyMsgCellData;

@interface BSYLiveIMEventNotifyMsgCell : BSYLiveIMMsgCell

@property (nonatomic, strong) UILabel *textContent;
@property (readonly)BSYLiveIMEventNotifyMsgCellData *textData;

- (void)fillWithData:(BSYLiveIMEventNotifyMsgCellData *)data;

@end

NS_ASSUME_NONNULL_END
