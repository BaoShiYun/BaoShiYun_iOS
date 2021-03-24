//
//  BSYLiveIMFaceCache.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//

#import "BSYLiveIMFaceCache.h"
#import "BSYLiveChatDefine.h"
#import "BSYLiveIMFaceCell.h"
#import "BSYLiveIMFaceView.h"


@interface BSYLiveIMFaceCache()
@property (nonatomic, strong) NSMutableDictionary *faceCache;
@property (nonatomic, strong) NSMutableArray<BSYLiveIMFaceGroup *> *defaultFaceGroups;
@property (nonatomic, assign) BOOL isFinishedLoadFaceGroup;
@end

@implementation BSYLiveIMFaceCache


+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static BSYLiveIMFaceCache *instance;
    dispatch_once(&onceToken, ^{
        instance = [[BSYLiveIMFaceCache alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       // [self loadDefaultFaceGroups];
    }
    return self;
}

- (void)loadDefaultFaceGroups
{
    NSMutableArray *faceGroups = [NSMutableArray<BSYLiveIMFaceGroup *> array];
        //emoji group
    NSMutableArray *emojiFaces = [NSMutableArray array];
    NSArray *emojis = [NSArray arrayWithContentsOfFile:BSYLiveIMMessageFace(@"emoji/emoji.plist")];
    for (NSDictionary *dic in emojis) {
        BSYLiveIMFaceCellData *data = [[BSYLiveIMFaceCellData alloc] init];
        NSString *name = [dic objectForKey:@"face_name"];
        NSString *path = [NSString stringWithFormat:@"emoji/%@", name];
        data.name = name;
        data.path = BSYLiveIMMessageFace(path);
        [[BSYLiveIMFaceCache sharedInstance] addFaceToCache:data.path];
        [emojiFaces addObject:data];
    }
    if(emojiFaces.count != 0){
        BSYLiveIMFaceGroup *emojiGroup = [[BSYLiveIMFaceGroup alloc] init];
        emojiGroup.groupIndex = 0;
        emojiGroup.groupPath = BSYLiveIMMessageFace(@"emoji/");
        emojiGroup.faces = emojiFaces;
        emojiGroup.rowCount = 3;
        emojiGroup.itemCountPerRow = 9;
        emojiGroup.needBackDelete = YES;
        emojiGroup.menuPath = BSYLiveIMMessageFace(@"emoji/menu");
        [[BSYLiveIMFaceCache sharedInstance] addFaceToCache:emojiGroup.menuPath];
        [faceGroups addObject:emojiGroup];
        [[BSYLiveIMFaceCache sharedInstance] addFaceToCache:BSYLiveIMMessageFace(@"del_normal")];
    }
    self.defaultFaceGroups = faceGroups;
    self.isFinishedLoadFaceGroup = YES;
}


- (NSMutableDictionary *)faceCache {
    if(!_faceCache) {
        _faceCache = [[NSMutableDictionary alloc] init];
    }
    return _faceCache;
}


- (void)addFaceToCache:(NSString *)path {
    @weakify(self);
    [BSYLiveIMFaceCache asyncDecodeImage:path complete:^(NSString *key, UIImage *image) {
        @strongify(self);
        [self.faceCache setValue:image forKey:key];
    }];
}

- (UIImage *)getFaceFromCache:(NSString *)path
{
    if(path.length == 0){
        return nil;
    }
    UIImage *image = [self.faceCache objectForKey:path];
    if(!image){
        image = [UIImage imageNamed:path];
    }
    return image;
}

-(NSMutableArray<BSYLiveIMFaceGroup *> *)getDefaultFaceGroups
{
   
    if(!self.isFinishedLoadFaceGroup)
    {
        [self loadDefaultFaceGroups];
    }
     return self.defaultFaceGroups;
}

- (void)clearCache
{
    [self.defaultFaceGroups removeAllObjects];
    self.defaultFaceGroups = nil;
    self.faceCache = nil;
    self.isFinishedLoadFaceGroup = NO;
}


+ (void)asyncDecodeImage:(NSString *)path complete:(BSYLiveAsyncImageComplete)complete
{
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.hkyunlive.asyncDecodeImage", DISPATCH_QUEUE_SERIAL);
    });

    dispatch_async(queue, ^{
        if(path == nil){
            return;
        }

        UIImage *image = nil;
        
        if ([path containsString:@".gif"]) { //支持动图
            image = [UIImage sd_imageWithGIFData:[NSData dataWithContentsOfFile:path]];
            if(complete){
                complete(path, image);
            }
            return;
        } else {
            image = [UIImage imageWithContentsOfFile:path];
        }
        
        if (image == nil) {
            return;
        }

        // 获取CGImage
        CGImageRef cgImage = image.CGImage;

        // alphaInfo
        CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(cgImage) & kCGBitmapAlphaInfoMask;
        BOOL hasAlpha = NO;
        if (alphaInfo == kCGImageAlphaPremultipliedLast ||
            alphaInfo == kCGImageAlphaPremultipliedFirst ||
            alphaInfo == kCGImageAlphaLast ||
            alphaInfo == kCGImageAlphaFirst) {
            hasAlpha = YES;
        }

        // bitmapInfo
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
        bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;

        // size
        size_t width = CGImageGetWidth(cgImage);
        size_t height = CGImageGetHeight(cgImage);

        // 解码：把位图提前画到图形上下文，生成 cgImage，就完成了解码。
        // context
        CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, CGColorSpaceCreateDeviceRGB(), bitmapInfo);

        // draw
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgImage);

        // get CGImage
        cgImage = CGBitmapContextCreateImage(context);

        // 解码后的图片，包装成 UIImage 。
        // into UIImage
        UIImage *newImage = [UIImage imageWithCGImage:cgImage scale:image.scale orientation:image.imageOrientation];

        // release
        if(context) CGContextRelease(context);
        if(cgImage) CGImageRelease(cgImage);

        //callback
        if(complete){
            complete(path, newImage);
        }
    });
}

@end
