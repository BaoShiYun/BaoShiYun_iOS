//
//  BSYLiveIMMsgCellData.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMCommonCell.h"
#import "BSYLiveIMRoleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveIMMsgCellLayout : NSObject

/**
 * 头像边距
 */
@property (nonatomic, assign)UIEdgeInsets avatarInsets;
/**
 * 头像大小
 */
@property (nonatomic, assign)CGSize avatarSize;

/**
 * 气泡内部内容边距
 */
@property (nonatomic, assign)UIEdgeInsets bubbleInsets;

@property (nonatomic, assign)CGFloat cellWidth;


+ (void)setMaxCellWidth:(CGFloat)width;

+ (CGFloat)getMaxCellWidth;

+ (BSYLiveIMMsgCellLayout *_Nonnull)liveMessageCellLayout;

@end


@interface BSYLiveIMMsgCellData : BSYLiveIMCommonCellData

@property (nonatomic, strong)UIColor *bubbleColor;
@property (nonatomic, assign)CGFloat bubbleCorner;
@property (nonatomic, strong)NSString *identifier;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)UIColor *nameColor;
@property (nonatomic, strong)UIFont *nameFont;
@property (nonatomic, assign)BSYLiveIMRoleType roleType;
@property (nonatomic, strong)NSString *role;
@property (nonatomic, strong)UIColor *roleBgColor;
@property (nonatomic, strong)UIColor *roleColor;
@property (nonatomic, strong)UIFont *roleFont;
@property (nonatomic, strong)NSString *avatarUrl;
@property (nonatomic, strong)UIImage *avatarImage;
@property (nonatomic, strong)BSYLiveIMMsgCellLayout *cellLayout;

/**
 *  根据消息方向（收/发）初始化消息单元
 *  除了基本消息的初始化外，还包括根据方向设置方向变量、昵称字体等。
 *  同时为子类提供可继承的行为。
 *
 */
- (instancetype)init;

- (CGSize)contentSize;



- (void)setRoleType:(BSYLiveIMRoleType)roleType;


@end

NS_ASSUME_NONNULL_END
