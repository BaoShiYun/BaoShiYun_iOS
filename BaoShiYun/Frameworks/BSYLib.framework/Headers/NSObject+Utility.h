//
//  NSObject+Utility.h
//  EagleApp
//
//  Created by duane on 2017/9/16.
//  Copyright © 2017年 duane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Utility)

+ (NSString *)className;

@end

@interface NSObject (TableViewCellHeight)

@property (nonatomic, copy) NSString *tableViewCellName;
@property (nonatomic, assign) CGFloat tableViewCellHeight;
@property (nonatomic, assign) CGFloat tableViewCellWidth;

@end
