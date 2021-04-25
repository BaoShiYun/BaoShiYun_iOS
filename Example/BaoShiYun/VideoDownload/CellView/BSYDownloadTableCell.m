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
@property (nonatomic, strong)UIView                    *downloadMask;
@property (nonatomic, strong)UIImageView               *downloadIcon;
@property (nonatomic, strong)UIView                    *container;
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
    }
    return self;
}

- (void)createSubView {
    
}

+ (CGFloat)cellHeight {
    return 80;
}


- (UIView *)downloadMask {
    if(!_downloadMask) {
        _downloadMask = [[UIView alloc] init];
        _downloadMask.backgroundColor = HexAlphaColor(0x000000, .4); // MKRGBA(0x00, 0x00, 0x00, 0.4);
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


- (UIView *)container {
    if(!_container) {
        _container = [[UIView alloc] init];
    }
    return _container;
}

- (UIImageView *)contentImage {
    if(!_contentImage) {
        _contentImage = [UIImageView new];
        _contentImage.contentMode = UIViewContentModeScaleToFill;
        _contentImage.userInteractionEnabled = YES;
    }
    return _contentImage;
}

- (UILabel *)contentLabel
{
    if(!_contentLabel)
    {
        _contentLabel = [UILabel new];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
        _contentLabel.textColor = HexAlphaColor(0x000000, 1.0);
    }
    return _contentLabel;
}


- (BSYDownloadProgressView *)progressView
{
    if(!_progressView)
    {
        _progressView = [[BSYDownloadProgressView alloc] init];
    }
    return _progressView;
}

- (UIView *)lineView    //#D8D8D8 100%
{
    if(!_lineView)
    {
        _lineView = [UIView new];
        _lineView.backgroundColor = HexColor(0xf3f5f7);
    }
    return _lineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
