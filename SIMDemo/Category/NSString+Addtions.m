//
//  NSString+Addtions.m
//  Geely
//
//  on 2017/6/25.
//

#import "NSString+Addtions.h"

@implementation NSString (Addtions)


- (CGFloat)getTextHeightWithFont:(UIFont *)font width:(CGFloat)width {
    CGFloat textHeight = 0;

    if (self.length) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        [dic setObject:font forKey:NSFontAttributeName];

        CGSize size =
            [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil]
                .size;
        textHeight = size.height;
    }

    return textHeight;
}

- (CGFloat)getTextWidthWithFont:(UIFont *)font height:(CGFloat)height {
    CGFloat textWidth = 0;

    if (self.length) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        [dic setObject:font forKey:NSFontAttributeName];

        CGSize size =
            [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil]
                .size;
        textWidth = size.width;
    }

    return textWidth;
}
- (SIMFileFormat)fileFormat {
    if ([self.lowercaseString hasSuffix:@".txt"] ||
        [self.lowercaseString hasSuffix:@".rtf"]) {
        return SIMFileFormat_TXT;
    } else if ([self.lowercaseString hasSuffix:@".doc"] ||
               [self.lowercaseString hasSuffix:@".docx"] ||
               [self.lowercaseString hasSuffix:@".docm"] ||
               [self.lowercaseString hasSuffix:@".dot"] ||
               [self.lowercaseString hasSuffix:@".dotx"] ||
               [self.lowercaseString hasSuffix:@".wps"]) {
        return SIMFileFormat_WORD;
    } else if ([self.lowercaseString hasSuffix:@".xlsx"] ||
               [self.lowercaseString hasSuffix:@".xlsm"] ||
               [self.lowercaseString hasSuffix:@".xls"] ||
               [self.lowercaseString hasSuffix:@".xlt"] ||
               [self.lowercaseString hasSuffix:@".csv"]) {
        return SIMFileFormat_EXCEL;
    } else if ([self.lowercaseString hasSuffix:@".jpg"] ||
               [self.lowercaseString hasSuffix:@".jpeg"] ||
               [self.lowercaseString hasSuffix:@".jp2"] ||
               [self.lowercaseString hasSuffix:@".png"] ||
               [self.lowercaseString hasSuffix:@".svg"] ||
               [self.lowercaseString hasSuffix:@".bmp"] ||
               [self.lowercaseString hasSuffix:@".gif"] ||
               [self.lowercaseString hasSuffix:@".iff"] ||
               [self.lowercaseString hasSuffix:@".pcx"] ||
               [self.lowercaseString hasSuffix:@".pixar"] ||
               [self.lowercaseString hasSuffix:@".pxr"] ||
               [self.lowercaseString hasSuffix:@".tiff"] ||
               [self.lowercaseString hasSuffix:@".cal"]) {
        return SIMFileFormat_JPEG;
    } else if ([self.lowercaseString hasSuffix:@".pdf"]) {
        return SIMFileFormat_PDF;
    } else if ([self.lowercaseString hasSuffix:@".ppt"] ||
               [self.lowercaseString hasSuffix:@".pptx"] ||
               [self.lowercaseString hasSuffix:@".pps"] ||
               [self.lowercaseString hasSuffix:@".ppsm"]) {
        return SIMFileFormat_PPT;
    } else if ([self.lowercaseString hasSuffix:@".7z"] ||
               [self.lowercaseString hasSuffix:@".ace"] ||
               [self.lowercaseString hasSuffix:@".ari"] ||
               [self.lowercaseString hasSuffix:@".arc"] ||
               [self.lowercaseString hasSuffix:@".ar"] ||
               [self.lowercaseString hasSuffix:@".arj"] ||
               [self.lowercaseString hasSuffix:@".bz"] ||
               [self.lowercaseString hasSuffix:@".bza"] ||
               [self.lowercaseString hasSuffix:@".bz2"] ||
               [self.lowercaseString hasSuffix:@".car"] ||
               [self.lowercaseString hasSuffix:@".dar"] ||
               [self.lowercaseString hasSuffix:@".gca"] ||
               [self.lowercaseString hasSuffix:@".gz"] ||
               [self.lowercaseString hasSuffix:@".jar"] ||
               [self.lowercaseString hasSuffix:@".rar"] ||
               [self.lowercaseString hasSuffix:@".taz"] ||
               [self.lowercaseString hasSuffix:@".tar"] ||
               [self.lowercaseString hasSuffix:@".zip"] ||
               [self.lowercaseString hasSuffix:@".exe"] ||
               [self.lowercaseString hasSuffix:@".zz"]) {
        return SIMFileFormat_RAR;
    } else if ([self.lowercaseString hasSuffix:@".html"] ||
             [self.lowercaseString hasSuffix:@".htm"]) {
        return SIMFileFormat_HTML;
    } else if ([self.lowercaseString hasSuffix:@".mp4"]||
               [self.lowercaseString hasSuffix:@".flv"]||
               [self.lowercaseString hasSuffix:@".avi"]||
               [self.lowercaseString hasSuffix:@".wmv"]||
               [self.lowercaseString hasSuffix:@".rmvb"]) {
        return SIMFileFormat_MP4;
    } else if ([self.lowercaseString hasSuffix:@".mp3"]) {
        return SIMFileFormat_MP3;
    } else if ([self.lowercaseString hasSuffix:@".mmap"] ||
               [self.lowercaseString hasSuffix:@".xmind"] ||
               [self.lowercaseString hasSuffix:@".mm"]) {
        return SIMFileFormat_MIND;
    } else if ([self.lowercaseString hasSuffix:@".ai"] ||
               [self.lowercaseString hasSuffix:@".eps"]) {
        return SIMFileFormat_AI;
    } else if ([self.lowercaseString hasSuffix:@".psd"]) {
        return SIMFileFormat_PSD;
    } else {
        return SIMFileFormat_UNKNOWN;
    }
}
@end
