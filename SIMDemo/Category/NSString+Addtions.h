//
//  NSString+Addtions.h
//  Geely
//
//  on 2017/6/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Addtions)


- (CGFloat)getTextHeightWithFont:(UIFont *)font width:(CGFloat)width;
- (CGFloat)getTextWidthWithFont:(UIFont *)font height:(CGFloat)height;
- (SIMFileFormat)fileFormat;
@end
