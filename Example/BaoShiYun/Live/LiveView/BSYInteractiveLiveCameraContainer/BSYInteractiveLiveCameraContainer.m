//
//  BSYInteractiveLiveCameraContainer.m
//  BaoShiYun
//
//  Created by DuanGuangming on 2021/3/2.
//

#import "BSYInteractiveLiveCameraContainer.h"

@interface BSYInteractiveLiveCameraContainer () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)BSYLiveBroadcastUserModel *teacher;
@property (nonatomic, strong)BSYLiveBroadcastUserModel *mySeat;

@end

@implementation BSYInteractiveLiveCameraContainer

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self registerClass:BSYInteractiveLiveCameraCell.class forCellWithReuseIdentifier:NSStringFromClass([BSYInteractiveLiveCameraCell class])];
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {

        }
        self.delegate = self;
        self.dataSource = self;
        
        self.teacher = [BSYLiveBroadcastUserModel new];
        self.mySeat = [BSYLiveBroadcastUserModel new];
    }
    return self;
}

- (void)setIsPortrait:(BOOL)isPortrait {
    _isPortrait = isPortrait;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    if (isPortrait) {
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    } else {
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
}

- (void)setIsOnStage:(BOOL)isOnStage {
    if (_isOnStage == isOnStage) {
        return;
    }
    _isOnStage = isOnStage;
    [self reloadData];
}

- (void)setRemoteUserList:(NSArray<BSYLiveBroadcastUserModel *> *)remoteUserList {
    _remoteUserList = remoteUserList;
    [self reloadData];
}

- (BSYInteractiveLiveCameraCell *)cellForIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    return (BSYInteractiveLiveCameraCell *)[self cellForItemAtIndexPath:indexPath];
}

- (BSYInteractiveLiveCameraCell *)cellForUser:(NSString *)uid {
    for (BSYInteractiveLiveCameraCell *cell in self.visibleCells) {
        if (cell.isTeacher) {
            continue;
        }
        if ([cell.uid isEqualToString:uid]) {
            return cell;
        }
    }
    return nil;
}

- (BSYInteractiveLiveCameraCell *)cellForMyself {
    if (self.isOnStage) {
        return [self cellForIndex:1];
    } else {
        return nil;
    }
}

- (BSYInteractiveLiveCameraCell *)cellForTeacher {
    return [self cellForIndex:0];
}

- (void)reloadTeacherCell {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self reloadItemsAtIndexPaths:@[indexPath]];
}

- (BSYLiveBroadcastUserModel *)seatForUser:(NSString *)uid {
    for (BSYLiveBroadcastUserModel *user in self.remoteUserList) {
        if ([user.userId isEqualToString:uid]) {
            return user;
        }
    }
    return nil;
}

#pragma mark - UICollectionViewDataSource -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BSYInteractiveLiveCameraCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BSYInteractiveLiveCameraCell class]) forIndexPath:indexPath];
    BSYLiveBroadcastUserModel *userModel = nil;
    NSInteger userIndex = indexPath.row;
    if (self.isOnStage) {
        userIndex = userIndex - 2;
    } else {
        userIndex = userIndex - 1;
    }
    if (userIndex >= 0 && userIndex < self.remoteUserList.count) {
        userModel = self.remoteUserList[userIndex];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.isTeacher = YES;
            cell.isSelf = NO;
            cell.isEmpty = NO;
            cell.uid = self.teacher.userId;
            cell.nickName = self.teacher.nickName;
            cell.audioMute = self.teacher.audioMute;
            cell.videoMute = self.teacher.videoMute;
        }
            break;
        case 1:
        {
            if (self.isOnStage) {
                cell.isTeacher = NO;
                cell.isSelf = YES;
                cell.isEmpty = NO;
                cell.uid = self.mySeat.userId;
                cell.nickName = self.mySeat.nickName;
                cell.audioMute = self.mySeat.audioMute || self.audioDisable;
                cell.videoMute = self.mySeat.videoMute || self.videoDisable;
                break;
            }
        }
        default:
        {
            cell.isTeacher = NO;
            cell.isSelf = NO;
            if (userModel == nil) {
                cell.isEmpty = YES;
            } else {
                cell.isEmpty = NO;
            }
            cell.uid = userModel.userId;
            cell.nickName = userModel.nickName;
            cell.audioMute = userModel.audioMute;
            cell.videoMute = userModel.videoMute;
        }
            break;
    }
    if ([self.roomDelegate respondsToSelector:@selector(loadCell:index:)]) {
        [self.roomDelegate loadCell:cell index:indexPath.row];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout -

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isPortrait) {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), CGRectGetHeight(collectionView.frame)/4);
    } else {
        return CGSizeMake(CGRectGetWidth(collectionView.frame)/4, CGRectGetHeight(collectionView.frame));
    }
}


@end
