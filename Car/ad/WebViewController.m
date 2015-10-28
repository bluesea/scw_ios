//
//  AdViewController.m
//  Car
//
//  Created by Leon on 14-9-20.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "WebViewController.h"


@interface WebViewController ()



@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)loadView{
    self.view = [[UIWebView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    CGRect frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height- 64);
    
    UIWebView *webView  = (UIWebView *) self.view;
//    [self.view addSubview:webView];
//    
//    _adWebView = webView;
    
    NSURL *url = [NSURL URLWithString:_link];
    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}


@end
