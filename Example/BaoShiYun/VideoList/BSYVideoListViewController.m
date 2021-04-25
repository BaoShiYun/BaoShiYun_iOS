//
//  BSYVideoListViewController.m
//  BaoShiYun
//
//  Created by zddMac on 2021/4/22.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYVideoListViewController.h"
#import "BSYVideoListCell.h"
#import "BSYVideoViewController.h"

@interface BSYVideoListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UIButton *returnBtn;
@property (nonatomic, strong)UIButton *downloadBtn;
@property (nonatomic, strong)UIView *containerView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *dataList;

@end

@implementation BSYVideoListViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataList];
    self.view.backgroundColor = HexColor(0xE6E6E6);
    [self.view addSubview:self.returnBtn];
    [self.returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.downloadBtn];
    [self.downloadBtn addTarget:self action:@selector(downloadBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.tableView];
}

- (void)loadDataList {
    self.dataList = @[
    @{
        BSYVideoMediaId:@"media-848899839229952",
        BSYVideoName:@"第一段",
        BSYVideoDuration:@(875),
        BSYVideoCoverImg:@"https://bkimg.cdn.bcebos.com/pic/9e3df8dcd100baa1cd114d0c2b5bae12c8fcc3ce807b?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2U5Mg==,g_7,xp_5,yp_5/format,f_auto"
    },
    @{
        BSYVideoMediaId:@"media-848899856007168 ",
        BSYVideoName:@"第二段",
        BSYVideoDuration:@(921),
        BSYVideoCoverImg:@"https://bkimg.cdn.bcebos.com/pic/86d6277f9e2f0708283888f4816eaf99a9014d0854a6"
    },
    @{
        BSYVideoMediaId:@"media-848899874390016",
        BSYVideoName:@"第三段",
        BSYVideoDuration:@(275),
        BSYVideoCoverImg:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.sj520.cn%2Fsc%2Fima%2F1%2Fb_jr00146.jpg&refer=http%3A%2F%2Fwww.sj520.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1621948860&t=930425a19b0fccb43cbea8e91bc4f14a"
        
    },
    ];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self);
    [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.width.mas_equalTo(40);
        make.top.mas_equalTo(IPHONE_MARGIN_TOP);
    }];
    [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.mas_equalTo(-10);
        make.height.width.mas_equalTo(40);
        make.centerY.equalTo(self.returnBtn);
    }];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.returnBtn.mas_bottom).with.offset(10);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.right.left.equalTo(self.containerView);
        make.bottom.mas_equalTo(-IPHONE_MARGIN_BOTTOM);
    }];
    
}

#pragma mark ---
#pragma mark 懒加载

- (UIButton *)returnBtn {
    if(!_returnBtn) {
        _returnBtn = [[UIButton alloc] init];
        [_returnBtn setImage:AssetsImage(@"navi_return_dark") forState:UIControlStateNormal];
        [_returnBtn setImage:AssetsImage(@"navi_return_dark") forState:UIControlStateHighlighted];
    }
    return _returnBtn;
}

- (UIButton *)downloadBtn {
    if(!_downloadBtn) {
        _downloadBtn = [[UIButton alloc] init];
        [_downloadBtn setImage:AssetsImage(@"video_content_download") forState:UIControlStateNormal];
        [_downloadBtn setImage:AssetsImage(@"video_content_download") forState:UIControlStateHighlighted];
    }
    return _downloadBtn;
}

- (UIView *)containerView {
    if(!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.clipsToBounds = YES;
    }
    return _containerView;
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.scrollsToTop = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:BSYVideoListCell.class forCellReuseIdentifier:NSStringFromClass(BSYVideoListCell.class)];
    }
    return _tableView;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [BSYVideoListCell cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = self.dataList[indexPath.row];
    BSYVideoListCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass(BSYVideoListCell.class)];
    [cell setVideoInfo:data];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = self.dataList[indexPath.row];
    NSString *mediaId = data[BSYVideoMediaId];
    BSYVideoViewController *videoController = [[BSYVideoViewController alloc] initWithMediaId:mediaId];
    [self.navigationController pushViewController:videoController animated:YES];
    
}

#pragma mark ---
#pragma mark Action
- (void)returnBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)downloadBtnAction {
    
}

@end
