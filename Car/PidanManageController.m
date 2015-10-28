//
//  PidanManageController.m
//  Car
//
//  Created by Leon on 10/27/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "PidanManageController.h"
#import "PidanCell.h"
#import "PidanDetailController.h"
#import "EndorseAbstract.h"

@interface PidanManageController ()

@end

@implementation PidanManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"批单管理";
    self.tableView.rowHeight = 80;
    [self startHeaderRefresh];
}


- (void)loadData{
    [[HttpRequest shareRequst]
     getEndorsePageForCheckWithPage:[NSString stringWithFormat:@"%d",self.pageNum]
     userId:UserDefaults(@"userId")
     success:^(id obj) {
         NSNumber *code = [obj objectForKey:@"code"];
         if (code.intValue == 0){
             NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
             [self checkResponseArray:array];
             for(NSDictionary *dic in array){
                 EndorseAbstract *pidan = [EndorseAbstract endorseAbstractWithDic:dic];
                 [self.dataArray addObject:pidan];
             }
             [self.tableView reloadData];
             
         }
         [self endRefresh];
     }
     
     fail:^(NSString *errorMsg) {
         LSLog(@"----请求不成功");
         [self endRefresh];
     }];
}


#pragma mark - TableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PidanCell *cell = [PidanCell cellWithTableView:tableView];
    
    EndorseAbstract *endorse = self.dataArray[indexPath.row];
    
    cell.endorse = endorse;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PidanDetailController *pidanDetail = [[PidanDetailController alloc] init];
    EndorseAbstract *endorse = self.dataArray[indexPath.row];
    pidanDetail.endorse  =endorse;
    [self.navigationController pushViewController:pidanDetail animated:YES];
}

@end
