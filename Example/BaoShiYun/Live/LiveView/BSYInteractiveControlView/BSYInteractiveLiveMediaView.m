//
//  BSYInteractiveLiveMediaView.m
//  BaoShiYun
//
//  Created by zddMac on 2021/3/2.
//

#import "BSYInteractiveLiveMediaView.h"



@interface BSYInteractiveLiveMediaView()
@property (nonatomic, strong)UIButton *mediaBtn;
@property (nonatomic, strong)UILabel *statusLabel;
@property (nonatomic, assign)BOOL mediaEnable;
@property (nonatomic, assign)BOOL isOpen;
@property (nonatomic, assign)BSYInteractiveLiveMediaType mediaType;

@end

@implementation BSYInteractiveLiveMediaView

- (instancetype)initWithType:(BSYInteractiveLiveMediaType)type withEnable:(BOOL)isEnable withStatus:(BOOL)isOpen {
    self = [super init];
    if(self) {
        self.mediaType = type;
        self.mediaEnable = isEnable;
        self.isOpen = isOpen;
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    [self addSubview:self.mediaBtn];
    [self.mediaBtn addTarget:self action:@selector(mediaBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.statusLabel];
    [self updateStatus];
}

- (void)updateConstraints {
    [super updateConstraints];
    @weakify(self);
    [self.mediaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.top.equalTo(self);
        make.width.height.equalTo(self.mas_width);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self);
        make.top.equalTo(self.mediaBtn.mas_bottom).with.offset(8);
        make.height.mas_equalTo(22);
    }];
}

#pragma mark ---
#pragma mark 懒加载

- (UIButton *)mediaBtn {
    if(!_mediaBtn) {
        _mediaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _mediaBtn;
}

- (UILabel *)statusLabel {
    if(!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}

- (void)updateStatus {
    
    NSString *icon = nil;
    if(self.mediaType==BSYInteractiveLiveMediaType_Mic) {
        if(self.mediaEnable) {
            if(self.isOpen) {
                icon = @"live_mic_status_open";
            } else {
                icon = @"live_mic_status_close";
            }
        } else {
            icon = @"live_mic_status_disable";
        }
    } else if(self.mediaType==BSYInteractiveLiveMediaType_Camera) {
        if(self.mediaEnable) {
            if(self.isOpen) {
                icon = @"live_cam_status_open";
            } else {
                icon = @"live_cam_status_close";
            }
        } else {
            icon = @"live_cam_status_disable";
        }
    }
    if(icon) {
        [self.mediaBtn setImage:AssetsImage(icon) forState:UIControlStateNormal];
        [self.mediaBtn setImage:AssetsImage(icon) forState:UIControlStateHighlighted];
        if(self.mediaEnable) {
            self.statusLabel.textColor = HexAlphaColor(0xBFBFBF, 1.0);
            if(self.isOpen) {
                self.statusLabel.text = @"已开启";
            } else {
                self.statusLabel.text = @"已关闭";
            }
        } else {
            self.statusLabel.text = @"已禁用";
            self.statusLabel.textColor = HexAlphaColor(0x595959, 1.0);
        }
    }
}

- (void)mediaBtnAction {
    if(self.mediaEnable) {
        self.isOpen = !self.isOpen;
        if(self.mediaBlock) {
            self.mediaBlock(self.mediaType, self.isOpen);
        }
        [self updateStatus];
    }
}

- (void)setStatus:(BOOL)isOpen {
    self.isOpen = isOpen;
    [self updateStatus];
}


@end
