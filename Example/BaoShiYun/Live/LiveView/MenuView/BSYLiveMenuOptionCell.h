//
//  BSYLiveMenuOptionCell.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/11.
//

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveMenuOptionCell : UITableViewCell

- (void)setTitleText:(NSString *)titleText withHighlight:(BOOL)highlight;

+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
