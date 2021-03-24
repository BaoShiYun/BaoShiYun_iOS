//
//  BSYLiveIMFaceCell.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//

#pragma <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveIMFaceCellData : NSObject

/**
 *  表情名称。
 */
@property (nonatomic, strong) NSString *name;

/**
 *  表情在本地缓存的存储路径。
 */
@property (nonatomic, strong) NSString *path;

@end



/**
 * 【模块名称】BSYLiveIMFaceCell
 * 【功能说明】存储表情的图像，并根据 BSYLiveIMFaceCellData 初始化 Cell。
 *  在表情视图中，BSYLiveIMFaceCell 即为界面显示的单元。
 */

@interface BSYLiveIMFaceCell : UICollectionViewCell

/**
 *  表情图像
 *  表情所对应的Image图像。
 */
@property (nonatomic, strong) UIImageView *face;

/**
 *  设置表情单元的数据
 *
 *  @param data 需要设置的数据源。
 */
- (void)setData:(BSYLiveIMFaceCellData * _Nullable)data;

@end

NS_ASSUME_NONNULL_END
