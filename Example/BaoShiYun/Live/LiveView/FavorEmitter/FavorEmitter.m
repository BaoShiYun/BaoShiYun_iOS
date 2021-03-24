//
//  FavorEmitter.m
//  BSYLive
//
//  Created by Duane on 2020/4/23.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "FavorEmitter.h"
#import "FavorEmitterItem.h"
#import "InsetsLabel.h"

#define kSwayExtraOffset 10.f

@interface FavorEmitter ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *likeLabel;

@property (nonatomic, assign) BOOL updateItemFrames;
@property (nonatomic, assign) BOOL updateFloatArea;
@property (nonatomic, assign) CGRect itemFrames;
@property (nonatomic, assign) CGRect floatArea;
@property (nonatomic, assign) CGRect preFrame;

@end

@implementation FavorEmitter

+ (instancetype)emitterWithImage:(nullable UIImage *)image highlightImage:(nullable UIImage *)hightlightImage {
    CGRect validFrame = CGRectMake(0, 0, image.size.width, image.size.height);
    FavorEmitter *emitter = [[FavorEmitter alloc] initWithFrame:validFrame];
    [emitter assignDefaultValue];
    [emitter assignSubviews];
    [emitter setAppearanceWithImage:image highlightedImage:hightlightImage];
    return emitter;
}

- (void)assignDefaultValue {
    _interactEnabled = YES;
    
    _updateItemFrames = YES;
    _itemFrames = CGRectZero;
    _floatArea = CGRectZero;
    _preFrame = CGRectZero;
    
    _originRange = 1;
    _scale = 1;
    _risingY = 0;
    _extraShift = 10;
    _shiftCycle = 5;
    _risingDuration = 10;
    _risingShiftDuration = 2;
    _fadeOutDuration = 6;
    _fadeOutShiftDuration = 2;
}

- (void)assignSubviews {
    self.btn = [[UIButton alloc] initWithFrame:self.bounds];
    self.btn.backgroundColor = [UIColor clearColor];
    [self.btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn];
    [self.btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.likeLabel = [[InsetsLabel alloc] initWithInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    self.likeLabel.font = [UIFont systemFontOfSize:10];
    self.likeLabel.backgroundColor = UIColor.whiteColor;
    self.likeLabel.layer.cornerRadius = 7;
    self.likeLabel.layer.masksToBounds = YES;
    self.likeLabel.textColor = HexColor(0xE64262);
    self.likeLabel.text = @"0";
    self.likeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.likeLabel];
    [self.likeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_top).mas_offset(5);
        make.height.mas_equalTo(14);
        make.width.mas_greaterThanOrEqualTo(30);
    }];
    
    self.clipsToBounds = NO;
}

- (void)setAppearanceWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    [self.btn setImage:image forState:UIControlStateNormal];
    [self.btn setImage:highlightedImage forState:UIControlStateHighlighted];
}

#pragma mark - item generate

- (void)generateEmitterItem {
    if (_itemImages.count < 1 || !_favorDisplayView) {
        return;
    }
    int randomIndex = arc4random_uniform((int)_itemImages.count);
    
    CGRect frame = [self.superview convertRect:self.frame toView:_favorDisplayView];
    BOOL frameChanged = !CGRectEqualToRect(frame, _preFrame);
    _preFrame = frame;
    if (_updateItemFrames || frameChanged) {
        [self updateItemFramesWithFrame:frame];
        _updateItemFrames = NO;
    }
    
    if (_updateFloatArea || frameChanged) {
        [self updateFloatAreaWithFrame:frame];
        _updateFloatArea = NO;
    }
    
    FavorEmitterItem *item = [FavorEmitterItem emitterWithFrame:_itemFrames floatArea:_floatArea image:_itemImages[randomIndex]];
    [_favorDisplayView.layer addSublayer:item];
    [self assignForEmitterItem:item];
    [item startAnimation];
}

