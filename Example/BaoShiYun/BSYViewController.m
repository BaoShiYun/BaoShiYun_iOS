//
//  BSYViewController.m
//  BaoShiYun
//
//  Created by duanguangming@gmail.com on 12/25/2020.
//  Copyright (c) 2020 duanguangming@gmail.com. All rights reserved.
//

#import "BSYViewController.h"
#import "BSYLiveViewController.h"
#import "BSYConfig.h"
#import "BSYLiveEntryPageController.h"
#import "BSYVideoViewController.h"
#import "BSYVideoListViewController.h"

@interface BSYViewController ()

@property (nonatomic, strong) UIButton *liveBtn;
@property (nonatomic, strong) UIButton *vodBtn;

@end

@implementation BSYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.liveBtn];
    [self.liveBtn addTarget:self action:@selector(liveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.vodBtn];
    [self.vodBtn addTarget:self action:@selector(vodBtnAction) forControlEvents:UIControlEventTouchUpInside];
    @weakify(self);
    [self.liveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY).with.offset(-40);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.vodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.liveBtn.mas_bottom).with.offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
}

- (UIButton *)liveBtn {
    if(!_liveBtn) {
        _liveBtn = [[UIButton alloc] init];
        _liveBtn.layer.cornerRadius = 20;
        _liveBtn.layer.masksToBounds = YES;
        _liveBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        _liveBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_liveBtn setTitle:@"直播" forState:UIControlStateNormal];
        [_liveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _liveBtn.backgroundColor = [UIColor colorWithRed:0x00 green:0x00 blue:0x00 alpha:1.0];
    }
    return _liveBtn;
}


- (UIButton *)vodBtn {
    if(!_vodBtn) {
        _vodBtn = [[UIButton alloc] init];
        _vodBtn.layer.cornerRadius = 20;
        _vodBtn.layer.masksToBounds = YES;
        _vodBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        _vodBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_vodBtn setTitle:@"点播" forState:UIControlStateNormal];
        [_vodBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _vodBtn.backgroundColor = [UIColor colorWithRed:0x00 green:0x00 blue:0x00 alpha:1.0];
    }
    return _vodBtn;
}


-(BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)liveBtnAction {
    
    BSYLiveEntryPageController *liveController = [[BSYLiveEntryPageController alloc] init];
    
//    BSYLiveParam *param = [[BSYLiveParam alloc] init];
//    param.userId = @"5488885";
//    param.tenantId = BSYConfig.tencentId;
//    param.enterCode = @"05d6acd00b414a939b634eb001f298fa";
//    param.liveId = @"live-847494715441152";
//    param.nickName = @"浪里个浪";
//    param.avatarUrl = @"";
//    BSYLiveViewController *live = [[BSYLiveViewController alloc] initWithLiveParam:param];
    [self.navigationController pushViewController:liveController animated:YES];
}

- (void)vodBtnAction {
    BSYVideoListViewController *vodListController = [[BSYVideoListViewController alloc] init];
    [self.navigationController pushViewController:vodListController animated:YES];
//    BSYVideoViewController *videoController = [[BSYVideoViewController alloc] init];
//    [self.navigationController pushViewController:videoController animated:YES];
}

- (void)interactiveBtnAction {
    BSYLiveParam *param = [[BSYLiveParam alloc] init];
    param.userId = @"5488885";
    param.tenantId = BSYConfig.tencentId;
    param.enterCode = @"dae73c91c58f4bdd9279453e86b8512e";
    param.liveId = @"live-847494726975488";
    param.nickName = @"浪里个浪";
    param.avatarUrl = @"";
    BSYLiveViewController *live = [[BSYLiveViewController alloc] initWithLiveParam:param];
    [self.navigationController pushViewController:live animated:YES];
}

@end
