//
//  BSYDownloadTableCell.h
//  BaoShiYun
//
//  Created by zddMac on 2021/4/22.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface BSYDownloadTableCell : UITableViewCell

@property (nonatomic, strong) BSYDownloadModel *downloadModel;

- (void)setContentImageUrl:(NSString *)url;

+ (CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
