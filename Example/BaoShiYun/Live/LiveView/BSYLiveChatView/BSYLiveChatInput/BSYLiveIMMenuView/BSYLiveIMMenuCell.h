//
//  BSYLiveIMMenuCell.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//


NS_ASSUME_NONNULL_BEGIN



@interface BSYLiveIMMenuCellData : NSObject

/**
 *  分组单元中分组缩略图的存取路径
 */
@property (nonatomic, strong) NSString *path;

/**
 *  选择标志位
 *  根据选择状态不同显示不同的图标状态
 */
@property (nonatomic, assign) BOOL isSelected;

@end

@interface BSYLiveIMMenuCell : UICollectionViewCell

/**
 *  菜单图像视图
 */
@property (nonatomic, strong) UIImageView *menu;

/**
 *  设置数据，包含设置表情图标、设置 frame 大小、根据 isSelected 设置背景颜色等。
 *
 *  @param data 需要设置的数据（BSYLiveIMMenuCellData）
 */
- (void)setData:(BSYLiveIMMenuCellData *)data;


@end

NS_ASSUME_NONNULL_END
