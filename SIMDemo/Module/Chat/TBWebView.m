//
//  TBWebView.m
//  SIMDemo
//
//  on 2021/1/27.
//

#import "TBWebView.h"
#import <WebKit/WebKit.h>

@interface TBWebView ()

@property(nonatomic, copy)NSString *urlStr;
@end

@implementation TBWebView

- (id)initWithTitle:(NSString *)title showUrl:(NSString *)url{
    self = [super init];
    if (self){
        self.title = title;
        self.urlStr = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *wkWebView = [[WKWebView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:wkWebView];
    [wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    NSMutableURLRequest *mutReq = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlStr]];
    [wkWebView loadRequest:mutReq];
}


@end
