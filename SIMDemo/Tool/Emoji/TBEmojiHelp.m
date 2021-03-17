//
//  TBGLEmojiHelp.m
//  Geely
//
//  Created by yangfan on 2018/3/16.
//  Copyright © 2018年 Geely. All rights reserved.
//

#import "TBEmojiHelp.h"

static NSDictionary *yellowManEmojiDic;
static NSDictionary *geelyStaticEmojiDic;
static NSDictionary *geelyGifEmojiDic;

@implementation TBEmojiHelp

+ (UIImage *)pullImgWithName:(NSString *)name {
    __block UIImage *targetImg;
    
    NSArray *allEmojiArray = @[[TBEmojiHelp staticYellowManEmojiDic], [TBEmojiHelp staticGeelyStaticEmojiDic]];
    for (NSDictionary *emojiDic in allEmojiArray) {
        [emojiDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSArray *array = (NSArray *) obj;
            if ([[array firstObject] isEqualToString:name]) {
                targetImg = [UIImage imageNamed:[array firstObject]];
                *stop = YES;
            } else if ([[array objectAtIndex:1] isEqualToString:name]) {
                targetImg = [UIImage imageNamed:[array firstObject]];
                *stop = YES;
            }
        }];
        if (targetImg) {
            break;
        }
    }
    
    return targetImg;
}

+ (int16_t)pullEmojiCountWithType:(TBEmojiHelpType)type {
    switch (type) {
        case TBEmojiHelpTypeWithYelloMan:
            return [[TBEmojiHelp staticYellowManEmojiDic] count];
            break;
        case TBEmojiHelpTypeWithGeelyStatic:
            return [[TBEmojiHelp staticGeelyStaticEmojiDic] count];
            break;
        case TBEmojiHelpTypeWithGeelyGif:
            return [[TBEmojiHelp staticGeelyGifEmojiDic] count];
            break;
        default:
            return 0;
            break;
    }
}

+ (UIImage *)pullImgWithIndex:(int16_t)index type:(TBEmojiHelpType)type {
    switch (type) {
        case TBEmojiHelpTypeWithYelloMan:
            return [UIImage imageNamed:[[[TBEmojiHelp staticYellowManEmojiDic] objectForKey:@(index)] firstObject]];
            break;
        case TBEmojiHelpTypeWithGeelyStatic:
            return [UIImage imageNamed:[[[TBEmojiHelp staticGeelyStaticEmojiDic] objectForKey:@(index)] firstObject]];
            break;
        default:
            return nil;
            break;
    }
}

+ (NSString *)pullChineseNameWithIndex:(int16_t)index type:(TBEmojiHelpType)type {
    
    switch (type) {
        case TBEmojiHelpTypeWithYelloMan:
            return [[[TBEmojiHelp staticYellowManEmojiDic] objectForKey:@(index)] objectAtIndex:1];
            break;
        case TBEmojiHelpTypeWithGeelyStatic:
            return [[[TBEmojiHelp staticGeelyStaticEmojiDic] objectForKey:@(index)] objectAtIndex:1];
            break;
        case TBEmojiHelpTypeWithGeelyGif:
            return [[[TBEmojiHelp staticGeelyGifEmojiDic] objectForKey:@(index)] objectAtIndex:1];
            break;
        default:
            return nil;
            break;
    }
}



+ (NSString *)removeLastEmoji:(NSString *)text {
    
    NSString *result = [text copy];
    //最后一个字符不是]，说明肯定不是emoji表情，只删除最后一个字符
    if (![[result substringFromIndex:result.length-1] isEqualToString:@"]"]) {
        return [result substringToIndex:result.length-1];
    }
    //从最后一个字符开始删除，直到遇到符号[，再把最后中括号[]中的文本记录下拉
    NSMutableString *lastEmoji = [NSMutableString new];
    do {
        NSString *lastChar = [result substringFromIndex:result.length-1];
        if (![lastChar isEqualToString:@"]"]) {
            [lastEmoji insertString:lastChar atIndex:0];
        }
        result = [result substringToIndex:result.length-1];
    } while (![[result substringFromIndex:result.length-1] isEqualToString:@"["]);
    
    NSArray *chineseNames = [TBEmojiHelp chineseNames];
    if ([chineseNames containsObject:lastEmoji]) {
        //如果最后中括号[]中的文本属于emoji表情中文名，则删除最后一整个个表情文本，移除result最后的符号[即可
        return [result substringToIndex:result.length-1];
    }
    else {
        //只删除最后一个字符即可
        return [text substringToIndex:text.length-1];
    }
}

/// 获取所有的emoji表情中文名数组
+ (NSArray *)chineseNames {
    NSMutableArray *cNames = [NSMutableArray new];
    NSDictionary *staticYellowManEmojiDic = [TBEmojiHelp staticYellowManEmojiDic];
    NSArray *emojis = [staticYellowManEmojiDic allValues];
    [emojis enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *names = (NSArray *)obj;
        NSString *cName = (NSString *)(names[1]);
        [cNames addObject:cName];
    }];
    return [cNames copy];
}

