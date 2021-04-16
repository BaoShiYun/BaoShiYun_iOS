//
//  BSYVideoResolutionController.m
//  KaiKeBa
//
//  Created by zddMac on 2019/4/24.
//  Copyright © 2019 kaikeba. All rights reserved.
//

#import "BSYVideoResolutionController.h"
#import "BSYVideoResolutionTableViewCell.h"
#import "BSYVideoResolutionDspModel.h"


@interface BSYVideoResolutionController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BSYVideoResolutionDspModel *selectResolution;
@property (nonatomic, strong) UIView *blankView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<BSYVideoResolutionDspModel *>  *resolutionList;
@end



@implementation BSYVideoResolutionController

- (instancetype)initResolutionList:(NSArray<BSYVideoResolutionDspModel *> *)resolutionlist defaultResolution:(BSYVideoResolutionDspModel *)defautResolution {
    self = [self initWithStyle:KKBAlertControllerStyle_SlideRight];
    if (self) {
        self.resolutionList = resolutionlist;
        self.selectResolution = defautResolution;
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
    CGFloat tableViewHeight = [BSYVideoResolutionTableViewCell cellHeight]*[self.resolutionList count];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.container);
        make.centerY.equalTo(self.container);
        make.width.mas_equalTo(@80.0);
        make.height.mas_equalTo(tableViewHeight);
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
        [_tableView registerClass:[BSYVideoResolutionTableViewCell class] forCellReuseIdentifier:NSStringFromClass(BSYVideoResolutionTableViewCell.class)];
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
    return [self.resolutionList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSYVideoResolutionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BSYVideoResolutionTableViewCell.class)];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BSYVideoResolutionDspModel *resolutionModel = [self.resolutionList objectAtIndex:indexPath.row];
    [cell setTitleText:resolutionModel.resolutionName withHighlight:[resolutionModel.resolution isEqualToString: self.selectResolution.resolution]?YES:NO];
    return cell;
}

#pragma mark --
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [BSYVideoResolutionTableViewCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BSYVideoResolutionDspModel *resolutionModel = [self.resolutionList objectAtIndex:indexPath.row];
    if(![resolutionModel.resolution isEqualToString:self.selectResolution.resolution]) {
        if(self.resolutionSelectBlock) {
            self.resolutionSelectBlock(resolutionModel);
            [self dismiss];
        }
    }
}


- (void)cancelAction {
    if(self.cancelBlock) {
        self.cancelBlock();
        [self dismiss];
    }
}



@end
