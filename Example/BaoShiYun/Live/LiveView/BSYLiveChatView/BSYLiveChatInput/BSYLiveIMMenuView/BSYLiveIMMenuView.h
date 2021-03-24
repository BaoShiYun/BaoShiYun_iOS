//
//  BSYLiveIMMenuView.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//


NS_ASSUME_NONNULL_BEGIN


@class BSYLiveIMMenuView;
@class BSYLiveIMMenuCellData;

@protocol BSYLiveIMMenuViewDelegate<NSObject>

/**
 *  点击具体某一 menuCell 后的回调（索引定位）
 *  您可以通过该回调实现：响应用户的点击，根据用户选择的 menuCell 切换到对应的表情分组视图下。
 *
 *  @param menuView 委托者，表情菜单视图
 *  @param index 索引下标，从0开始。
 */
- (void)menuView:(BSYLiveIMMenuView *)menuView didSelectItemAtIndex:(NSInteger)index;

/**
 *  menuView 点击发送按钮后的回调
 *  您可以通过该回调将当前输入框（BSYLiveIMInputBar）中的内容发送。
 *  委托调用链为 menuView -> inputController -> messageController。
 *  分别调用上述类中的 sendMessage 委托/函数，使得功能合理分层的同时提高代码复用率。
 *
 *  @param menuView 委托者，表情菜单视图
 */
- (void)menuViewDidSendMessage:(BSYLiveIMMenuView *)menuView;


@end


@interface BSYLiveIMMenuView : UIView


/**
 *  发送按钮
 *  即在 muewView 最右侧的“发送”按钮。
 */
@property (nonatomic, strong) UIButton *sendButton;

/**
 *  表情菜单视图的collectionView
 *  包含多个 menuCell，并通过 menuFlowLayout 进行灵活统一的布局。
 */
@property (nonatomic, strong) UICollectionView *menuCollectionView;

/**
 *  表情菜单 collectionView 的流水布局。
 *  配合 menuCollectionView，维护表情菜单视图的布局，使表情排布更加美观。
 *  您可以在本布局中能够设置布局方向、行间距、cell 间距等。
 */
@property (nonatomic, strong) UICollectionViewFlowLayout *menuFlowLayout;

/**
 *  被委托者，负责实现 BSYLiveIMMenuViewDelegate 委托协议。
 */
@property (nonatomic, weak) id<BSYLiveIMMenuViewDelegate> delegate;

/**
 *  滑动到某一索引菜单的回调函数
 *  通常情况下：设置cell状态与图标跟随滑动一同改变。
 *  您可以根据需求进行个性化实现。
 *
 *  @param index 索引值
 */
- (void)scrollToMenuIndex:(NSInteger)index;


/**
 *  设置表情菜单数据
 *  data 数组中存放对象类型为 HKYunLiveIMMenuCellData，即 MenuCell 的数据源。
 *
 *  @param data 需要设置的数据
 */
- (void)setData:(NSMutableArray<BSYLiveIMMenuCellData *> *)data;

@end

NS_ASSUME_NONNULL_END
