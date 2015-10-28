//
//  AccidentListController.m
//  Car
//
//  Created by Leon on 10/28/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "AccidentListController.h"
#import "OrderAbstractCell.h"
#import "AccidentDetailController.h"
#import "OrderAbstract.h"

@interface AccidentListController ()

@end

@implementation AccidentListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = 82;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self startHeaderRefresh];
}

- (void)loadData{
    [[HttpRequest shareRequst] getAccidentForCompang:UserDefaults(@"userId") page:[NSString stringWithFormat:@"%d",self.pageNum] success:^(id obj) {
        NSNumber *code = [obj objectForKey:@"code"];
        if (code.intValue == 0){
            NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
            [self checkResponseArray:array];
            for(NSDictionary *dic in array){
                OrderAbstract *accident = [OrderAbstract orderAbstractWithDic:dic];
                [self.dataArray addObject:accident];
            }
            [self.tableView reloadData];
            
        }
        [self endRefresh];
        
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
        [self endRefresh];
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderAbstractCell *cell = [OrderAbstractCell cellWithTableView:tableView];
    cell.order = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AccidentDetailController *accidentDetail = [[AccidentDetailController alloc] init];
    accidentDetail.order = [self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:accidentDetail animated:YES];
}


@end
