//
//  BSYVideoResolutionTableViewCell.h
//  KaiKeBa
//
//  Created by zddMac on 2019/4/24.
//  Copyright © 2019 kaikeba. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface BSYVideoResolutionTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;
- (void)setTitleText:(NSString *)titleText withHighlight:(BOOL)highlight;
+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
