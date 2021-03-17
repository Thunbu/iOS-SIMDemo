//
//  NSArray+SIMMessage.m
//  SIMDemo
//
//  Created by changxuanren on 2020/11/2.
//

#import "NSArray+SIMMessage.h"

@implementation NSArray (SIMMessage)

- (BOOL)TB_containsMessage:(SIMMessage *)anObject {
    __block BOOL contains = NO;
    [self enumerateObjectsUsingBlock:^(SIMMessage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.packetId isEqualToString:anObject.packetId]) {
            contains = YES;
            *stop = YES;
        }
    }];
    return contains;
}

@end
