//
//  BSYLiveIMTextMsgCellData.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMTextMsgCellData.h"
#import "BSYLiveIMFaceCache.h"
#import "BSYLiveIMFaceCell.h"
#import "BSYLiveIMFaceView.h"



static BSYLiveIMTextMsgCellLayout *sIMLiveTextMessageCellLayout;

@implementation BSYLiveIMTextMsgCellLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.messageInsets = (UIEdgeInsets){
            .top = 3,
            .bottom = 3,
            .left = 8,
            .right = 8,
        };
       
    }
    return self;
}


+ (BSYLiveIMTextMsgCellLayout *)liveTextMessageCellLayout
{
    if (!sIMLiveTextMessageCellLayout) {
        sIMLiveTextMessageCellLayout = [BSYLiveIMTextMsgCellLayout new];
    }
    return sIMLiveTextMessageCellLayout;
}

@end


#define BSYLiveIMTextMsg_TextFont  [UIFont fontWithName:@"PingFangSC-Regular" size:14]

@interface BSYLiveIMTextMsgCellData()
@property (nonatomic, assign)CGSize textSize;
@property (nonatomic, assign)CGPoint textOrigin;

@end



@implementation BSYLiveIMTextMsgCellData

- (instancetype)init
{
    self = [super init];
    if (self) {
         self.cellTextLayout = [BSYLiveIMTextMsgCellLayout liveTextMessageCellLayout];
         self.textFont = BSYLiveIMTextMsg_TextFont;
        self.textColor = HexAlphaColor(0xFFFFFF, 1.0);
        
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
    maxWidth -= self.cellTextLayout.messageInsets.left+self.cellTextLayout.messageInsets.right;
    if(maxWidth<0)
    {
        maxWidth=0;
    }
    CGRect textRect = [self.attributedString boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    CGSize textSz = CGSizeMake(ceil(textRect.size.width), ceil(textRect.size.height));
    
    if(textSz.height<15)
    {
        textSz.height = 15;
    }
    
    self.textOrigin = CGPointMake(self.cellTextLayout.messageInsets.left, self.cellTextLayout.messageInsets.top);
    self.textSize = CGSizeMake(textSz.width+10, textSz.height);
    
    cellWidth += self.cellTextLayout.messageInsets.left+textSz.width+self.cellTextLayout.messageInsets.right;
    cellHeight += self.cellTextLayout.messageInsets.top+textSz.height+self.cellTextLayout.messageInsets.bottom;
    return CGSizeMake(cellWidth, cellHeight);
}


- (NSAttributedString *)attributedString
{
    if (!_attributedString) {
        _attributedString = [self formatMessageString:self.content WithName:self.name WithRole:self.role];
    }
    return _attributedString;
}


- (NSAttributedString *)formatMessageString:(NSString *)msg WithName:(NSString *)name WithRole:(NSString *)role
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
        [attributeString appendAttributedString:blankAttributedString];//加入文字前面
        
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
    
    if(msg && msg.length>0)
    {
        NSMutableAttributedString *msgAttributeString = [[NSMutableAttributedString alloc] initWithString:msg];
        [msgAttributeString addAttribute:NSFontAttributeName value:self.textFont range:NSMakeRange(0, msg.length)];
        [msgAttributeString addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, msg.length)];
        //2、通过正则表达式来匹配字符串
        NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]"; //匹配表情
        NSError *error = nil;
        NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
          if (!re) {
              NSLog(@"%@", [error localizedDescription]);
              return msgAttributeString;
          }

        NSArray *resultArray = [re matchesInString:msg options:0 range:NSMakeRange(0, msg.length)];
          NSMutableArray<BSYLiveIMFaceGroup *> *faceGroups = [[BSYLiveIMFaceCache sharedInstance] getDefaultFaceGroups];
          BSYLiveIMFaceGroup *group = faceGroups[0];
          //3、获取所有的表情以及位置
          //用来存放字典，字典中存储的是图片和图片对应的位置
          NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
          //根据匹配范围来用图片进行相应的替换
          for(NSTextCheckingResult *match in resultArray) {
              //获取数组元素中得到range
              NSRange range = [match range];
              //获取原字符串中对应的值
              NSString *subStr = [msg substringWithRange:range];

              for (BSYLiveIMFaceCellData *face in group.faces) {
                  if ([face.name isEqualToString:subStr]) {
                      //face[i][@"png"]就是我们要加载的图片
                      //新建文字附件来存放我们的图片,iOS7才新加的对象
                      NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                      //给附件添加图片
                      textAttachment.image = [[BSYLiveIMFaceCache sharedInstance] getFaceFromCache:face.path];
                      //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
                      textAttachment.bounds = CGRectMake(-3, -(self.textFont.lineHeight-self.textFont.pointSize)/2-2, self.textFont.pointSize+6, self.textFont.pointSize+6);
                      //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
                      NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                      //把图片和图片对应的位置存入字典中
                      NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                      [imageDic setObject:imageStr forKey:@"image"];
                      [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                      //把字典存入数组中
                      [imageArray addObject:imageDic];
                      break;
                  }
              }
          }
          //4、从后往前替换，否则会引起位置问题
          for (int i = (int)imageArray.count -1; i >= 0; i--) {
              NSRange range;
              [imageArray[i][@"range"] getValue:&range];
              //进行替换
              [msgAttributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
          }
        
        [attributeString appendAttributedString:msgAttributeString];
        
    }

  
    //[attributeString addAttribute:NSFontAttributeName value:self.textFont range:NSMakeRange(0, attributeString.length)];

    return attributeString;
    
}


@end
