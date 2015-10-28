//
//  ManageOrderListController.m
//  Car
//
//  Created by Leon on 10/29/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "OrderManageListController.h"
#import "OrderAbstractCell.h"
#import "OrderDetailController.h"
#import "OrderAbstract.h"

@interface OrderManageListController ()

@property (nonatomic, assign) BOOL fristShow;

@end

@implementation OrderManageListController

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
    self.tableView.rowHeight = 80;
    
}

//读取数据
- (void)loadData{
    
    [[HttpRequest shareRequst] getOrderForCompanyWithUserId:UserDefaults(@"userId") page:[NSString stringWithFormat:@"%d",self.pageNum] type:[NSString stringWithFormat:@"%d",_orderType] success:^(id obj) {
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
        LSLog(@"---------->fail");
        [self endRefresh];
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderAbstractCell *cell = [OrderAbstractCell cellWithTableView:tableView];
    cell.order = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LSLog(@"-->chick");
    if ([self.manageOrderListDelgate respondsToSelector:@selector(managerOrderListShowDetial:index:)]){
        [self.manageOrderListDelgate managerOrderListShowDetial:self index:indexPath.row];
    }
}


@end
