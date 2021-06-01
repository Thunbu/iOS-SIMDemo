//
//  GLCustomEmojiModel.h
//  Geely
//
//  on 2018/10/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBCustomEmojiModel : NSObject

@property (nonatomic, copy) NSString *emojiId; // Emoji ID
@property (nonatomic, copy) NSString *imgMd; // Emoji MD5
@property (nonatomic, copy) NSString *imgUrl; // Emoji URL

@end

@interface GLCustomEmojiModelArray : NSObject

@property(nonatomic, copy) NSArray<TBCustomEmojiModel *> *datasource;

@end

NS_ASSUME_NONNULL_END
