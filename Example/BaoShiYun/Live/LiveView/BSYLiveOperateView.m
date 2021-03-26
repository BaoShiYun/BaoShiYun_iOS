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
@property (nonatomic, strong)LOTAnimationView  *loadingAnimateLOT;
@property (nonatomic, strong) UILabel *loadingMsgLabel;
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
    [self addSubview:self.loadingAnimateLOT];
    [self.loadingAnimateLOT stop];
    self.loadingAnimateLOT.hidden = YES;
    [self.containerView addSubview:self.loadingMsgLabel];
    self.loadingMsgLabel.hidden = YES;
    
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
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self);
    }];
    
    [self.loadingAnimateLOT mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.containerView.mas_centerY).with.offset(-10);
        make.width.height.mas_equalTo(40);
        make.centerX.equalTo(self.containerView);
    }];
    
    [self.loadingMsgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.containerView.mas_centerY).with.offset(4);
        make.height.mas_equalTo(14);
        make.centerX.width.equalTo(self.containerView);
    }];
    
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.containerView);
        make.left.width.equalTo(self.containerView);
        make.height.mas_equalTo(72+IPHONE_MARGIN_TOP);
    }];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.containerView);
        make.left.width.equalTo(self.containerView);
        make.height.mas_equalTo(70);
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

- (LOTAnimationView *)loadingAnimateLOT {
    if(!_loadingAnimateLOT) {
        _loadingAnimateLOT = [LOTAnimationView animationWithFilePath:[[BSYUtility mainBundleDirectory] stringByAppendingPathComponent:@"player_loading_indicator/data.json"]];
        _loadingAnimateLOT.loopAnimation = YES;
        _loadingAnimateLOT.userInteractionEnabled = YES;
        _loadingAnimateLOT.contentMode = UIViewContentModeScaleToFill;
    }
    return _loadingAnimateLOT;
}

- (UILabel *)loadingMsgLabel {
    if(!_loadingMsgLabel) {
        _loadingMsgLabel = [[UILabel alloc] init];
        _loadingMsgLabel.numberOfLines = 1;
        _loadingMsgLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _loadingMsgLabel.text = @"正在努力加载，请稍后..";
        _loadingMsgLabel.textAlignment = NSTextAlignmentCenter;
        _loadingMsgLabel.textColor = HexAlphaColor(0xFFFFFF, 1.0);
    }
    return _loadingMsgLabel;
}



#pragma mark topBar

- (void)topBarViewAnimateShow:(BOOL)isShow {
    
    [self setNeedsUpdateConstraints];
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        if(isShow) {
            [self.topBar mas_remakeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.top.equalTo(self.containerView);
                make.left.width.equalTo(self.containerView);
                make.height.mas_equalTo(72+IPHONE_MARGIN_TOP);
            }];
        } else {
            
            [self.topBar mas_remakeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.top.equalTo(self.containerView).with.offset(-72-IPHONE_MARGIN_TOP);
                make.left.width.equalTo(self.containerView);
                make.height.mas_equalTo(72+IPHONE_MARGIN_TOP);
            }];
        }
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}


- (void)setLiveTitle:(NSString *)title {
    [self.topBar setLiveTitle:title];
}

- (void)setStudentCountShow:(BOOL)isShow {
    [self.topBar setStudentCountShow:isShow];
}
- (void)setStudentCount:(NSInteger)count {
    [self.topBar setStudentCount:count];
}




#pragma mark bottomBar
- (void)bottomBarViewAnimateShow:(BOOL)isShow {
    [self setNeedsUpdateConstraints];
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        if(isShow) {
            [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.bottom.equalTo(self.containerView);
                make.left.width.equalTo(self.containerView);
                make.height.mas_equalTo(70);
            }];
        } else {
            [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.bottom.equalTo(self.containerView).with.offset(-70);
                make.left.width.equalTo(self.containerView);
                make.height.mas_equalTo(70);
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



#pragma mark loadingView
- (void)showLoadingView {
    self.loadingAnimateLOT.hidden = NO;
    self.loadingMsgLabel.hidden = NO;
    [self.loadingAnimateLOT play];
}

- (void)hideLoadingView {
    self.loadingAnimateLOT.hidden = YES;
    self.loadingMsgLabel.hidden = YES;
    [self.loadingAnimateLOT stop];
}





@end
