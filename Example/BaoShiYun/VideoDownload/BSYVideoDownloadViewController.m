//
//  BSYVideoDownloadViewController.m
//  BaoShiYun
//
//  Created by zddMac on 2021/4/22.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYVideoDownloadViewController.h"
#import "BSYDownloadTableCell.h"
#import "BSYVideoViewController.h"

@interface BSYVideoDownloadViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UIButton *returnBtn;
@property (nonatomic, strong)UIView *containerView;
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation BSYVideoDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HexColor(0xE6E6E6);
    [self.view addSubview:self.returnBtn];
    [self.returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.tableView];
}


- (void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self);
    [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.width.mas_equalTo(40);
        make.top.mas_equalTo(IPHONE_MARGIN_TOP);
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
        [_tableView registerClass:BSYDownloadTableCell.class forCellReuseIdentifier:NSStringFromClass(BSYDownloadTableCell.class)];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [BSYDownloadTableCell cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [BSYDownloadSessionManager sharedInstance].downloadTaskList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSYDownloadTableCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass(BSYDownloadTableCell.class)];
    BSYDownloadModel *downloadModel = [[BSYDownloadSessionManager sharedInstance].downloadTaskList objectAtIndex:indexPath.row];
    [cell setContentImageUrl:[self getImageUrlWithMediaId:downloadModel.mediaId]];
    cell.downloadModel = downloadModel;
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    BSYDownloadModel *downloadModel = [[BSYDownloadSessionManager sharedInstance].downloadTaskList objectAtIndex:indexPath.row];
    [[BSYDownloadSessionManager sharedInstance] deleteDownloadTask:downloadModel];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BSYDownloadModel *downloadModel = [[BSYDownloadSessionManager sharedInstance].downloadTaskList objectAtIndex:indexPath.row];
    if(downloadModel.state==BSYDownloadStateCompleted) {
        BSYVideoViewController *videoController = [[BSYVideoViewController alloc] initWithLocalVideo:downloadModel];
        [self.navigationController pushViewController:videoController animated:YES];
    } else if (downloadModel.state==BSYDownloadStateRunning || downloadModel.state==BSYDownloadStateReadying) {
        [[BSYDownloadSessionManager sharedInstance] suspendDownloadTask:downloadModel];
        
    } else if (downloadModel.state==BSYDownloadStateFailed || downloadModel.state==BSYDownloadStateSuspended) {
        [[BSYDownloadSessionManager sharedInstance] resumeDownloadTask:downloadModel];
    }
}

#pragma mark ---
#pragma mark Action
- (void)returnBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSString *)getImageUrlWithMediaId:(NSString *)mediaId {
    
    NSDictionary *dataDic = @{
        @"media-848899839229952":@"https://bkimg.cdn.bcebos.com/pic/9e3df8dcd100baa1cd114d0c2b5bae12c8fcc3ce807b?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2U5Mg==,g_7,xp_5,yp_5/format,f_auto",
        @"media-848899856007168":@"https://bkimg.cdn.bcebos.com/pic/86d6277f9e2f0708283888f4816eaf99a9014d0854a6",
        @"media-848899874390016":@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.sj520.cn%2Fsc%2Fima%2F1%2Fb_jr00146.jpg&refer=http%3A%2F%2Fwww.sj520.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1621948860&t=930425a19b0fccb43cbea8e91bc4f14a"
        
    };
    NSString *url = [dataDic objectForKey:mediaId];
    return url;
};



@end
