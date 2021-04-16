//
//  BSYVideoRateController.m
//  BSYPlayer
//
//  Created by zddMac on 2019/3/14.
//  Copyright © 2019 kaikeba. All rights reserved.
//


#import "BSYVideoRateController.h"
#import "BSYVideoRateTableViewCell.h"


@interface BSYVideoRateController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *blankView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) float selectRate;

@end
@implementation BSYVideoRateController


- (instancetype)initWithDefaultRate:(float)rate {
    self = [self initWithStyle:KKBAlertControllerStyle_SlideRight];
    if (self) {
        self.selectRate = rate;
        [self createSubView];
    }
    return self;
}

#pragma mark -- UI布局初始化

- (void)createSubView {
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.container];
    [self.container addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.blankView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)];
    tapGesture.cancelsTouchesInView = YES;
    tapGesture.numberOfTapsRequired = 1;
    [self.blankView addGestureRecognizer:tapGesture];
    
    
}


#pragma mark --
#pragma mark 视图布局约束

- (void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self);
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.top.bottom.equalTo(self.view);
        make.width.mas_equalTo(180);
            
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.container);
        make.centerY.equalTo(self.container);
        make.width.mas_equalTo(@80.0);
        make.height.mas_equalTo([BSYVideoRateTableViewCell cellHeight]*6);
    }];
    
    [self.blankView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.top.bottom.equalTo(self.view);
        make.right.equalTo(self.container.mas_left);
            
    }];
}


#pragma mark --
#pragma mark 懒加载

- (UIView *)container {
    if(!_container) {
        _container = [UIView new];
        _container.backgroundColor = HexAlphaColor(0x000000, 0.8);
    }
    return _container;
}


- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundView = nil;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BSYVideoRateTableViewCell class] forCellReuseIdentifier:NSStringFromClass(BSYVideoRateTableViewCell.class)];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (UIView *)blankView {
    if(!_blankView) {
        _blankView = [UIView new];
        _blankView.backgroundColor = [UIColor clearColor];
    }
    return _blankView;
}



#pragma mark --
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSYVideoRateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BSYVideoRateTableViewCell.class)];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    float rate = [self getRate:indexPath.row];
    [cell setTitleText:[self getRateText:indexPath.row] withHighlight:rate==self.selectRate?YES:NO];
    return cell;
}

#pragma mark --
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [BSYVideoRateTableViewCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    float rate = [self getRate:indexPath.row];
    if(rate != self.selectRate) {
        if(self.rateSelectBlock) {
            self.rateSelectBlock(rate);
        }
        [self dismiss];
    }
}

#pragma mark ---
#pragma mark 信息获取

- (NSString *)getRateText:(NSInteger)index {
    NSString *rateText = @"1.0";
    switch (index) {
        case 0:
            rateText = @"0.5";
            break;
        case 1:
            rateText = @"0.8";
            break;
        case 2:
            rateText = @"1.0";
            break;
        case 3:
            rateText = @"1.25";
            break;
        case 4:
            rateText = @"1.5";
            break;
        case 5:
            rateText = @"2.0";
            break;
        default:
            break;
    }
    return rateText;
}


-(float)getRate:(NSInteger)index {
    float rate = 1.0;
    switch (index) {
        case 0:
            rate = 0.5;
            break;
        case 1:
            rate = 0.8;
            break;
        case 2:
            rate = 1.0;
            break;
        case 3:
            rate = 1.25;
            break;
        case 4:
            rate = 1.5;
            break;
        case 5:
            rate = 2.0;
            break;
        default:
            break;
    }
    return rate;
}

- (void)cancelAction {
    if(self.cancelBlock) {
        self.cancelBlock();
        [self dismiss];
    }
}



@end
