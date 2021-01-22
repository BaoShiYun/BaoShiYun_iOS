//
//  UIImage+util.h
//  BSYLib
//
//  Created by Duane on 2020/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (util)

+ (CGSize) fitSize: (CGSize)thisSize inSize: (CGSize) aSize;

+ (UIImage *)imageFromView:(UIView *)theView withSize:(CGSize)size;

- (UIImage *)scaleToSize:(CGSize)newSize;
- (UIImage *)imageFitInSize:(CGSize)viewsize;
- (UIImage *)roundedRectImage:(CGSize)size;
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)blackWhite;
- (UIImage *)cartoon;
- (UIImage *)memory;
- (UIImage *)bopo;
- (UIImage *)scanLine;
- (UIImage *)reflectedImageWithHeight:(NSUInteger)height;
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;
- (UIImage *)blurryImageWithAccelerate:(CGFloat)blur;
- (UIImage *)blurryImageWithCoreImage:(CGFloat)radius;
- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;


+ (UIImage *)colorImage:(CGSize )size startColor:(UIColor *)sColor endColor:(UIColor *)eColor;
//纯色图片
+ (UIImage *)imageFromColor:(UIColor*)color;
+ (UIImage *)imageFromColor:(UIColor *)color imageSize:(CGSize)size;
//生成圆形图片
- (UIImage *)cutCircleImage;

//压缩图片到指定尺寸
-(UIImage *) compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

- (UIImage *)fixOrientation;
- (UIImage *)rotateWithOrientation:(UIImageOrientation)orientation;

@end

NS_ASSUME_NONNULL_END
