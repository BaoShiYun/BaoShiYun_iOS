//
//  BSYInteractiveLiveCameraCell.m
//  BaoShiYun
//
//  Created by DuanGuangming on 2021/3/2.
//

#import "BSYInteractiveLiveCameraCell.h"
#import "InsetsLabel.h"

@interface BSYInteractiveLiveCameraCell ()

@property (nonatomic, strong) UIView *mediaContentView;

@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *microView;
@property (nonatomic, strong) UIImageView *volumeView;

@property (nonatomic, strong) UIImageView *emptyView;

@end

@implementation BSYInteractiveLiveCameraCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubView];
        [self bindViewModel];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)createSubView {
    self.contentView.backgroundColor = HexColor(0x434343);
    self.contentView.layer.borderColor = HexAlphaColor(0xFF6600, 0.8).CGColor;
    
    self.mediaContentView = [[UIView alloc] init];
    [self.contentView addSubview:self.mediaContentView];
    
    self.tagLabel = [[InsetsLabel alloc] initWithInsets:UIEdgeInsetsMake(1, 2, 1, 2)];
    self.tagLabel.backgroundColor = HexColor(0x9A3100);
    self.tagLabel.textColor = [UIColor whiteColor];
    self.tagLabel.font = [UIFont systemFontOfSize:8];
    self.tagLabel.layer.cornerRadius = 1;
    self.tagLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:self.tagLabel];
    
    self.nameLabel = [[InsetsLabel alloc] initWithInsets:UIEdgeInsetsMake(1, 2, 1, 2)];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:8];
    self.tagLabel.text = @"讲师";
    [self.contentView addSubview:self.nameLabel];
    
    self.microView = [[UIImageView alloc] initWithImage:AssetsImage(@"live_interactive_micro_disable")];
    [self.contentView addSubview:self.microView];

    self.volumeView = [[UIImageView alloc] initWithImage:AssetsImage(@"live_interactive_volume")];
    [self.contentView addSubview:self.volumeView];

    self.emptyView = [[UIImageView alloc] initWithImage:AssetsImage(@"live_interactive_empty")];
    self.emptyView.contentMode = UIViewContentModeCenter;
    self.emptyView.backgroundColor = HexColor(0xD8D8D8);
    [self.contentView addSubview:self.emptyView];
}

- (void)updateConstraints {
    [super updateConstraints];

    [self.mediaContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.microView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.microView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-2);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-2);
    }];
    [@[self.tagLabel, self.nameLabel] mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(6);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-2);
        make.right.mas_lessThanOrEqualTo(self.microView.mas_left).mas_offset(-6);
    }];
    [self.volumeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(2);
        make.right.mas_equalTo(self.contentView).mas_offset(-2);
    }];
    [self.emptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)bindViewModel {
    self.isEmpty = YES;
    self.isSelf = NO;
    self.isTeacher = NO;
    self.volume = 0;
    self.audioMute = YES;
}

- (void)setIsEmpty:(BOOL)isEmpty {
    _isEmpty = isEmpty;
    
    self.emptyView.hidden = !isEmpty;
}

- (void)setIsSelf:(BOOL)showBorder {
    _isSelf = showBorder;
    if (showBorder) {
        self.contentView.layer.borderWidth = 1;
    } else {
        self.contentView.layer.borderWidth = 0;
    }
    [self reloadNickName];
}

- (void)setIsTeacher:(BOOL)isTeacher {
    _isTeacher = isTeacher;
    self.nameLabel.hidden = isTeacher;
    self.tagLabel.hidden = !isTeacher;
}

- (void)setAudioMute:(BOOL)audioMute {
    _audioMute = audioMute;
    self.microView.hidden = !audioMute;
}

- (void)setVideoMute:(BOOL)videoMute {
    _videoMute = videoMute;
    self.mediaContentView.hidden = videoMute;
}

- (void)setVolume:(NSInteger)volume {
    _volume = volume;
    self.volumeView.hidden = (volume < 10);
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideVolume) object:nil];
    [self performSelector:@selector(hideVolume) withObject:nil afterDelay:1];
}

- (void)hideVolume {
    self.volumeView.hidden = YES;
}

- (void)setNickName:(NSString *)nickName {
    _nickName = nickName;
    [self reloadNickName];
}

- (void)reloadNickName {
    NSString *role = nil;
    if (self.isSelf) {
        role = @"自己：";
    } else {
        role = @"学员：";
    }
    self.nameLabel.text = [NSString stringWithFormat:@"%@%@", role?:@"", self.nickName?:@""];
}

@end
