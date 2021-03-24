//
//  BSYLiveIMCommonCell.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveIMCommonCellData : NSObject
@property (nonatomic,strong) NSString *reuseId;
@property (nonatomic, assign) SEL cselector;


- (UIImage*)imageWithUIView:(UIView*)view;

- (CGSize)contentSize;
@end




@interface BSYLiveIMCommonCell : UITableViewCell

@property (readonly)BSYLiveIMCommonCellData *data;
@property (nonatomic, strong)UIColor *colorWhenTouched;
@property (nonatomic, assign)BOOL changeColorWhenTouched;

- (void)fillWithData:(BSYLiveIMCommonCellData *)data;


@end

NS_ASSUME_NONNULL_END