- (void)generateEmitterItemsForItemsCount:(int)count duration:(NSTimeInterval)duration {
    if (!self.interactEnabled) {
        return;
    }
    
    for (int i = 0; i < count; i++) {
       // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*duration/count * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self generateEmitterItem];
        });
        
    }
}

- (void)updateLikeLabelCount:(NSUInteger)likeCount {
    NSString *likeNumStr = @"0";
    if(likeCount>10000)
    {
        CGFloat showNum = likeCount/10000.0;
        likeNumStr = [NSString stringWithFormat:@"%.1fW",showNum];
    }
    else
    {
        likeNumStr = [NSString stringWithFormat:@"%lu",(unsigned long)likeCount];
    }
    self.likeLabel.text = likeNumStr;
}

- (void)btnClicked:(UIButton*)btn {
    if (!_tapHandler) {
        [self generateEmitterItem];
        return;
    }
    
    BOOL generation = _tapHandler();
    if (generation) {
        [self generateEmitterItem];
    }
}

- (void)assignForEmitterItem:(FavorEmitterItem *)item {
    item.shiftCycle = _shiftCycle;
    item.risingDuration = _risingDuration;
    item.minRisingVelocity = _minRisingVelocity;
    item.risingShiftDuration = _risingShiftDuration;
    item.fadeOutDuration = _fadeOutDuration;
    item.fadeOutShiftDuration = _fadeOutShiftDuration;
}

#pragma mark - frame update

- (void)updateItemFramesWithFrame:(CGRect)frame {
    _itemFrames = CGRectMake(frame.origin.x,
                             frame.origin.y - frame.size.height * _scale * 0.5 * _originRange,
                             frame.size.width * _scale,
                             frame.size.height * _scale);
}

- (void)updateFloatAreaWithFrame:(CGRect)frame {
    _floatArea = CGRectMake(CGRectGetMidX(frame) - CGRectGetWidth(frame) * 0.5 - _extraShift,
                            _risingY,
                            frame.size.width + 2 * _extraShift,
                            _favorDisplayView.frame.size.height - frame.size.height);
}

#pragma mark - setter

- (void)setInteractEnabled:(BOOL)interactEnabled {
    if (_interactEnabled == interactEnabled) {
        return;
    }
    
    _interactEnabled = interactEnabled;
    self.btn.enabled = _interactEnabled;
}

- (void)setOriginRange:(CGFloat)originRange {
    if (_originRange != originRange) {
        _originRange = MAX(MIN(originRange, 1), 0);
        _updateItemFrames = YES;
    }
}

- (void)setScale:(CGFloat)scale {
    if (_scale != scale) {
        _scale = MAX(MIN(scale, 1.5), 0.2);
        _updateItemFrames = YES;
    }
}

- (void)setExtraShift:(CGFloat)extraShift {
    if (_extraShift != extraShift) {
        _extraShift = MAX(MIN(extraShift, 100), 10);
        _updateFloatArea = YES;
    }
}

- (void)setRisingY:(CGFloat)risingY {
    if (_risingY != risingY) {
        _risingY = risingY;
        _updateFloatArea = YES;
    }
}

- (void)setShiftCycle:(CGFloat)shiftCycle {
    _shiftCycle = MAX(MIN(shiftCycle, 8), 1);
}

- (void)setRisingDuration:(CGFloat)risingDuration {
    _risingDuration = MAX(MIN(risingDuration, 12), 1);
}

- (void)setMinminRisingVelocity:(CGFloat)minRisingVelocity {
    _minRisingVelocity = MAX(MIN(minRisingVelocity, 100), 20);
}

- (void)setRisingShiftDuration:(CGFloat)risingShiftDuration {
    _risingShiftDuration = MAX(MIN(risingShiftDuration, 4), 1);
}

- (void)setFadeOutDuration:(CGFloat)fadeOutDuration {
    _fadeOutDuration = MAX(MIN(fadeOutDuration, 10), 1);
}

- (void)setFadeOutShiftDuration:(CGFloat)fadeOutShiftDuration {
    _fadeOutShiftDuration = MAX(MIN(fadeOutShiftDuration, 3), 1);
}

@end
