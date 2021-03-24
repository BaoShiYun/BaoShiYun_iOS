//
//  BSYLiveIMMenuCell.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//

#import "BSYLiveIMMenuCell.h"
#import "BSYLiveChatViewTheme.h"
#import "BSYLiveIMFaceCache.h"
@implementation BSYLiveIMMenuCellData

@end

#define BSYLiveIMMenuCell_Margin 6

@implementation BSYLiveIMMenuCell

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
    self.backgroundColor = BSYLiveIMMenuCell_UnSelectedBgColor;
    _menu = [[UIImageView alloc] init];
    [self addSubview:_menu];
}

- (void)defaultLayout
{
}

- (void)setData:(BSYLiveIMMenuCellData *)data
{
    //set data
    _menu.image = [[BSYLiveIMFaceCache sharedInstance] getFaceFromCache:data.path];
    if(data.isSelected){
        self.backgroundColor = BSYLiveIMMenuCell_SelectedBgColor;
    }
    else{
        self.backgroundColor = BSYLiveIMMenuCell_UnSelectedBgColor;
    }
    //update layout
    CGSize size = self.frame.size;
    _menu.frame = CGRectMake(BSYLiveIMMenuCell_Margin, BSYLiveIMMenuCell_Margin, size.width - 2 * BSYLiveIMMenuCell_Margin, size.height - 2 * BSYLiveIMMenuCell_Margin);
    _menu.contentMode = UIViewContentModeScaleAspectFit;

}

@end
