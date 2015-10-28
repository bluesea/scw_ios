//
//  MyMsgListController.m
//  Car
//
//  Created by Leon on 14-9-27.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "MyMsgListController.h"
#import "MyMsgCell.h"
#import "MessageModel.h"
#import "MsgDetailController.h"

@interface MyMsgListController ()

@end

@implementation MyMsgListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息列表";
    self.tableView.rowHeight = 64;
    [self startHeaderRefresh];
}


- (void)loadData{
    [[HttpRequest shareRequst] getMessageListWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId" ] page:[NSNumber numberWithInt:self.pageNum ] success:^(id obj) {
        LSLog(@"----ok");
        NSNumber *code = [obj objectForKey:@"code"];
        if (code.intValue == 0){
            NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
            [self checkResponseArray:array];
            for(NSDictionary *dic in array){
                MessageModel *msg = [MessageModel msgWithDid:dic];
                [self.dataArray addObject:msg];
            }
            [self.tableView reloadData];
        }
        [self endRefresh];
    } fail:^(NSString *errorMsg) {
        [self endRefresh];
    }];
}

#pragma mark - table datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"MyMsgCell";
    MyMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil]objectAtIndex:0];
    }
    MessageModel *msg = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.titleLbl.text = msg.title;
    cell.fromNameLbl.text = msg.fromName;
    cell.ctimeLbl.text = msg.ctime;
    
    return cell;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
//}

#pragma  mark 查看消息详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MsgDetailController *detail = [[MsgDetailController alloc]init];
    detail.msg = [self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark 删除消息
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        MessageModel *msg = [self.dataArray objectAtIndex:indexPath.row];

        [MBProgressHUD showMessage:@"正在删除"];
        
        [[HttpRequest shareRequst] deleteMsgWithId:msg.id success:^(id obj) {
            NSNumber *code = [obj valueForKey:@"code"];
            if (code.intValue == 0){
                [self.dataArray removeObject:msg];
                // Delete the row from the data source.
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [MBProgressHUD hideHUD];
                
            } else {
                [MBProgressHUD showError:[obj valueForKey:@"msg"]];
            }
        } fail:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg];
        }];
    }
}

@end
