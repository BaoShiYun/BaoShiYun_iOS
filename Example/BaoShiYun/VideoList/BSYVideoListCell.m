//
//  BSYVideoListCell.m
//  BaoShiYun
//
//  Created by zddMac on 2021/4/25.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYVideoListCell.h"
#import "BSYVideoDownloadView.h"

@interface BSYVideoListCell()
@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) BSYVideoDownloadView *downloadView;
@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UIImageView *coverPlayIcon;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) NSDictionary *videoInfo;



@end

@implementation BSYVideoListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self createSubView];
        [self setNeedsUpdateConstraints];
        [self bindViewModel];
    }
    return self;
}

- (void)createSubView {
    [self.contentView addSubview:self.cardView];
    [self.cardView addSubview:self.nameLabel];
    [self.cardView addSubview:self.downloadView];
    [self.cardView addSubview:self.coverView];
    [self.coverView addSubview:self.coverPlayIcon];
    [self.coverView addSubview:self.durationLabel];
}

- (void)updateConstraints {
    [super updateConstraints];
    @weakify(self);
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(20);
        make.centerY.equalTo(self.downloadView);
        make.right.equalTo(self.downloadView.mas_left).with.offset(-5);
        make.height.mas_equalTo(30);
    }];
    [self.downloadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-24);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(42);
    }];
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.equalTo(self.cardView);
        make.height.mas_equalTo(190);
        make.top.equalTo(self.downloadView.mas_bottom).with.offset(10);
    }];
    
    [self.coverPlayIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.coverView);
        make.top.mas_equalTo(58);
        make.height.width.mas_equalTo(54);
    }];
    [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.coverPlayIcon.mas_bottom).with.offset(9);
        make.centerX.equalTo(self.coverPlayIcon);
    }];
}

- (void)bindViewModel {
    @weakify(self);
    [[self.downloadView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.downloadAction) {
            NSString *mediaId = [self.videoInfo objectForKey:BSYVideoMediaId];
            self.downloadAction(mediaId);
        }
    }];
    [[RACObserve(self, downloadModel.state) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        NSNumber *stateNume = x;
        BSYDownloadState state = [stateNume unsignedIntegerValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            switch (state) {
                case BSYDownloadStateCompleted: {
                    self.downloadView.icon.image = AssetsImage(@"video_content_downloaded");
                    self.downloadView.label.text = @"已下载";
                    [self.downloadView showAnimation:NO];
                    self.downloadView.enabled = NO;
                }
                    break;
                case BSYDownloadStateSuspended:
                case BSYDownloadStateFailed:
                case BSYDownloadStateReadying:
                case BSYDownloadStateRunning: {
                    self.downloadView.icon.image = AssetsImage(@"video_content_loading");
                    self.downloadView.label.text = @"下载中";
                    [self.downloadView showAnimation:YES];
                    self.downloadView.enabled = NO;
                }
                    break;
                case BSYDownloadStateNone:
                default: {
                    self.downloadView.enabled = YES;
                    self.downloadView.icon.image = AssetsImage(@"video_content_download");
                    self.downloadView.label.text = @"下载";
                   [self.downloadView showAnimation:NO];
                }
                    break;
            }
        });
        
            
    }];
}

#pragma mark 懒加载
- (UIView *)cardView {
    if(!_cardView) {
        _cardView = [[UIView alloc] init];
        _cardView.clipsToBounds = YES;
        _cardView.layer.cornerRadius = 13;
        _cardView.layer.masksToBounds = YES;
        _cardView.backgroundColor = UIColor.whiteColor;
    }
    return _cardView;
}

- (UILabel *)nameLabel {
    if(!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:16];
        _nameLabel.textColor = HexAlphaColor(0x030303, 1.0);
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

- (BSYVideoDownloadView *)downloadView {
    if(!_downloadView) {
        _downloadView = [[BSYVideoDownloadView alloc] init];
    }
    return _downloadView;
}

- (UIImageView *)coverView {
    if(!_coverView) {
        _coverView = [[UIImageView alloc] init];
        _coverView.clipsToBounds = YES;
        _coverView.contentMode = UIViewContentModeScaleAspectFill;
        _coverView.userInteractionEnabled = YES;
    }
    return _coverView;
}

- (UIImageView *)coverPlayIcon {
    if(!_coverPlayIcon) {
        _coverPlayIcon = [[UIImageView alloc] init];
        _coverView.userInteractionEnabled = YES;
        _coverPlayIcon.image = AssetsImage(@"video_content_play");
    }
    return _coverPlayIcon;
}

- (UILabel *)durationLabel {
    if(!_durationLabel) {
        _durationLabel = [[UILabel alloc] init];
        _durationLabel.font = [UIFont systemFontOfSize:11];
        _durationLabel.textColor = HexAlphaColor(0xFFFFFF, 1.0);
        _durationLabel.numberOfLines = 0;
    }
    return _durationLabel;
}

- (void)setVideoInfo:(NSDictionary *)info {
    if(info) {
        _videoInfo = info;
        NSString *name = [info objectForKey:BSYVideoName];
        self.nameLabel.text = name;
        NSUInteger duration = [[info objectForKey:BSYVideoDuration] unsignedIntegerValue];
        NSString *timeStr = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)duration/3600,(int)duration/60%60,(int)duration%60];
        self.durationLabel.text = timeStr;
        NSString *coverImg = [info objectForKey:BSYVideoCoverImg];
        [self.coverView sd_setImageWithURL:[NSURL URLWithString:coverImg]];
    }
   
}

+(CGFloat)cellHeight {
    return 282;
}

@end
