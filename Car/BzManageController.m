//
//  BzManageController.m
//  Car
//
//  Created by Leon on 10/27/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BzManageController.h"
#import "ReleaseBusinessController.h"
#import "ManageBzCell.h"
#import "WebViewController.h"
#import "BusinessAbstract.h"

@interface BzManageController ()

@end

@implementation BzManageController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"业务管理";
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(releaseBusiness)];
        
        self.navigationItem.rightBarButtonItem = rightBtn;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self startHeaderRefresh];
}


- (void)loadData{
    [[HttpRequest shareRequst]getBusinessForCompanyWithUserId:UserDefaults(@"userId") page:[NSString stringWithFormat:@"%d",self.pageNum] success:^(id obj)
    {
        NSNumber *code = [obj objectForKey:@"code"];
        if (code.intValue == 0){
            NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
            [self checkResponseArray:array];
            for(NSDictionary *dic in array){
                BusinessAbstract *order = [BusinessAbstract businessAbstractWithDic:dic ];
                [self.dataArray addObject:order];
            }
            
            [self.tableView reloadData];
        }
        [self endRefresh];
    } fail:^(NSString *errorMsg) {
        [self endRefresh];
    }];
}


#pragma mark - dataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ManageBzCell *cell = [ManageBzCell cellWithTableView:tableView];
    
    cell.business = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessAbstract *business = [self.dataArray objectAtIndex:indexPath.row];
    if (business.status == BusinessStatusUncheck ){
        ReleaseBusinessController *modify = [[ReleaseBusinessController alloc] init];
        modify.modifyBusiness = YES;
        modify.bzId = [NSString stringWithFormat:@"%d",business.id];
        [self.navigationController pushViewController:modify animated:YES];
    }
}

#pragma mark 发布业务
- (void)releaseBusiness{
    ReleaseBusinessController *releasBz= [[ReleaseBusinessController alloc] init];
    [self.navigationController pushViewController:releasBz animated:YES];
}


@end
