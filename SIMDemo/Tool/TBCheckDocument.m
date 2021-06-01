//
//  GLCloudCheckDocument.m
//  TestProject
//
//  on 2020/5/27.
//

#import "TBCheckDocument.h"
#import "TBFileManager.h"

@interface TBCheckDocument()<UIDocumentPickerDelegate>

@property(nonatomic, copy)CheckedDocuments checkedDocument;
@end

@implementation TBCheckDocument

+ (instancetype)shareCheck{
    static TBCheckDocument *check = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        check = [[TBCheckDocument alloc] init];
    });
    return check;
}
- (void)showDocumentMenu:(UIViewController *)showVC checkBlock:(CheckedDocuments)checkDocument{
    UIDocumentPickerViewController *pickerController = [[UIDocumentPickerViewController alloc]initWithDocumentTypes:@[@"public.item"] inMode:UIDocumentPickerModeOpen];
    pickerController.modalPresentationStyle = UIModalPresentationFormSheet;
    pickerController.delegate = self;
    [showVC presentViewController:pickerController animated:YES completion:^{
        
    }];
    self.checkedDocument = checkDocument;
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url{
    BOOL canAccessingResource = [url startAccessingSecurityScopedResource];
    if(canAccessingResource) {
        [NSFileCoordinator.new coordinateReadingItemAtURL:url options:0 error:nil byAccessor:^(NSURL *newURL) {
            NSData *copyData = [NSData dataWithContentsOfURL:newURL];
            if (copyData.length > 30*1024*1024){
                [MFToast showToast:@"附件不得超过30M"];
                return;
            }
            if (!copyData){
                [MFToast showToast:@"暂不支持此文件格式"];
                return;
            }
            // 将文件存储本地 并将要上传的model 传递到 GLCloudUploadManager
            NSString *fileName = [url lastPathComponent];
            NSString *copiedFile = [[TBFileManager sharedInstance] getCopyFilePath:fileName];
            [[TBFileManager sharedInstance] copyToLocalWithData:copyData toPath:copiedFile];
            if (self.checkedDocument){
                self.checkedDocument(copiedFile);
            }
        }];
    }
    [url stopAccessingSecurityScopedResource];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls{
    NSURL *url = urls.firstObject;
    BOOL canAccessingResource = [url startAccessingSecurityScopedResource];
    if(canAccessingResource) {
        [NSFileCoordinator.new coordinateReadingItemAtURL:url options:0 error:nil byAccessor:^(NSURL *newURL) {
            NSData *copyData = [NSData dataWithContentsOfURL:newURL];
            if (copyData.length > 30*1024*1024){
                [MFToast showToast:@"附件不得超过30M"];
                return;
            }
            if (!copyData){
                [MFToast showToast:@"暂不支持此文件格式"];
                return;
            }
            // 将文件存储本地 并将要上传的model 传递到 GLCloudUploadManager
            NSString *fileName = [url lastPathComponent];
            NSString *copiedFile = [[TBFileManager sharedInstance] getCopyFilePath:fileName];
            [[TBFileManager sharedInstance] copyToLocalWithData:copyData toPath:copiedFile];
            if (self.checkedDocument){
                self.checkedDocument(copiedFile);
            }
        }];
    }
    [url stopAccessingSecurityScopedResource];
}
@end
