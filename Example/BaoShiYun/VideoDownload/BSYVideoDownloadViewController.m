//
//  BSYVideoDownloadViewController.m
//  BaoShiYun
//
//  Created by zddMac on 2021/4/22.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYVideoDownloadViewController.h"

@interface BSYVideoDownloadViewController ()
@property (nonatomic, strong)UIButton *returnBtn;
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation BSYVideoDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.returnBtn];
    [self.returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}


- (void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self);
    [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.width.mas_equalTo(40);
        make.top.mas_equalTo(IPHONE_MARGIN_TOP);
    }];
}


- (UIButton *)returnBtn {
    if(!_returnBtn) {
        _returnBtn = [[UIButton alloc] init];
        [_returnBtn setImage:AssetsImage(@"navi_return_dark") forState:UIControlStateNormal];
        [_returnBtn setImage:AssetsImage(@"navi_return_dark") forState:UIControlStateHighlighted];
    }
    return _returnBtn;
}


@end
