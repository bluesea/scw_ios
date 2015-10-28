//
//  ForumController.m
//  Car
//
//  Created by Leon on 9/12/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ForumController.h"
#import "ForumCell.h"
#import "ForumTopic.h"
#import "PublishViewController.h"
#import "NewsDetailController.h"

@interface ForumController ()

@end

@implementation ForumController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ([[AppDelegate shareAppdelegate] isbbsLogin]){
            UIBarButtonItem *sendBtn = [[UIBarButtonItem alloc] initWithTitle:@"发帖" style:UIBarButtonItemStyleDone target:self action:@selector(sendTopic)];
            self.navigationItem.rightBarButtonItem = sendBtn;
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.rowHeight = 80;
    [self startHeaderRefresh];
}

- (void)sendTopic{
    PublishViewController *publish = [[PublishViewController alloc] init];
    publish.title = @"发帖";
    publish.forumType = _type;
    [self.navigationController pushViewController:publish animated:YES];
}

- (void)loadData{
    [[HttpRequest shareRequst] getBbsListWithType:[NSString stringWithFormat:@"%d",_type] page:[NSString stringWithFormat:@"%d",self.pageNum] success:^(id obj) {
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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ForumCell *cell = [ForumCell cellWithTableView:tableView];
    
    cell.forumTopic = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailController *detail = [[NewsDetailController alloc] init];
    ForumTopic *model = [self.dataArray objectAtIndex:indexPath.row];
    detail.forumTopic = model;
    detail.detailType = 2;
    [self.navigationController pushViewController:detail animated:YES];
}


@end
