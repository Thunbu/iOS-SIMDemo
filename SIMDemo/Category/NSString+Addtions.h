//
//  NSString+Addtions.h
//  Geely
//
//  Created by yangfan on 2017/6/25.
//  Copyright © 2017年 Geely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Addtions)


- (CGFloat)getTextHeightWithFont:(UIFont *)font width:(CGFloat)width;
- (CGFloat)getTextWidthWithFont:(UIFont *)font height:(CGFloat)height;

@end
