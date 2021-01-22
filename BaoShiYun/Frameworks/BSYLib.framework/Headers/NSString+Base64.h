//
//  NSString+KBase64.h
//  Gurpartap Singh
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64Additions)
- (NSString *)encodeBase64String;
- (NSString *)decodeBase64String;
- (NSData *)base64Data;

- (NSString *)webSafeEncodeBase64String;
- (NSString *)webSafeDecodeBase64String;
@end
