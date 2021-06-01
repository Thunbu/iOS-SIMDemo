//
//  MFToast.h
//  Geely
//
//  on 10/12/15.
// 提醒框

#import <Foundation/Foundation.h>

typedef enum { ToastPositionTop, ToastPositionCenter, ToastPositionBottom } ToastPosition;

@interface MFToast : NSObject

+ (void)showToast:(NSString *)text position:(ToastPosition)position time:(NSTimeInterval)second;

+ (void)showToast:(NSString *)text position:(ToastPosition)position;

+ (void)showToast:(NSString *)text;

@end
