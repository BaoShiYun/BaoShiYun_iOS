//
//  BSYInteractiveLiveCameraCell.h
//  BaoShiYun
//
//  Created by DuanGuangming on 2021/3/2.
//


NS_ASSUME_NONNULL_BEGIN

@interface BSYInteractiveLiveCameraCell : UICollectionViewCell

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, assign) BOOL isSelf;
@property (nonatomic, assign) BOOL isTeacher;

@property (nonatomic, assign) BOOL isEmpty;
@property (nonatomic, assign) BOOL audioMute;
@property (nonatomic, assign) BOOL videoMute;
@property (nonatomic, assign) NSInteger volume;

@property (nonatomic, strong, readonly) UIView *mediaContentView;

@end

NS_ASSUME_NONNULL_END
