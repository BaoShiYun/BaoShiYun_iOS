//
//  BSYLiveBottomBar.m
//  BaoShiYun
//
//  Created by zddMac on 2021/2/24.
//

#import "BSYLiveBottomBar.h"

@interface BSYLiveBottomBar()

@property (nonatomic, strong)UIView *container;
@property (nonatomic, strong)UIButton *inputBtn;
@property (nonatomic, assign)BOOL isAllMute;

@property (nonatomic, strong)FavorEmitter *likeBtn;
@property (nonatomic, assign)NSUInteger totalLikeNum;

@property (nonatomic, strong)UIButton *moreBtn;

@property (nonatomic, strong)UILabel *interactiveStatus;
@property (nonatomic, strong)UIButton *interactiveBtn;

@property (nonatomic, assign)BOOL isRtc;
@property (nonatomic, assign)BOOL enableInteractive;

@property (nonatomic, assign)BSYInteractiveLiveHandStatus handStatus;

@end


@implementation BSYLiveBottomBar

- (instancetype)init {
    self = [super init];
    if(self) {
        [self createSubView];
    }
    return self;
}


- (void)createSubView {
    self.backgroundColor = HexAlphaColor(0x0C0C0C, 1.0);
    self.isAllMute = NO;
    [self addSubview:self.container];
    [self.container addSubview:self.inputBtn];
    [self.inputBtn addTarget:self action:@selector(inputBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.container addSubview:self.moreBtn];
    [self.moreBtn addTarget:self action:@selector(moreBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.moreBtn.hidden = YES;
    
    [self.container addSubview:self.interactiveBtn];
    [self.interactiveBtn addTarget:self action:@selector(interactiveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:self.interactiveStatus];
    [self updateInteractiveBtnStatus:BSYInteractiveLiveHandStatus_UnHand];
    self.interactiveBtn.hidden = YES;
    self.interactiveStatus.hidden = YES;

    [self addSubview:self.likeBtn];
    @weakify(self);
    self.likeBtn.tapHandler = ^BOOL{
        @strongify(self);
        [self likeBtnAction];
        return YES;
    };
}

- (void)updateConstraints {
    [super updateConstraints];
    CGFloat margin = 12;
    CGFloat likeBtnRisingY = 300;
    @weakify(self);
    [self.container mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self).with.offset(margin);
        make.right.equalTo(self).with.offset(-margin);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(56);
    }];
    
    [self.inputBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(32);
        make.left.centerY.equalTo(self.container);
    }];
    
    [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.inputBtn.mas_right).with.offset(8);
        make.width.height.mas_equalTo(32);
        make.centerY.equalTo(self.container);
    }];
    
    [self.interactiveStatus mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.interactiveBtn.mas_top).with.offset(-2);
        make.centerX.equalTo(self.interactiveBtn);
        make.width.mas_equalTo(38);
        make.height.mas_equalTo(14);
            
    }];
    [self.interactiveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.inputBtn.mas_right).with.offset(8);
        make.width.mas_equalTo(56);
        make.height.mas_equalTo(32);
        make.centerY.equalTo(self.container);
    }];
    
    [self.likeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self).with.offset(-margin);
        make.top.mas_equalTo(12);
        make.height.width.mas_equalTo(32);
    }];
    self.likeBtn.risingY = UISCREEN_HEIGHT-likeBtnRisingY;
    
}


#pragma mark ---
#pragma mark 懒加载

- (UIView *)container {
    if(!_container) {
        _container = [[UIView alloc] init];
    }
    return _container;
}

- (UIButton *)inputBtn {
    if(!_inputBtn) {
        _inputBtn = [[UIButton alloc] init];
        _inputBtn.layer.cornerRadius = 16;
        _inputBtn.layer.masksToBounds = YES;
        _inputBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _inputBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_inputBtn setTitle:@"来说两句吧..." forState:UIControlStateNormal];
        [_inputBtn setTitleColor:HexAlphaColor(0xFFFFFF, 0.3) forState:UIControlStateNormal];
        _inputBtn.backgroundColor = HexAlphaColor(0x262626,1.0);
    }
    return _inputBtn;
}

- (UIButton *)moreBtn {
    if(!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:AssetsImage(@"live_interactive_more_btn") forState:UIControlStateNormal];
        [_moreBtn setImage:AssetsImage(@"live_interactive_more_btn") forState:UIControlStateHighlighted];
    }
    return _moreBtn;
}