#pragma mark - 静态资源
+ (NSDictionary *)staticYellowManEmojiDic {
    if (!yellowManEmojiDic) {
        yellowManEmojiDic = @{
            @0:@[@"grinning",@"咧嘴"],
            @1:@[@"smiling_eyes",@"笑"],
            @2:@[@"pleasure",@"愉快"],
            @3:@[@"grimace",@"撇嘴"],
            @4:@[@"shy",@"害羞"],
            @5:@[@"sunglasses",@"得意"],
            @6:@[@"tearing",@"流泪"],
            @7:@[@"applaud",@"鼓掌"],
            @8:@[@"laugh_and_cry",@"破涕为笑"],
            @9:@[@"face_palm",@"捂脸"],
            @10:@[@"embarrassed",@"尴尬"],
            @11:@[@"big_man",@"大佬"],
            @12:@[@"ok",@"ok"],
            @13:@[@"thumbs_up",@"点赞"],
            @14:@[@"floret",@"小花花"],
            @15:@[@"clapping",@"拍手"],
            @16:@[@"awesome",@"给力"],
            @17:@[@"shake_hands",@"握手"],
            @18:@[@"victory",@"胜利"],
            @19:@[@"flight",@"抱拳"],
            @20:@[@"seduce",@"勾引"],
            @21:@[@"prayer",@"合十"],
            @22:@[@"down",@"向下"],
            @23:@[@"up",@"向上"],
            @24:@[@"left",@"向左"],
            @25:@[@"right",@"向右"],
            @26:@[@"doge",@"柴犬"],
            @27:@[@"pig",@"猪头"],
            @28:@[@"determined",@"奋斗"],
            @29:@[@"melon",@"吃瓜"],
            @30:@[@"sweat",@"汗颜"],
            @31:@[@"hate",@"讨厌"],
            @32:@[@"wake_up",@"睡醒"],
            @33:@[@"drowsy",@"犯困"],
            @34:@[@"sleep",@"睡觉"],
            @35:@[@"snigger",@"偷笑"],
            @36:@[@"sinister",@"阴险"],
            @37:@[@"funny",@"怪笑"],
            @38:@[@"kawaii",@"可爱"],
            @39:@[@"ecstatic",@"大笑"],
            @40:@[@"hehe",@"呵呵笑"],
            @41:@[@"naughty",@"调皮"],
            @42:@[@"dizzy",@"晕"],
            @43:@[@"zipper_mouth",@"闭嘴"],
            @44:@[@"wronged",@"委屈"],
            @45:@[@"sneeze",@"打喷嚏"],
            @46:@[@"medical_mask",@"生病"],
            @47:@[@"astonished",@"惊讶"],
            @48:@[@"flushed",@"发呆"],
            @49:@[@"unamused",@"鄙视"],
            @50:@[@"rolling_eyes",@"白眼"],
            @51:@[@"arrogant",@"傲慢"],
            @52:@[@"shocked",@"疑问"],
            @53:@[@"hush",@"嘘"],
            @54:@[@"angry",@"生气"],
            @55:@[@"serious",@"骂人"],
            @56:@[@"toasted",@"衰"],
            @57:@[@"knock",@"敲打"],
            @58:@[@"byebye",@"再见"],
            @59:@[@"dig",@"抠鼻"],
            @60:@[@"throwing_kiss",@"飞吻"],
            @61:@[@"anthomaniac",@"花痴"],
            @62:@[@"no_look",@"不敢看"],
            @63:@[@"thinking",@"思考"],
            @64:@[@"cold_sweat",@"焦虑"],
            @65:@[@"trick",@"坏笑"],
            @66:@[@"muddle",@"懵逼"],
            @67:@[@"whimper",@"惊恐"],
            @68:@[@"money",@"爱钱"],
            @69:@[@"vomiting",@"呕吐"],
            @70:@[@"frowning",@"不高兴"],
            @71:@[@"crying",@"大哭"],
            @72:@[@"teary_eyed",@"想哭"],
            @73:@[@"pity",@"可怜"],
            @74:@[@"injured",@"受伤"],
            @75:@[@"ill",@"不舒服"],
            @76:@[@"scream",@"大闹"],
            @77:@[@"fake_smile",@"假笑"],
            @78:@[@"hot",@"炎热"],
            @79:@[@"cold",@"寒冷"],
            @80:@[@"thunbu",@"闪布"],
            @81:@[@"here",@"在"],
            @82:@[@"heart",@"爱心"],
            @83:@[@"broken_heart",@"心碎"],
            @84:@[@"cheer",@"庆祝"],
            @85:@[@"gift",@"礼物"],
            @86:@[@"cake",@"蛋糕"],
            @87:@[@"ghost",@"幽灵"],
            @88:@[@"skull",@"骷髅"],
            @89:@[@"bomb",@"炸弹"],
            
        };
    }
    return yellowManEmojiDic;
}



