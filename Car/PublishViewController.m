//
//  PublishViewController.m
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "PublishViewController.h"
#import "NSString+Extension.h"

@interface PublishViewController ()
@property (nonatomic, assign) int sendType;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *contentField;
- (IBAction)sendAction;

@end

@implementation PublishViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self.title isEqualToString:@"发布资讯"]){
        self.titleField.placeholder = @"请输入资讯标题";
        _sendType = 0;
        
    } else if ([self.title isEqualToString:@"发布通知"]){
        self.titleField.placeholder = @"请输入通知标题";
        _sendType = 1;
    } else  if([self.title isEqualToString:@"发帖"]){
        self.titleField.placeholder = @"请输入帖子标题";
        _sendType = 2;
    }
}

- (IBAction)sendAction {
    NSString *tilte = [self.titleField.text trimBlank];
    if (tilte.length == 0){
        AlertTitle(@"请填写标题");
        return;
    }
    NSString *content = [self.contentField.text trimBlank];
    if (content.length == 0){
        AlertTitle(@"请填写正文内容!");
        return;
    }
    [MBProgressHUD showMessage:@"正在提交"];
    
    if (_sendType == 0) {
        
        [[HttpRequest shareRequst] publishNewsWithTitle:tilte content:content userId:UserDefaults(@"userId") success:^(id obj) {
            NSNumber *code = [obj valueForKey:@"code"];
            if (code.intValue == 0){
                [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
            } else {
               [MBProgressHUD showError:[obj valueForKey:@"msg"]];
            }
        } fail:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg];
        }];
    } else if (_sendType == 1){
        
        [[HttpRequest shareRequst] publishNoticeWithTitle:tilte content:content userId:UserDefaults(@"userId") success:^(id obj) {
            NSNumber *code = [obj valueForKey:@"code"];
            if (code.intValue == 0){
                [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
            } else {
               [MBProgressHUD showError:[obj valueForKey:@"msg"]];
            }
        } fail:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg];
        }];
    } else  if( _sendType == 2){
        NSString *bbsUserId = UserDefaults(@"bbsUserId");
        [[HttpRequest shareRequst] pulishNewBbsTopicWithTitle:tilte type:[NSString stringWithFormat:@"%d",_forumType] content:content bbsuserId:bbsUserId success:^(id obj) {
            NSNumber *code = [obj valueForKey:@"code"];
            if (code.intValue == 0){
                [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
            } else {
                [MBProgressHUD showError:[obj valueForKey:@"msg"]];
            }
        } fail:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg];
        }];
    }
    
}

@end
