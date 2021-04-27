//
//  BSYDownloadTableCell.m
//  BaoShiYun
//
//  Created by zddMac on 2021/4/22.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYDownloadTableCell.h"
#import "BSYDownloadProgressView.h"

@interface BSYDownloadTableCell ()
@property (nonatomic, strong)UIView                    *container;
@property (nonatomic, strong)UIView                    *downloadMask;
@property (nonatomic, strong)UIImageView               *downloadIcon;
@property (nonatomic, strong)UIImageView               *contentImage;
@property (nonatomic, strong)UILabel                   *contentLabel;
@property (nonatomic, strong)BSYDownloadProgressView    *progressView;
@property (nonatomic, strong)UIView                    *lineView;

@end

@implementation BSYDownloadTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubView];
        [self setNeedsUpdateConstraints];
        [self bindViewModel];
    }
    return self;
}

- (void)createSubView {
    [self.contentView addSubview:self.container];
    [self.container addSubview:self.contentImage];
    [self.contentImage addSubview:self.downloadMask];
    [self.downloadMask addSubview:self.downloadIcon];
    [self.container addSubview:self.contentLabel];
    [self.container addSubview:self.progressView];
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.lineView];
}

- (void)updateConstraints {
    [super updateConstraints];
    @weakify(self);
    [self.container mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.contentImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(90);
        make.centerY.equalTo(self.container);
        
    }];
    
    [self.downloadMask mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.contentImage);
    }];
    
    [self.downloadIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.center.equalTo(self.downloadMask);
    }];
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentImage.mas_right).with.offset(15);
        make.top.equalTo(self.container).with.offset(17);
        make.height.mas_equalTo(18);
        make.right.mas_equalTo(0);
    }];
    [self.progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.contentLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentLabel);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo([BSYDownloadProgressView viewHeight]);
    }];
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)bindViewModel {
    @weakify(self);
    [[[RACObserve(self, downloadModel.fileSize) distinctUntilChanged] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber * _Nullable x) {
        NSNumber *fileSizeNume = x;
        UInt64 fileSize = [fileSizeNume unsignedIntegerValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.progressView setFileSize:fileSize];
        });
    }];
    
    [[RACObserve(self, downloadModel.state) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        NSNumber *stateNume = x;
        BSYDownloadState state = [stateNume unsignedIntegerValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            BSYDownloadProgress *progress = self.downloadModel.progress;
            [self.progressView updateState:state withSpeed:progress.speed withUpdateProgress:progress.progress];
        });
    }];
    
    [[RACObserve(self, downloadModel.progress) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        BSYDownloadProgress *progress = x;
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.progressView updateState:self.downloadModel.state withSpeed:progress.speed withUpdateProgress:progress.progress];
        });
    }];
    
    [[RACObserve(self, downloadModel.fileName) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        NSString *name = x;
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            self.contentLabel.text = name;
        });
    }];
    
}


+ (CGFloat)cellHeight {
    return 80;
}

- (UIView *)container {
    if(!_container) {
        _container = [[UIView alloc] init];
    }
    return _container;
}

- (UIView *)downloadMask {
    if(!_downloadMask) {
        _downloadMask = [[UIView alloc] init];
        _downloadMask.backgroundColor = HexAlphaColor(0x000000, .4);
    }
    return _downloadMask;
}

- (UIImageView *)downloadIcon {
    if(!_downloadIcon) {
        _downloadIcon = [UIImageView new];
        _downloadIcon.contentMode = UIViewContentModeScaleToFill;
        _downloadIcon.userInteractionEnabled = YES;
        _downloadIcon.image = AssetsImage(@"download_icon");
        
    }
    return _downloadIcon;
}


- (UIImageView *)contentImage {
    if(!_contentImage) {
        _contentImage = [UIImageView new];
        _contentImage.contentMode = UIViewContentModeScaleToFill;
        
        _contentImage.userInteractionEnabled = YES;
    }
    return _contentImage;
}

- (UILabel *)contentLabel {
    if(!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
        _contentLabel.textColor = HexAlphaColor(0x000000, 1.0);
    }
    return _contentLabel;
}


- (BSYDownloadProgressView *)progressView {
    if(!_progressView) {
        _progressView = [[BSYDownloadProgressView alloc] init];
    }
    return _progressView;
}

- (UIView *)lineView {
    if(!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = HexColor(0xf3f5f7);
    }
    return _lineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentImageUrl:(NSString *)url {
    [self.contentImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:AssetsImage(@"download_default_cover_image")];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
