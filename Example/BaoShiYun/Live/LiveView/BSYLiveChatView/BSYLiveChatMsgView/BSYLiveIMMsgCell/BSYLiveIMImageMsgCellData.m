//
//  BSYLiveIMImageMsgCellData.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMImageMsgCellData.h"

static BSYLiveIMImageMsgCellLayout *sIMLiveImageMessageCellLayout;

@implementation BSYLiveIMImageMsgCellLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
    
        self.contentInsets = (UIEdgeInsets){
            .top = 3,
            .bottom = 3,
            .left = 8,
            .right = 8,
        };
        self.imageInsets = (UIEdgeInsets){
            .top = 3,
            .bottom = 6,
            .left = 8,
            .right = 8,
        };
//        self.imageInsets = (UIEdgeInsets){
//               .top = 3,
//               .bottom = 0,
//               .left = 0,
//               .right = 0,
//           };
       
    }
    return self;
}


+ (BSYLiveIMImageMsgCellLayout *)liveImageMessageCellLayout
{
    if (!sIMLiveImageMessageCellLayout) {
        sIMLiveImageMessageCellLayout = [BSYLiveIMImageMsgCellLayout new];
    }
    return sIMLiveImageMessageCellLayout;
}

@end


@interface BSYLiveIMImageMsgCellData()

@property (nonatomic,assign,readwrite) CGSize textSize;
@property (nonatomic,assign,readwrite) CGPoint textOrigin;

@property (nonatomic,assign,readwrite) CGSize imageSize;
@property (nonatomic,assign,readwrite) CGPoint imageOrigin;

@end

@implementation BSYLiveIMImageMsgCellData

- (instancetype)init
{
    self = [super init];
    if (self) {
         self.cellImageLayout = [BSYLiveIMImageMsgCellLayout liveImageMessageCellLayout];
        
    }
    return self;
}


- (CGSize)contentSize
{
    CGSize sz = [super contentSize];
    
    CGFloat cellHeight = sz.height;
    CGFloat cellWidth = sz.width;
    
    CGFloat maxWidth = [BSYLiveIMMsgCellLayout getMaxCellWidth];
    maxWidth -= cellWidth;
    maxWidth -= self.cellImageLayout.contentInsets.left+self.cellImageLayout.contentInsets.right;
    if(maxWidth<0)
    {
        maxWidth=0;
    }
    CGRect textRect = [self.attributedString boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options: NSStringDrawingUsesFontLeading context:nil];
    CGSize textSz = CGSizeMake(ceil(textRect.size.width), ceil(textRect.size.height));
    
    if(textSz.height<15)
    {
        textSz.height = 15;
    }
    
    self.textOrigin = CGPointMake(self.cellImageLayout.contentInsets.left, self.cellImageLayout.contentInsets.top);
    self.textSize = CGSizeMake(textSz.width, textSz.height);
    
    cellHeight += textSz.height+self.cellImageLayout.contentInsets.bottom;
    
    CGFloat imageWidth = maxWidth;
    if(self.imageInfo && self.imageInfo.thumbWidth<=imageWidth)
    {
        imageWidth = self.imageInfo.thumbWidth;
    }
    if(imageWidth<textSz.width)
    {
        imageWidth = textSz.width;
    }
    CGFloat imageHeight = 1;
    if(self.imageInfo && self.imageInfo.thumbWidth>0) {
        imageHeight = 1.0*imageWidth*self.imageInfo.thumbHeight/self.imageInfo.thumbWidth;
    }
    cellWidth += self.cellImageLayout.contentInsets.left + imageWidth + self.cellImageLayout.contentInsets.right;
    cellHeight += self.cellImageLayout.imageInsets.top +imageHeight+self.cellImageLayout.imageInsets.bottom;
    self.imageOrigin = CGPointMake(self.cellImageLayout.contentInsets.left, self.cellImageLayout.contentInsets.top+self.textSize.height+self.cellImageLayout.imageInsets.top);
    self.imageSize = CGSizeMake(imageWidth+5, imageHeight);
    return CGSizeMake(cellWidth, cellHeight);
}


- (NSURL *)thumbImageUrl
{
    if(self.imageInfo)
    {
        NSURL *url = [NSURL URLWithString:self.imageInfo.thumbURL];
        return url;
    }
    return nil;
}

- (NSAttributedString *)attributedString
{
    if (!_attributedString) {
        _attributedString = [self formatName:self.name WithRole:self.role];
    }
    return _attributedString;
}


- (NSAttributedString *)formatName:(NSString *)name WithRole:(NSString *)role
{
    
    //1、创建一个可变的属性字符串
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] init];
    //设置role
    if(role && role.length>0)
    {
        UILabel *roleLabel = [UILabel new];
        roleLabel.frame = CGRectMake(0, 0, 32, 16);
        roleLabel.text = role;
        roleLabel.font = self.roleFont;
        roleLabel.textColor = self.roleColor;
        roleLabel.backgroundColor = self.roleBgColor;
        roleLabel.clipsToBounds = YES;
        roleLabel.layer.cornerRadius = 1;
        roleLabel.textAlignment = NSTextAlignmentCenter;
        //调用方法，转化成Image
        UIImage *image = [self imageWithUIView:roleLabel];
        //创建Image的富文本格式
        NSTextAttachment *roleAttach = [[NSTextAttachment alloc] init];
        roleAttach.bounds = CGRectMake(0, -3.0, 32, 16); //是为了调整下标签跟文字的位置
        roleAttach.image = image;
        //添加到富文本对象里
        NSAttributedString *roleAttributedString = [NSAttributedString attributedStringWithAttachment:roleAttach];
        [attributeString appendAttributedString:roleAttributedString];//加入文字前面
        
        NSTextAttachment *blankAttach = [[NSTextAttachment alloc] init];
        blankAttach.bounds = CGRectMake(0, -3.0, 5, 16); //是为了调整下标签跟文字的位置
        blankAttach.image = [UIImage new];
        
        NSAttributedString *blankAttributedString = [NSAttributedString attributedStringWithAttachment:blankAttach];
        [attributeString appendAttributedString:blankAttributedString];
        
    }
    
    //设置name
    if(name && name.length>0)
    {
        NSString *nameText = [NSString stringWithFormat:@"%@：",name];
        NSMutableAttributedString *nameAttributeString = [[NSMutableAttributedString alloc] initWithString:nameText];
        [nameAttributeString addAttribute:NSFontAttributeName value:self.nameFont range:NSMakeRange(0, nameText.length)];
        [nameAttributeString addAttribute:NSForegroundColorAttributeName value:self.nameColor range:NSMakeRange(0, nameText.length)];
        
        [attributeString appendAttributedString:nameAttributeString];
    }
    return attributeString;
}
    
    


- (NSURL *)orgImageUrl
{
    if(self.imageInfo)
    {
        NSURL *url = [NSURL URLWithString:self.imageInfo.orgURL];
        return url;
    }
    return nil;
}

@end
