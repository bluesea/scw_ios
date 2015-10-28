//
//  NewsDetailController.m
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "NewsDetailController.h"
#import "NewsView.h"
#import "ReplyModel.h"
#import "ReplyCell.h"
#import "ForumReply.h"
#import "LoginViewController.h"

@interface NewsDetailController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *relays;
@property (nonatomic, weak) NewsView *newsView;
@property (weak, nonatomic) IBOutlet UITextField *contentField;
- (IBAction)replyAction;

@end

@implementation NewsDetailController

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
    self.relays = [NSMutableArray array];
    [MBProgressHUD showMessage:@"正在加载"];
    self.view.hidden = YES;
    [self loadData];
    
    _newsView = [NewsView newsView];
    
    if (_detailType == 1){
        _newsView.newsModel = _model;
    } else if (_detailType == 2){
        _newsView.forumTopic = _forumTopic;
    }
    
    _newsView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, _newsView.height + 10);
    //    [self.tableView addSubview:_newsView];
    //    [self.tableView.h]
    self.tableView.tableHeaderView = _newsView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = 69;
    self.tableView.separatorInset  = UIEdgeInsetsZero;
}

- (void)loadData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (_detailType == 1){
        if ([AppDelegate shareAppdelegate].isLogin ){
            [param setValue:UserDefaults(@"userId") forKey:@"userId"];
        }
        [param setValue:[NSNumber numberWithInt:_model.id] forKey:@"newsId"];
        [[HttpRequest shareRequst] getNewsDetailWithParam:param success:^(id obj) {
            NSNumber *code = [obj valueForKey:@"code"];
            if (code.intValue == 0){
                NSArray *array = [[obj objectForKey:@"record"] objectForKey:@"replys"];
                
                for(NSDictionary *dic in array){
                    ReplyModel *reply = [ReplyModel replyWithDic:dic];
                    [self.relays addObject:reply];
                }
                [self.tableView reloadData];
                self.view.hidden = NO;
                [MBProgressHUD hideHUD];
            } else {
                [MBProgressHUD showError:[obj valueForKey:@"msg"]];
            }
            
        } fail:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg];
        }];
    } else if (_detailType == 2){
        if ([[AppDelegate shareAppdelegate] isbbsLogin] ){
            [param setValue:UserDefaults(@"userId") forKey:@"userId"];
        }
        [param setValue:[NSString stringWithFormat:@"%d",_forumTopic.id] forKey:@"bbspostId"];
        [[HttpRequest shareRequst] getBbsTopicDetailWithParam:param
                                                      success:^(id obj) {
                                                          NSNumber *code = [obj valueForKey:@"code"];
                                                          if (code.intValue == 0){
                                                              NSArray *array = [[obj objectForKey:@"record"] objectForKey:@"subs"];
                                                              
                                                              for(NSDictionary *dic in array){
                                                                  ForumReply *reply = [ForumReply replyWithDic:dic];
                                                                  [self.relays addObject:reply];
                                                              }
                                                              [self.tableView reloadData];
                                                              self.view.hidden = NO;
                                                              [MBProgressHUD hideHUD];
                                                          } else {
                                                            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
                                                          }
                                                          
                                                      } fail:^(NSString *errorMsg) {
                                                          [MBProgressHUD showError:errorMsg];
                                                      }];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.relays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReplyCell *cell = [ReplyCell cellWithTableView:tableView];
    if (_detailType == 1){
        cell.replay = [self.relays objectAtIndex:indexPath.row];
    } else if (_detailType == 2){
        cell.forumReply = [self.relays objectAtIndex:indexPath.row];
    }
    return cell;
}


- (IBAction)replyAction {
    [self.view endEditing:YES];
    NSString *content = self.contentField.text ;
    
    if (content.length <= 0){
        AlertTitle(@"请填写评论内容!");
        return;
    }
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    if (_detailType == 1){
        ReplyModel *reply = [[ReplyModel alloc] init];
        [MBProgressHUD showMessage:@"正在发表评论"];
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        if ([AppDelegate shareAppdelegate].isLogin ){
            [param setValue:UserDefaults(@"userId") forKey:@"userId"];
            reply.replyerName = [AppDelegate shareAppdelegate].user.nicknamme;
        } else {
            reply.replyerName = @"游客";
        }
        
        [param setValue:content forKey:@"content"];
        reply.content = content;
        
        [param setValue:[NSString stringWithFormat:@"%d",_model.id] forKey:@"newsId"];
        
        reply.ctime = currentDateStr;
        [[HttpRequest shareRequst]replyNewsWithParam:param success:^(id obj) {
            NSNumber *code = [obj valueForKey:@"code"];
            if (code.intValue == 0){
                [self.relays addObject:reply];
                [self.tableView reloadData];
                [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
                self.contentField.text = @"";
            } else {
                [MBProgressHUD showError:[obj valueForKey:@"msg"]];
            }
            
        } fail:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg];
        }];
    } else if (_detailType == 2){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *userId = [(NSNumber *)[defaults objectForKey:@"userId"] stringValue];
        
        if(userId == nil || [@"" isEqualToString:userId]) {
            //转向登录
            LoginViewController *login = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:nil];
        } else {
            
            ForumReply *reply = [[ForumReply alloc]init];
            [MBProgressHUD showMessage:@"正在发表回复"];
            
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            reply.pubName = UserDefaults(@"nickName");
            reply.ctime = currentDateStr;
            [param setValue:content forKey:@"content"];
            reply.content = content;
            [[HttpRequest shareRequst] replyBbsTopicWithPid:[NSString stringWithFormat:@"%d",_forumTopic.id]
                                                  bbsuserId:userId
                                                    content:content
                                                    success:^(id obj) {
                                                        NSNumber *code = [obj valueForKey:@"code"];
                                                        if (code.intValue == 0){
                                                            [self.relays addObject:reply];
                                                            [self.tableView reloadData];
                                                            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
                                                            self.contentField.text = @"";
                                                        } else {
                                                            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
                                                        }
                                                        
                                                    } fail:^(NSString *errorMsg) {
                                                        [MBProgressHUD showError:errorMsg];
                                                    }];
        }
        
    }
    
    
}
@end
