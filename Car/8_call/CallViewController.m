//
//  CallViewController.m
//  Car
//
//  Created by Leon on 9/10/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "CallViewController.h"
#import "AdView.h"

@interface CallViewController ()

- (IBAction)call:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *centerView;

@end

@implementation CallViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"一键电话";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.adView.frame = self.centerView.frame;
    
}

- (IBAction)call:(UIButton *)sender {
#warning 发布时需要修改xib中的电话
    NSString *phone = sender.titleLabel.text;
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];// 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];

}
@end