+ (NSDictionary *)staticGeelyStaticEmojiDic {
    if (!geelyStaticEmojiDic) {
        geelyStaticEmojiDic = @{
                                // 吉利 吉娃娃表情
                                @0 : @[ @"Cool", @"酷" ],
                                @1 : @[ @"Angry", @"怒" ],
                                @2 : @[ @"Trick", @"坏笑" ],
                                @3 : @[ @"Joyful", @"愉快" ],
                                @4 : @[ @"Smile", @"微笑" ],
                                @5 : @[ @"Laugh", @"憨笑" ],
                                @6 : @[ @"Happy", @"开心" ],
                                @7 : @[ @"Drool", @"色" ],
                                @8 : @[ @"Smug", @"傲慢" ],
                                @9 : @[ @"Shy", @"害羞" ],
                                @10 : @[ @"Frown", @"难过" ],
                                @11 : @[ @"Kiss", @"亲亲" ],
                                @12 : @[ @"Proud", @"得意" ],
                                @13 : @[ @"Pride", @"高傲" ],
                                @14 : @[ @"Wit", @"机智" ],
                                @15 : @[ @"Scare", @"惊吓" ],
                                @16 : @[ @"Lovely", @"可爱" ],
                                @17 : @[ @"Poor", @"可怜" ],
                                @18 : @[ @"Trapped", @"困" ],
                                @19 : @[ @"Sweat", @"冷汗" ],
                                @20 : @[ @"Meet", @"满意" ],
                                @21 : @[ @"Expect", @"期待" ],
                                @22 : @[ @"Insidious", @"阴险" ],
                                @23 : @[ @"Dizzy", @"晕" ]
                                };
    }
    return geelyStaticEmojiDic;
}

+ (NSDictionary *)staticGeelyGifEmojiDic {
    if (!geelyGifEmojiDic) {
        geelyGifEmojiDic = @{
                             // gif 动态图片的的显示
                             @0 : @[ @"image_gif_0000001.gif", @"NO.1",@"http://ctdfs.geely.com/C3ImageGif/image_gif_0000001.gif" ],
                             @1 : @[ @"image_gif_0000002.gif", @"NO", @"http://ctdfs.geely.com/C3ImageGif/image_gif_0000002.gif" ],
                             @2 : @[ @"image_gif_0000003.gif", @"OK",@"http://ctdfs.geely.com/C3ImageGif/image_gif_0000003.gif" ],
                             @3 : @[ @"image_gif_0000004.gif", @"拜拜" ,@"http://ctdfs.geely.com/C3ImageGif/image_gif_0000004.gif"],
                             @4 : @[ @"image_gif_0000005.gif", @"hello", @"http://ctdfs.geely.com/C3ImageGif/image_gif_0000005.gif" ],
                             @5 : @[ @"image_gif_0000006.gif", @"娇羞",@"http://ctdfs.geely.com/C3ImageGif/image_gif_0000006.gif" ],
                             @6 : @[ @"image_gif_0000007.gif", @"美好的一天" ,@"http://ctdfs.geely.com/C3ImageGif/image_gif_0000007.gif"],
                             @7 : @[ @"image_gif_0000008.gif", @"燃烧吧小宇宙",@"http://ctdfs.geely.com/C3ImageGif/image_gif_0000008.gif" ],
                             @8 : @[ @"image_gif_0000009.gif", @"赞赞赞",@"http://ctdfs.geely.com/C3ImageGif/image_gif_0000009.gif" ],
                             @9 : @[ @"image_gif_0000010.gif", @"我想静静",@"http://ctdfs.geely.com/C3ImageGif/image_gif_0000010.gif" ],
                             @10 : @[ @"image_gif_0000011.gif", @"小目标", @"http://ctdfs.geely.com/C3ImageGif/image_gif_0000011.gif" ],
                             @11 : @[ @"image_gif_0000012.gif", @"洪荒之力",@"http://ctdfs.geely.com/C3ImageGif/image_gif_0000012.gif" ],
                             @12 : @[ @"image_gif_0000013.gif", @"请叫我雷锋" , @"http://ctdfs.geely.com/C3ImageGif/image_gif_0000013.gif"],
                             @13 : @[ @"image_gif_0000014.gif", @"停不下来",@"http://ctdfs.geely.com/C3ImageGif/image_gif_0000014.gif"],
                             @14 : @[ @"image_gif_0000015.gif", @"为人民服务",@"http://ctdfs.geely.com/C3ImageGif/image_gif_0000015.gif" ],
                             @15 : @[ @"image_gif_0000016.gif", @"不开心",@"http://ctdfs.geely.com/C3ImageGif/image_gif_0000016.gif" ],
                             @16 : @[ @"image_gif_0000017.gif", @"圣诞节",@"http://ctdfs.geely.com/C3ImageGif/image_gif_0000017.gif" ]
                             };
    }
    return geelyGifEmojiDic;
}
@end
