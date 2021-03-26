//
//  BSYLiveMenuViewController.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/11.
//

#import "BSYLiveMenuViewController.h"

@interface BSYLiveMenuViewController ()

@property (nonatomic, strong)UIView *blankView;
@property (nonatomic, strong)UIView *container;
@property (nonatomic, strong)UIButton *resolutionBtn;
@property (nonatomic, strong)UILabel *resolutionLabel;
@property (nonatomic, strong)UIButton *routeBtn;
@property (nonatomic, strong)UILabel *routeLabel;

@property (nonatomic, strong)UIButton *cancelBtn;

@end

@implementation BSYLiveMenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = HexAlphaColor(0x000000, 0.8);
    [self.view addSubview:self.blankView];
    [self.view addSubview:self.container];
    [self.container addSubview:self.resolutionBtn];
    [self.container addSubview:self.resolutionLabel];
    [self.container addSubview:self.routeBtn];
    [self.container addSubview:self.routeLabel];
    [self.container addSubview:self.cancelBtn];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelBtnAction)];
    tapGesture.cancelsTouchesInView = YES;
    tapGesture.numberOfTapsRequired = 1;
    [self.blankView addGestureRecognizer:tapGesture];
    
    [self.resolutionBtn addTarget:self action:@selector(resolutionBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.routeBtn addTarget:self action:@selector(routeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self);
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(5);
        make.height.mas_equalTo(160+IPHONE_MARGIN_BOTTOM);
    }];
    
    [self.resolutionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(20);
        make.height.width.mas_equalTo(45);
    }];
    
    [self.resolutionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.resolutionBtn.mas_bottom).with.offset(9);
        make.centerX.equalTo(self.resolutionBtn);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(60);
    }];
    
    [self.routeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.resolutionBtn.mas_right).with.offset(28);
        make.top.equalTo(self.resolutionBtn);
        make.height.width.mas_equalTo(45);
    }];
    
    [self.routeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.routeBtn.mas_bottom).with.offset(9);
        make.centerX.equalTo(self.routeBtn);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(60);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.equalTo(self.container);
        make.height.mas_equalTo(48);
        make.top.equalTo(self.routeLabel.mas_bottom).with.offset(19);
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
        _container.backgroundColor = HexAlphaColor(0x1C1C1E, 1.0);
        _container.layer.cornerRadius= 8;
        _container.layer.masksToBounds = YES;
    }
    return _container;
}

- (UIButton *)resolutionBtn {
    if(!_resolutionBtn) {
        _resolutionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resolutionBtn setImage:AssetsImage(@"live_switch_resolution_icon") forState:UIControlStateNormal];
        [_resolutionBtn setImage:AssetsImage(@"live_switch_resolution_icon") forState:UIControlStateHighlighted];
    }
    return _resolutionBtn;
}

- (UILabel *)resolutionLabel {
    if(!_resolutionLabel) {
        _resolutionLabel = [[UILabel alloc] init];
        _resolutionLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _resolutionLabel.text = @"切换清晰度";
        _resolutionLabel.textAlignment = NSTextAlignmentCenter;
        _resolutionLabel.textColor = HexAlphaColor(0x9D9FA7, 1.0);
    }
    return _resolutionLabel;
}

- (UIButton *)routeBtn {
    if(!_routeBtn) {
        _routeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_routeBtn setImage:AssetsImage(@"live_switch_route_icon") forState:UIControlStateNormal];
        [_routeBtn setImage:AssetsImage(@"live_switch_route_icon") forState:UIControlStateHighlighted];
    }
    return _routeBtn;
}

- (UILabel *)routeLabel {
    if(!_routeLabel) {
        _routeLabel = [[UILabel alloc] init];
        _routeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _routeLabel.text = @"切换线路";
        _routeLabel.textAlignment = NSTextAlignmentCenter;
        _routeLabel.textColor = HexAlphaColor(0x9D9FA7, 1.0);
    }
    return _routeLabel;
}

- (UIButton *)cancelBtn {
    if(!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.backgroundColor = HexAlphaColor(0x2C2C2E, 1.0);
        _cancelBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateHighlighted];
    }
    return _cancelBtn;
}

#pragma mark ---
#pragma mark 懒加载

- (void)resolutionBtnAction {
    if(self.menuBlock) {
        self.menuBlock(BSYLiveMenuType_Resolution);
    }
}

- (void)routeBtnAction {
    if(self.menuBlock) {
        self.menuBlock(BSYLiveMenuType_Route);
    }
}


- (void)cancelBtnAction {
    if(self.menuBlock) {
        self.menuBlock(BSYLiveMenuType_Cancel);
    }
    [self dismissAnimated:YES];
}

@end
