//
//  BSYLiveOperateView.m
//  BaoShiYun
//
//  Created by zddMac on 2021/2/24.
//

#import "BSYLiveOperateView.h"
#import "BSYLiveOperateBottomBar.h"
#import "BSYLiveOperateTopBar.h"

@interface BSYLiveOperateView()<BSYLiveOperateTopBarDelegate>

@property (nonatomic, strong)UIView *containerView;
@property (nonatomic, strong)UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong)BSYLiveOperateTopBar *topBar;
@property (nonatomic, strong)BSYLiveOperateBottomBar *bottomBar;
@property (nonatomic, assign)BOOL isHideOperate;

@end


@implementation BSYLiveOperateView


- (instancetype)init {
    self = [super init];
    if(self) {
        [self createSubView];
    }
    return self;
}


- (void)createSubView {
    self.clipsToBounds = YES;
    self.isHideOperate = NO;
    [self addSubview:self.containerView];
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    self.tapRecognizer.numberOfTouchesRequired = 1;
    self.tapRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:self.tapRecognizer];
    [self.containerView addSubview:self.topBar];
    self.topBar.delegate = self;
    [self.containerView addSubview:self.bottomBar];
}

- (void)updateConstraints {
    [super updateConstraints];
    @weakify(self);
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self);
    }];
    CGFloat topbarHeight = 72+IPHONE_MARGIN_TOP;
    CGFloat bottomBarHeight = 70;
    [self.topBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.top.width.equalTo(self.containerView);
        make.height.mas_equalTo(topbarHeight);
    }];
    [self.bottomBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.bottom.width.equalTo(self.containerView);
        make.height.mas_equalTo(bottomBarHeight);
    }];
    
}

#pragma mark ---
#pragma mark 懒加载
- (UIView *)containerView {
    if(!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (BSYLiveOperateTopBar *)topBar {
    if(!_topBar) {
        _topBar = [[BSYLiveOperateTopBar alloc] init];
    }
    return _topBar;
}

- (BSYLiveOperateBottomBar *)bottomBar {
    if(!_bottomBar) {
        _bottomBar = [[BSYLiveOperateBottomBar alloc] init];
    }
    return _bottomBar;
}


#pragma mark topBar

- (void)topBarViewAnimateShow:(BOOL)isShow {
    
    [self setNeedsUpdateConstraints];
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        if(isShow) {
            [self.topBar mas_updateConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.top.equalTo(self.containerView);
            }];
        } else {
            [self.topBar mas_updateConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.top.equalTo(self.containerView).with.offset(-CGRectGetHeight(self.topBar.frame));
            }];
        }
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}


- (void)setLiveTitle:(NSString *)title {
    [self.topBar setLiveTitle:title];
}




#pragma mark bottomBar

- (void)bottomBarViewAnimateShow:(BOOL)isShow {
    [self setNeedsUpdateConstraints];
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        if(isShow) {
            [self.bottomBar mas_updateConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.bottom.equalTo(self.containerView);
            }];
        } else {
            [self.bottomBar mas_updateConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.bottom.equalTo(self.containerView).with.offset(CGRectGetHeight(self.bottomBar.frame));
            }];
        }
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}


#pragma mark Action

-(void)tapGestureAction:(UITapGestureRecognizer *)tap {
    self.isHideOperate = !self.isHideOperate;
    [self topBarViewAnimateShow:!self.isHideOperate];
    [self bottomBarViewAnimateShow:!self.isHideOperate];
}

#pragma mark ---
#pragma mark BSYLiveOperateTopBarDelegate

- (void)topBarReturnButtonAction {
    if(self.delegate && [self.delegate respondsToSelector:@selector(operateViewReturnButtonAction)]) {
        [self.delegate operateViewReturnButtonAction];
    }
}







@end
