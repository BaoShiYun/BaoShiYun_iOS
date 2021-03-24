//
//  BSYLiveIMImageMsgCell.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMImageMsgCell.h"
#import "BSYLiveIMImageMsgCellData.h"

@interface BSYLiveIMImageMsgCell()

@property (nonatomic, strong, readwrite)BSYLiveIMImageMsgCellData *imageData;

@end



@implementation BSYLiveIMImageMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.bubbleView addSubview:self.textContent];
        [self.bubbleView addSubview:self.thumbImageView];
    }
    return self;
}


- (UIImageView *)thumbImageView
{
    if(!_thumbImageView)
    {
        _thumbImageView = [[UIImageView alloc] init];
        _thumbImageView.userInteractionEnabled = YES;
        _thumbImageView.layer.cornerRadius = 1.0;
        _thumbImageView.layer.masksToBounds = YES;
    }
    return _thumbImageView;
}

- (UILabel *)textContent
{
    if(!_textContent)
    {
        _textContent = [[UILabel alloc] init];
        _textContent.numberOfLines = 0;
    }
    return _textContent;
}





- (void)fillWithData:(BSYLiveIMImageMsgCellData *)data;
{
    //set data
    [super fillWithData:data];
    [self.thumbImageView sd_setImageWithURL:[data  thumbImageUrl] placeholderImage:nil];
    self.textContent.attributedText = data.attributedString;
    self.imageData = data;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textContent.frame = CGRectMake(self.imageData.textOrigin.x, self.imageData.textOrigin.y, self.imageData.textSize.width, self.imageData.textSize.height);
    self.thumbImageView.frame = CGRectMake(self.imageData.imageOrigin.x, self.imageData.imageOrigin.y, self.imageData.imageSize.width, self.imageData.imageSize.height);
}
@end
