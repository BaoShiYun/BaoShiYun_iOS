//
//  BSYInteractiveLiveMediaView.h
//  BaoShiYun
//
//  Created by zddMac on 2021/3/2.
//


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BSYInteractiveLiveMediaType) {
    BSYInteractiveLiveMediaType_Mic, //麦克风
    BSYInteractiveLiveMediaType_Camera, //摄像头
};

typedef void(^BSYInteractiveLiveMediaStatusBlock)(BSYInteractiveLiveMediaType mediaType, BOOL isOpen);

@interface BSYInteractiveLiveMediaView : UIView

@property (nonatomic, copy)BSYInteractiveLiveMediaStatusBlock mediaBlock;

- (instancetype)initWithType:(BSYInteractiveLiveMediaType)type withEnable:(BOOL)isEnable withStatus:(BOOL)isOpen;

- (void)setStatus:(BOOL)isOpen;

@end

NS_ASSUME_NONNULL_END
