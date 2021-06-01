//
//  MFToast.m
//  Geely
//
//  on 10/12/15.
//

#import "MFToast.h"

static UILabel *toastLable;
static NSTimer *toastTimer;

@implementation MFToast

+ (void)showToast:(NSString *)text position:(ToastPosition)position time:(NSTimeInterval)second {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];

    [self stopLastToast];

    if (toastLable == nil) {
        toastLable = [[UILabel alloc] initWithFrame:CGRectZero];
        toastLable.textColor = [UIColor TB_colorForHex:0xFFFFFF];
        toastLable.textAlignment = NSTextAlignmentCenter;
        toastLable.layer.backgroundColor = [[UIColor TB_colorForHex:0x000000] colorWithAlphaComponent:0.8].CGColor;
        toastLable.layer.cornerRadius = 5.0;
        toastLable.numberOfLines = 0;
    }

    toastLable.text = text;
    [toastLable sizeToFit];
    toastLable.alpha = 1.0;
    [window addSubview:toastLable];
    [toastLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(window);
        make.width.equalTo(@(toastLable.bounds.size.width+20));
        make.height.equalTo(@50);
    }];
    toastTimer = [NSTimer scheduledTimerWithTimeInterval:second target:self selector:@selector(hideToast:) userInfo:nil repeats:NO];
}

+ (void)showToast:(NSString *)text position:(ToastPosition)position {
    [self showToast:text position:position time:0.9];
}

+ (void)showToast:(NSString *)text {
    [self showToast:text position:ToastPositionCenter time:0.9];
}

+ (void)hideToast:(NSTimer *)timer {
    [toastTimer invalidate];
    toastTimer = nil;
    [UIView animateWithDuration:0.1
        animations:^{
          toastLable.alpha = 0.0f;
        }
        completion:^(BOOL finished) {
          [toastLable removeFromSuperview];
        }];
}

+ (void)stopLastToast {
    if (toastTimer) {
        [toastTimer invalidate];
        toastTimer = nil;
    }
    if (toastLable) {
        toastLable.alpha = 0.0f;
        [toastLable removeFromSuperview];
    }
}

@end
