//
//  GLCustomEmojiModel.m
//  Geely
//
//  Created by Yang Viggo on 2018/10/18.
//  Copyright © 2018 Geely. All rights reserved.
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
    if (self == [super init]) {
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
    if (self == [super init]) {
        self.datasource = [aDecoder decodeObjectForKey:@"datasource"];
    }
    return self;
}

@end
