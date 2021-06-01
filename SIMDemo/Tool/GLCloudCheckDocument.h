//
//  GLCloudCheckDocument.h
//  TestProject
//
//  Created by xiaobing on 2020/5/27.
//  Copyright © 2020 xiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CheckedDocuments)(NSString *);
@interface TBCheckDocument : NSObject

+ (instancetype)shareCheck;
- (void)showDocumentMenu:(UIViewController *)showVC checkBlock:(CheckedDocuments)checkDocument;
@end

NS_ASSUME_NONNULL_END
