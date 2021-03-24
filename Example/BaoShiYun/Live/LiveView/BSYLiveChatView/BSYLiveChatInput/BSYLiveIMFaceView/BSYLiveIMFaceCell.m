//
//  BSYLiveIMFaceCell.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//

#import "BSYLiveIMFaceCell.h"
#import "BSYLiveIMFaceCache.h"


@implementation BSYLiveIMFaceCellData
@end

@implementation BSYLiveIMFaceCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self setupViews];
        [self defaultLayout];
    }
    return self;
}

- (void)setupViews
{
    self.face = [[UIImageView alloc] init];
    self.face.contentMode = UIViewContentModeScaleAspectFit;
    self.face.userInteractionEnabled = YES;
    [self addSubview:self.face];
}

- (void)defaultLayout
{
    CGSize size = self.frame.size;
    self.face.frame = CGRectMake(0, 0, size.width, size.height);
}

- (void)setData:(BSYLiveIMFaceCellData *)data
{
    self.face.image = [[BSYLiveIMFaceCache sharedInstance] getFaceFromCache:data.path];
    [self defaultLayout];
}

@end
