//
//  BSYInteractiveLiveCameraContainer.h
//  BaoShiYun
//
//  Created by DuanGuangming on 2021/3/2.
//

#import "BSYInteractiveLiveCameraCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BSYInteractiveLiveCameraContainerDelegate <NSObject>

- (void)loadCell:(BSYInteractiveLiveCameraCell *)cell index:(NSInteger)index;

@end

@interface BSYInteractiveLiveCameraContainer : UICollectionView

@property (nonatomic, weak) id<BSYInteractiveLiveCameraContainerDelegate> roomDelegate;

//是否上麦
@property (nonatomic, assign)BOOL isOnStage;
@property (nonatomic, strong)NSArray<BSYLiveBroadcastUserModel *> *remoteUserList;

//讲师席位状态
@property (nonatomic, strong, readonly)BSYLiveBroadcastUserModel *teacher;

//自己的席位状态
@property (nonatomic, strong, readonly)BSYLiveBroadcastUserModel *mySeat;

@property (nonatomic, assign)BOOL videoDisable; //是否有视频开启权限
@property (nonatomic, assign)BOOL audioDisable; //是否有音频开启权限

@property (nonatomic, assign) BOOL isPortrait;

- (BSYInteractiveLiveCameraCell *)cellForMyself;
- (BSYInteractiveLiveCameraCell *)cellForTeacher;
- (BSYInteractiveLiveCameraCell *)cellForIndex:(NSInteger)index;
- (BSYInteractiveLiveCameraCell *)cellForUser:(NSString *)uid;

- (BSYLiveBroadcastUserModel *)seatForUser:(NSString *)uid;

- (void)reloadTeacherCell;

@end

NS_ASSUME_NONNULL_END
