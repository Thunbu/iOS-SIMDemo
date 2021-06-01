//
//  UITextView+Rich.m
//  private
//
//  on 2018/3/9.
//

#import "RichTextAttachment.h"
#import "UITextView+Rich.h"
#define MaxNumber 2000
@implementation UITextView (Rich)

- (void)insertEmoji:(UIImage *)image tag:(NSString *)tag marge:(float)marge {
    RichTextAttachment *imgAttach = [RichTextAttachment new];
    imgAttach.image = image;
    imgAttach.tag = tag;

    float emojiWidth = (self.font.pointSize * 1.75) * image.size.width / image.size.height;
    float emojiHeight = self.font.pointSize * 1.75;
    
    imgAttach.bounds = CGRectMake(0, -self.font.pointSize / 2.0, emojiWidth, emojiHeight);

    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:imgAttach];

    NSMutableAttributedString *textAttStr = [self.attributedText mutableCopy];
    if (textAttStr.length >= MaxNumber) {
        return;
    }
    [textAttStr insertAttributedString:imgStr atIndex:self.selectedRange.location];
    [textAttStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, textAttStr.length)];
    self.attributedText = textAttStr;
    self.selectedRange = NSMakeRange(self.selectedRange.location + 1, 0);
    [self setFont:self.font];
}

- (void)TB_insertText:(NSString *)text {
    NSMutableAttributedString *textAttStr = [self.attributedText mutableCopy];
    if (textAttStr.length >= MaxNumber) {
        return;
    }
    NSAttributedString *attriText = [[NSAttributedString alloc] initWithString:text];
    [textAttStr insertAttributedString:attriText atIndex:self.selectedRange.location];
    [textAttStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, textAttStr.length)];
    self.attributedText = textAttStr;
    self.selectedRange = NSMakeRange(self.selectedRange.location + 1, 0);
    [self setFont:self.font];
}

- (NSString *)staticEmojiText {
    NSAttributedString *temp = self.attributedText;

    NSMutableString *targetStr = [NSMutableString stringWithString:[temp string]];
    [temp enumerateAttribute:NSAttachmentAttributeName
                     inRange:NSMakeRange(0, temp.length)
                     options:NSAttributedStringEnumerationReverse
                  usingBlock:^(id _Nullable value, NSRange range, BOOL *_Nonnull stop) {
                    if (value && [value isKindOfClass:[RichTextAttachment class]]) {
                        RichTextAttachment *attach = (RichTextAttachment *) value;
                        [targetStr replaceCharactersInRange:range withString:attach.tag];
                    }
                  }];
    return [targetStr copy];
}

@end
