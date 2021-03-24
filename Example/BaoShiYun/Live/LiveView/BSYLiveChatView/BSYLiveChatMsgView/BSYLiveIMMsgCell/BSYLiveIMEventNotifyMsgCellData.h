//
//  BSYLiveIMEventNotifyMsgCellData.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMMsgCellData.h"

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveIMTextMsgCellLayout;
@class BSYLiveNotifyTextStyleModel;


@interface BSYLiveIMEventNotifyMsgCellData : BSYLiveIMMsgCellData

@property (nonatomic, strong) NSString *actionName;
@property (nonatomic, strong) UIFont *actionNameFont;
@property (nonatomic) UIColor *actionNameColor;

@property (nonatomic, strong) NSString *action;
@property (nonatomic, strong) UIFont *actionFont;
@property (nonatomic) UIColor *actionColor;

@property (nonatomic, strong) NSString *event;
@property (nonatomic, strong) UIFont *eventFont;
@property (nonatomic) UIColor *eventColor;



@property (nonatomic, strong) NSAttributedString *attributedString;
@property (readonly) CGSize textSize;
@property (readonly) CGPoint textOrigin;

@property (nonatomic, assign)BOOL isCustomizeStyle; //自定义通知类型
@property (nonatomic, strong)NSArray<BSYLiveNotifyTextStyleModel *> *customizeStyleDetail;



@property (nonatomic, strong)BSYLiveIMTextMsgCellLayout *cellTextLayout;

- (instancetype)init;

- (CGSize)contentSize;


@end

NS_ASSUME_NONNULL_END
