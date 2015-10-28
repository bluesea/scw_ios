//
//  OrderListController.m
//  Car
//
//  Created by Leon on 14-9-24.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "OrderListController.h"
#import "OrderAbstract.h"
#import "DriverOrderCell.h"
#import "DriverOrderDetailController.h"
#import "OrderAcceptController.h"
#import "SendReceiptController.h"

@interface OrderListController ()

@end

@implementation OrderListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //        self.title = @"list";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [self beginHeaderRefreshing];
    self.tableView.rowHeight = 80;
    [self startHeaderRefresh];
}

- (void)loadData{
    
    [[HttpRequest shareRequst] getMyBzListWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId" ] page:[NSString stringWithFormat:@"%d",self.pageNum] type:self.type success:^(id obj) {
        LSLog(@"----ok");
        NSNumber *code = [obj objectForKey:@"code"];
        if (code.intValue == 0){
            NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
            [self checkResponseArray:array];
            for(NSDictionary *dic in array){
                OrderAbstract *order = [OrderAbstract orderAbstractWithDic:dic];
                [self.dataArray addObject:order];
            }
            [self.tableView reloadData];
        }
        [self endRefresh];
    } fail:^(NSString *errorMsg) {
        LSLog(@"----fail");
        [self endRefresh];
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DriverOrderCell *cell = [DriverOrderCell cellWithTableView:tableView];
    
    if (indexPath.row%2 == 0){
        cell.backgroundColor = RGBColor(234, 234, 234);
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    OrderAbstract *order  = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.order = order;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderAbstract *order = [self.dataArray objectAtIndex:indexPath.row];
    
    
    if (order.status == kOrderStatusTransporting){
        OrderAcceptController  *next = [[OrderAcceptController alloc]init];
        next.orderId = order.id;
        [self.navigationController pushViewController:next animated:YES];

    } else if (order.status == kOrderStatusConfirm){
        SendReceiptController  *next = [[SendReceiptController alloc]init];
        next.orderId = order.id;
        [self.navigationController pushViewController:next animated:YES];

    }else {
        DriverOrderDetailController  *next = [[DriverOrderDetailController alloc]init];
        next.orderId = order.id;
        [self.navigationController pushViewController:next animated:YES];

    }
    
}


@end
