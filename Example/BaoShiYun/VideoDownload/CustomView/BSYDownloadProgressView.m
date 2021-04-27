//
//  BSYDownloadProgressView.m
//  BaoShiYun
//
//  Created by zddMac on 2021/4/22.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYDownloadProgressView.h"

@interface BSYDownloadProgressView ()

@property (nonatomic, strong)UIProgressView   *downloadProgress;
@property (nonatomic, strong)UILabel         *downloadLabel;
@property (nonatomic, strong)UILabel         *sizeLabel;
@property (nonatomic, assign)NSUInteger         fileSize;

@end

@implementation BSYDownloadProgressView

- (instancetype)init {
    self = [super init];
    if(self) {
        [self createSubView];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)createSubView {
    [self addSubview:self.downloadProgress];
    [self addSubview:self.downloadLabel];
    [self addSubview:self.sizeLabel];
}


- (void)updateConstraints {
    [super updateConstraints];
    [self.downloadProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(2);
    }];
    
    [self.downloadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(14);
    }];
    
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(14);
    }];
    
}



- (UIProgressView *)downloadProgress {
    if(!_downloadProgress) {
        _downloadProgress = [[UIProgressView alloc] init];
        _downloadProgress.clipsToBounds = YES;
        _downloadProgress.trackTintColor = HexAlphaColor(0xe6e6e6,1.0);
        _downloadProgress.progressTintColor = HexAlphaColor(0x00a5ff,1.0);
    }
    return _downloadProgress;
}

- (UILabel *)downloadLabel {
    if(!_downloadLabel) {
        _downloadLabel = [[UILabel alloc] init];
        _downloadLabel.backgroundColor = [UIColor clearColor];
        _downloadLabel.textAlignment = NSTextAlignmentLeft;
        _downloadLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
        _downloadLabel.textColor = HexAlphaColor(0x00a5ff,1.0);
    }
    return _downloadLabel;
}

- (UILabel *)sizeLabel {
    if(!_sizeLabel) {
        _sizeLabel = [[UILabel alloc] init];
        _sizeLabel.backgroundColor = [UIColor clearColor];
        _sizeLabel.textAlignment = NSTextAlignmentRight;
        _sizeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
        _sizeLabel.textColor = HexAlphaColor(0x999999, 1.0);
    }
    return _sizeLabel;
}


- (void)setFileSize:(NSUInteger)fileSize {
    _fileSize = fileSize;
    self.sizeLabel.text = [BSYUtility fileSizeToString:fileSize];
}

- (void)updateState:(BSYDownloadState)state withSpeed:(NSUInteger)speed withUpdateProgress:(CGFloat)progress {
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self);
        self.downloadProgress.progress = progress;
        switch (state) {
            case BSYDownloadStateReadying:
                self.downloadLabel.text = @"等待下载";
                break;
            case BSYDownloadStateRunning:
                self.downloadLabel.text = [BSYUtility fileSizeToString:speed];
                break;
            case BSYDownloadStateSuspended:
                self.downloadLabel.text = @"暂停";
                break;
            case BSYDownloadStateFailed:
                self.downloadLabel.text = @"下载失败";
                break;
            case BSYDownloadStateCompleted:
                self.downloadLabel.text = @"已完成";
                break;
                
            default:
                break;
        }
    });
}

+ (CGFloat)viewHeight {
    return 19.0;
}




@end
