//
//  BSYLiveRouteOptionController.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/11.
//

#import "BSYLiveRouteOptionController.h"
#import "BSYLiveMenuOptionCell.h"

@interface BSYLiveRouteOptionController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UIView *blankView;
@property (nonatomic, strong)UIView *container;
@property (nonatomic, strong)UIView *tableContainer;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIButton *cancelBtn;

@property (nonatomic, strong)NSArray<BSYLiveLineModel *> *routeList;
@property (nonatomic, strong)BSYLiveLineModel *curRoute;

@end

@implementation BSYLiveRouteOptionController

- (instancetype)initRouteList:(NSArray<BSYLiveLineModel *> *)routeList currentRoute:(BSYLiveLineModel *)curRoute {
    self = [self initWithStyle:KKBAlertControllerStyle_ActionSheet];
    if(self) {
        self.routeList = routeList;
        self.curRoute = curRoute;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubView];
   // self.view.backgroundColor = HexAlphaColor(0x000000, 0.8);
    // Do any additional setup after loading the view.
}

- (void)createSubView {
    [self.view addSubview:self.blankView];
    [self.view addSubview:self.container];
    [self.container addSubview:self.tableContainer];
    [self.tableContainer addSubview:self.tableView];
    [self.container  addSubview:self.cancelBtn];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelBtnAction)];
    tapGesture.cancelsTouchesInView = YES;
    tapGesture.numberOfTapsRequired = 1;
    [self.blankView addGestureRecognizer:tapGesture];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self);
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(256+IPHONE_MARGIN_BOTTOM);
    }];
    
    [self.tableContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.equalTo(self.container);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(188);
    }];
    
    CGFloat tableHeight = MIN([BSYLiveMenuOptionCell cellHeight]*self.routeList.count, 188);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.centerY.equalTo(self.tableContainer);
        make.height.mas_equalTo(tableHeight);
        
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.equalTo(self.container);
        make.height.mas_equalTo(48);
        make.top.equalTo(self.tableContainer.mas_bottom);
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

- (UIView *)tableContainer {
    if(!_tableContainer) {
        _tableContainer = [[UIView alloc] init];
    }
    return _tableContainer;
}


- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[BSYLiveMenuOptionCell class] forCellReuseIdentifier:NSStringFromClass([BSYLiveMenuOptionCell class])];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
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



#pragma mark --
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.routeList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSYLiveMenuOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BSYLiveMenuOptionCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    BSYLiveLineModel *routeModel = [self.routeList objectAtIndex:indexPath.row];
    BOOL isSelected = NO;
    if(self.curRoute && [routeModel.lineId isEqualToString:self.curRoute.lineId]) {
        isSelected = YES;
    }
    [cell setTitleText:routeModel.lineName withHighlight:isSelected];
    return cell;
}

#pragma mark --
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [BSYLiveMenuOptionCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BSYLiveLineModel *routeModel = [self.routeList objectAtIndex:indexPath.row];
    if(![routeModel.lineId isEqualToString:self.curRoute.lineId]) {
        if(self.selectedBlock) {
            self.selectedBlock(routeModel);
            [self dismiss];
        }
    }
}



- (void)cancelBtnAction {
    if(self.cancelBlock) {
        self.cancelBlock();
    }
    [self dismissAnimated:YES];
}

@end
