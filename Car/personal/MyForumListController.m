//
//  MyForumListViewController.m
//  Car
//
//  Created by Leon on 9/12/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "MyForumListController.h"
#import "ForumCell.h"
#import "ForumTopic.h"
#import "NewsDetailController.h"

@interface MyForumListController ()

@property (nonatomic, assign) BOOL fristShow;

@end

@implementation MyForumListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidCurrentView
{
    LSLog(@"加载为当前视图 = %@",self.title);
    if(_fristShow ){
        [self startHeaderRefresh];
    }
    _fristShow = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _fristShow = YES;
    
}


//读取数据
- (void)loadData{
    [[HttpRequest shareRequst] getMyBbsListWithId:UserDefaults(@"userId") isMain:[NSString stringWithFormat:@"%d",_isMain] page:[NSString stringWithFormat:@"%d",self.pageNum] success:^(id obj) {
        NSNumber *code = [obj objectForKey:@"code"];
        if (code.intValue == 0){
            NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
            [self checkResponseArray:array];
            for(NSDictionary *dic in array){
                ForumTopic *newsModel = [ForumTopic forumTopicWithDic:dic];
                
                [self.dataArray addObject:newsModel];
            }
            [self.tableView reloadData];
        }
        [self endRefresh];
    } fail:^(NSString *errorMsg) {
        LSLog(@"---------->fail");
        [self endRefresh];
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ForumCell *cell = [ForumCell cellWithTableView:tableView];
    
    cell.forumTopic = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LSLog(@"-->chick");
    if ([self.myForumListDelegate respondsToSelector:@selector(showNewsDetail:index:)]){
        [self.myForumListDelegate showNewsDetail:self index:indexPath.row];
    }
}

@end
