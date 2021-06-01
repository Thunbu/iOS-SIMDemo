//
//  GLCustomEmojiModel.m
//  Geely
//
//  on 2018/10/18.
//

#import "TBCustomEmojiModel.h"

@implementation TBCustomEmojiModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"emojiId" : @"id"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.emojiId forKey:@"emojiId"];
    [aCoder encodeObject:self.imgMd forKey:@"imgMd"];
    [aCoder encodeObject:self.imgUrl forKey:@"imgUrl"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.emojiId = [aDecoder decodeObjectForKey:@"emojiId"];
        self.imgMd = [aDecoder decodeObjectForKey:@"imgMd"];
        self.imgUrl = [aDecoder decodeObjectForKey:@"imgUrl"];
    }
    return self;
}

@end

@implementation GLCustomEmojiModelArray

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datasource" : [TBCustomEmojiModel class]};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.datasource forKey:@"datasource"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.datasource = [aDecoder decodeObjectForKey:@"datasource"];
    }
    return self;
}

@end