- (UILabel *)interactiveStatus {
    if(!_interactiveStatus) {
        _interactiveStatus = [[UILabel alloc] init];
        _interactiveStatus.backgroundColor = HexAlphaColor(0xE15102, 1.0);
        _interactiveStatus.layer.cornerRadius = 7;
        _interactiveStatus.layer.masksToBounds = YES;
        _interactiveStatus.textColor = HexAlphaColor(0xFFFFFF, 1.0);
        _interactiveStatus.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
        _interactiveStatus.textAlignment = NSTextAlignmentCenter;
        _interactiveStatus.text = @"等待中";
        _interactiveStatus.numberOfLines = 1;
        _interactiveStatus.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _interactiveStatus;
}

- (UIButton *)interactiveBtn {
    if(!_interactiveBtn) {
        _interactiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _interactiveBtn;
}


- (FavorEmitter *)likeBtn {
    if(!_likeBtn) {
        _likeBtn = [FavorEmitter emitterWithImage:AssetsImage(@"live_like_btn") highlightImage:AssetsImage(@"live_like_btn_highlight")];
        _likeBtn.risingY = CGRectGetHeight([UIScreen mainScreen].bounds)-300;
        _likeBtn.minRisingVelocity = 20;
        _likeBtn.risingDuration = 3;
        _likeBtn.risingShiftDuration = 1;
        _likeBtn.fadeOutDuration = 2;
        _likeBtn.fadeOutShiftDuration = 1;
        _likeBtn.extraShift = 50;
        _likeBtn.shiftCycle = 8;
        NSMutableArray<UIImage *> *images = [NSMutableArray<UIImage *> array];
        for (int i = 0; i < 10; i++) {
            NSString *imageName = [NSString stringWithFormat:@"live_favor_emitter_%d", i];
            UIImage *image = AssetsImage(imageName);
            if (image) {
                [images addObject:image];
            }
        }
        _likeBtn.itemImages = images;
    }
    return _likeBtn;
}




- (void)updateInteractiveBtnStatus:(BSYInteractiveLiveHandStatus)handStatus {
    self.handStatus = handStatus;
    
    NSString *handStatusImg = @"live_unhand_status";
    self.interactiveStatus.hidden = YES;
    switch (handStatus) {
        case BSYInteractiveLiveHandStatus_UnHand:
            handStatusImg = @"live_vert_unhand_status";
            break;
        case BSYInteractiveLiveHandStatus_Handing:
            self.interactiveStatus.hidden = NO;
            handStatusImg = @"live_vert_handing_status";
            break;
        case BSYInteractiveLiveHandStatus_OnStage:
            handStatusImg = @"live_vert_on_stage_status";
            break;
        default:
            break;
    }
    
    [self.interactiveBtn setImage:AssetsImage(handStatusImg) forState:UIControlStateNormal];
    [self.interactiveBtn setImage:AssetsImage(handStatusImg) forState:UIControlStateHighlighted];
}



#pragma mark ---
#pragma mark Action
- (void)inputBtnAction {
    if(!self.isAllMute) {
        [self eventAction:BSYLiveBottomBarActionType_TextInput];
    }
}


- (void)moreBtnAction {
    [self eventAction:BSYLiveBottomBarActionType_More];
}



- (void)interactiveBtnAction {
    switch (self.handStatus) {
        case BSYInteractiveLiveHandStatus_UnHand:
            [self eventAction:BSYLiveBottomBarActionType_InteractiveHand];
            break;
        case BSYInteractiveLiveHandStatus_Handing:
            [self eventAction:BSYLiveBottomBarActionType_InteractiveUnHand];
            break;
        case BSYInteractiveLiveHandStatus_OnStage:
            [self eventAction:BSYLiveBottomBarActionType_InteractiveOffStage];
            break;
    }
}

- (void)likeBtnAction {
    self.totalLikeNum += 1;
    [self.likeBtn updateLikeLabelCount:self.totalLikeNum];
    [self eventAction:BSYLiveBottomBarActionType_Like];
}


- (void)eventAction:(BSYLiveBottomBarActionType)actionType {
    if(self.actionBlock) {
        self.actionBlock(actionType);
    }
}


- (void)setIsRtc:(BOOL)isRtc {
    self.isRtc = isRtc;
    self.moreBtn.hidden = isRtc;
    if(self.isRtc) {
        [self setInteractiveEnable:self.enableInteractive];
    }
}

- (void)setLiveHandStatus:(BSYInteractiveLiveHandStatus)handStatus {
    [self updateInteractiveBtnStatus:handStatus];
}
- (void)setInteractiveEnable:(BOOL)enable {
    self.enableInteractive = enable;
    if(self.isRtc && enable) {
        self.interactiveBtn.hidden = NO;
    } else {
        self.interactiveBtn.hidden = YES;
    }
    
}

- (void)setAllMute:(BOOL)isMute {
    self.isAllMute = isMute;
    if(isMute) {
        [_inputBtn setTitle:@"当前全员禁言" forState:UIControlStateNormal];
    } else {
        [_inputBtn setTitle:@"来说两句吧..." forState:UIControlStateNormal];
    }
}


- (void)setLikeCount:(NSUInteger)likeCount newAddCount:(NSInteger)addCount {
    if(self.totalLikeNum<likeCount) {
        self.totalLikeNum = likeCount;
        [self.likeBtn updateLikeLabelCount:self.totalLikeNum];
        int showCount = (int)addCount;
        if(showCount>0) {
            if(showCount>30) {
                showCount = 30;
            }
            CGFloat duration = showCount*0.17 ;
            [self.likeBtn generateEmitterItemsForItemsCount:showCount duration:duration];
        }
    }
}



@end
