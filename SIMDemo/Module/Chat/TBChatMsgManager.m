//
//  TBChatManager.m
//  SIMDemo
//
//  on 2020/11/2.
//

#import "TBChatMsgManager.h"

@implementation TBChatMsgManager

- (CGFloat)messageBodyHeight:(SIMMessage *)message{
    if (message.msgType == SIMMsgType_TXT){
        SIMTextElem *textElem = (SIMTextElem *)message.elem;
        CGFloat textHeight = [textElem.text getTextHeightWithFont:Regular(14) width:UIScreenWidth-64*2-64];
        if (textHeight < 35){
            textHeight = 35;
        }
        return textHeight;
    }
    if (message.msgType == SIMMsgType_IMAGE){
        SIMImageElem *imageElem = (SIMImageElem *)message.elem;
        SIMImage *image = imageElem.imageList.firstObject;
        double proportion = image.width/(0.5*UIScreenWidth);
        if (proportion < 1){
            proportion = 1;
        }
        if (proportion <= 0){
            return 0;
        }
        CGFloat imageHeight = image.height/proportion;
        return imageHeight;
    }
    if(message.msgType == SIMMsgType_VIDEO){
        SIMVideoElem *videoElem = (SIMVideoElem *)message.elem;
        double proportion = videoElem.coverWidth/(0.5*UIScreenWidth);
        if (proportion < 1){
            proportion = 1;
        }
        if (proportion <= 0){
            return 0;
        }
        CGFloat imageHeight = videoElem.coverHeight/proportion;
        return imageHeight;
    }
    if (message.msgType == SIMMsgType_FILE){
        return 60;
    }
    return 0.0;
}
- (CGFloat)messageBodyWidth:(SIMMessage *)message{
    if (message.msgType == SIMMsgType_TXT){
        SIMTextElem *textElem = (SIMTextElem *)message.elem;
        CGFloat textWidth = [textElem.text getTextWidthWithFont:Regular(14) height:20];
        return textWidth;
    }
    return 0.0;
}
@end
