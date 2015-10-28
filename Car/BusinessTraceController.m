//
//  BzTraceController.m
//  Car
//
//  Created by Leon on 11/12/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BusinessTraceController.h"
#import "OrderAbstractCell.h"
#import "BusinessTrace.h"
#import "BzFollowViewController.h"

@interface BusinessTraceController ()

//@property(nonatomic, strong) NSMutableArray *driverArray;


@end

@implementation BusinessTraceController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.rowHeight = 80;
    UIBarButtonItem  *mapBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bz-navi.png"] style:UIBarButtonItemStyleDone target:self action:@selector(toMap)];
    
    self.navigationItem.rightBarButtonItem = mapBtn;
    [self startHeaderRefresh];

}

- (void)toMap{
    BzFollowViewController *bzFollow = [[BzFollowViewController alloc] init];
    bzFollow.driverArray = self.dataArray;
    bzFollow.showBusiness = YES;
    [self.navigationController pushViewController:bzFollow animated:YES];
}



- (void)loadData{
    [[HttpRequest shareRequst] orderBzTraceWithUserId:UserDefaults(@"userId") page:[NSString stringWithFormat:@"%d",self.pageNum] success:^(id obj) {
        NSNumber *code = [obj objectForKey:@"code"];
        if (code.intValue == 0){
            NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
            [self checkResponseArray:array];
            for(NSDictionary *dic in array){
                BusinessTrace *bz = [BusinessTrace businessTraceWithDic:dic];

                [self.dataArray addObject:bz];
            }
            
            [self.tableView reloadData];
        }
        [self endRefresh];
    } fail:^(NSString *errorMsg) {
        LSLog(@"---------->fail");
        [self endRefresh];
    }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderAbstractCell *cell = [OrderAbstractCell cellWithTableView:tableView];
    cell.order = (OrderAbstract *)[self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

@end
