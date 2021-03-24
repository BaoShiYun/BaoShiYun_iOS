//
//  BSYInteractiveControlView.m
//  BaoShiYun
//
//  Created by zddMac on 2021/3/2.
//

#import "BSYInteractiveControlView.h"
#import "BSYInteractiveLiveMediaView.h"

@interface BSYInteractiveControlView ()
@property (nonatomic, strong)UIView *blankView;
@property (nonatomic, strong)UIView *container;
@property (nonatomic, strong)BSYInteractiveLiveMediaView *camBtn;
@property (nonatomic, strong)BSYInteractiveLiveMediaView *micBtn;
@property (nonatomic, strong)UIButton *offStageBtn;
@property (nonatomic, assign)BOOL camEnable;
@property (nonatomic, assign)BOOL camOpen;
@property (nonatomic, assign)BOOL micEnable;
@property (nonatomic, assign)BOOL micOpen;

@end

@implementation BSYInteractiveControlView

- (instancetype)initWithCamEnable:(BOOL)isCamEnable withCamStatus:(BOOL)isCamOpen withMicEnable:(BOOL)isMicEnable withMicStatus:(BOOL)isMicOpen {
    self = [self initWithStyle:KKBAlertControllerStyle_ActionSheet];
    if(self) {
        self.camEnable = isCamEnable;
        self.camOpen = isCamOpen;
        self.micEnable = isMicEnable;
        self.micOpen = isMicOpen;
        [self createSubView];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)createSubView {
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.blankView];
    [self.view addSubview:self.container];
    [self.container addSubview:self.camBtn];
    @weakify(self);
    self.camBtn.mediaBlock = ^(BSYInteractiveLiveMediaType mediaType, BOOL isOpen) {
        @strongify(self);
        if(self.camBlock) {
            self.camBlock(isOpen);
        }
    };
    [self.container addSubview:self.micBtn];
    self.micBtn.mediaBlock = ^(BSYInteractiveLiveMediaType mediaType, BOOL isOpen) {
        @strongify(self);
        if(self.micBlock) {
            self.micBlock(isOpen);
        }
    };
    [self.container addSubview:self.offStageBtn];
    [self.offStageBtn addTarget:self action:@selector(offStageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelBtnAction)];
    tapGesture.cancelsTouchesInView = YES;
    tapGesture.numberOfTapsRequired = 1;
    [self.blankView addGestureRecognizer:tapGesture];
    
}

- (void)setCamStatus:(BOOL)isCamOpen {
    self.camOpen = isCamOpen;
    [self.camBtn setStatus:isCamOpen];
}
- (void)setMicStatus:(BOOL)isMicOpen {
    self.micOpen = isMicOpen;
    [self.micBtn setStatus:isMicOpen];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self);
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(10);
        make.height.mas_equalTo(150+IPHONE_MARGIN_BOTTOM);
    }];
    
    [self.camBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-48);
        make.top.mas_equalTo(24);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(70);
    }];
    
    [self.micBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(48);
        make.top.width.height.equalTo(self.camBtn);
    }];
    
    [self.offStageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(24);
        make.centerX.equalTo(self.container);
        make.width.height.mas_equalTo(56);
    }];
    
    [self.blankView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.container.mas_top);
    }];
    
    
}



#pragma mark ---
#pragma mark 懒加载

- (UIView *)blankView {
    if(!_blankView) {
        _blankView = [[UIView alloc] init];
    }
    return _blankView;
}

- (UIView *)container {
    if(!_container) {
        _container = [[UIView alloc] init];
        _container.backgroundColor = HexAlphaColor(0x262626, 1.0);
        _container.layer.cornerRadius= 12;
        _container.layer.masksToBounds = YES;
    }
    return _container;
}

- (BSYInteractiveLiveMediaView *)camBtn {
    if(!_camBtn) {
        _camBtn = [[BSYInteractiveLiveMediaView alloc] initWithType:BSYInteractiveLiveMediaType_Camera withEnable:self.camEnable withStatus:self.camOpen];
    }
    return _camBtn;
}

- (BSYInteractiveLiveMediaView *)micBtn {
    if(!_micBtn) {
        _micBtn = [[BSYInteractiveLiveMediaView alloc] initWithType:BSYInteractiveLiveMediaType_Mic withEnable:self.micEnable withStatus:self.micOpen];
    }
    return _micBtn;
}

- (UIButton *)offStageBtn {
    if(!_offStageBtn) {
        _offStageBtn = [[UIButton alloc] init];
        _offStageBtn.layer.cornerRadius = 28;
        _offStageBtn.layer.masksToBounds = YES;
        _offStageBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        _offStageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_offStageBtn setTitle:@"下台" forState:UIControlStateNormal];
        [_offStageBtn setTitleColor:HexAlphaColor(0xFFFFFF, 1.0) forState:UIControlStateNormal];
        _offStageBtn.backgroundColor = HexAlphaColor(0xFF2935,1.0);
    }
    return _offStageBtn;
}

#pragma mark ---
#pragma mark Action

- (void)offStageBtnAction {
    if(self.offStageBlock) {
        self.offStageBlock();
    }
    [self dismissAnimated:YES];
}


- (void)cancelBtnAction {
    if(self.cancelBlock) {
        self.cancelBlock();
    }
    [self dismissAnimated:YES];
}

@end
