//
//  TBOSSConfig.m
//  TBOSSManager
//
//  Created by changxuanren on 2021/3/11.
//

#import "TBOSSConfig.h"

@implementation TBOSSConfig


#pragma mark - Life Cycle / Get

+ (instancetype)sharedInstance {
    static TBOSSConfig *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[TBOSSConfig alloc] init];
    });
    return obj;
}


@end
