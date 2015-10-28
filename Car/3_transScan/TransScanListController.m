//
//  TransScanListController.m
//  Car
//
//  Created by Leon on 10/18/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "TransScanListController.h"
#import "DriverModel.h"
#import "DriverCell.h"
#import "BzFollowViewController.h"
@interface TransScanListController (){
    UIBarButtonItem *mapBtn;
}

@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;

@end

@implementation TransScanListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initializatio
        mapBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bz-navi.png"] style:UIBarButtonItemStyleDone target:self action:@selector(toMap)];
        mapBtn.enabled = NO;
        self.navigationItem.rightBarButtonItem = mapBtn;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"扫描列表";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 80;
    [self startHeaderRefresh];

}

- (void)toMap{
    BzFollowViewController *bzFollow = [[BzFollowViewController alloc] init];
    bzFollow.driverArray = self.dataArray;
    bzFollow.showCompany = NO;
    bzFollow.longitude = _longitude;
    bzFollow.latitude = _latitude;
    [self.navigationController pushViewController:bzFollow animated:YES];
}


- (void)loadData{
    [_paramDic setObject:[NSNumber numberWithInt:self.pageNum] forKey:@"page"];
    [[HttpRequest shareRequst] driverScanWith:_paramDic success:^(id obj) {
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.intValue == 0){
            NSDictionary *record = [obj valueForKey:@"record"];
            _longitude = [[record valueForKey:@"longitude"] doubleValue];
            _latitude = [[record valueForKey:@"latitude"] doubleValue];
            NSArray *array = [[record objectForKey:@"grid"]objectForKey:@"rows"];
            if (array.count > 0){
                mapBtn.enabled = YES;
            }
            [self checkResponseArray:array];
            for(NSDictionary *dic in array){
                DriverModel *driver = [DriverModel driverWithDic:dic];
                [self.dataArray addObject:driver];
            }
            [self.tableView reloadData];
        }
        [self endRefresh];
    } fail:^(NSString *errorMsg) {
        [self endRefresh];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DriverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DriverCell"];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DriverCell" owner:nil options:nil]objectAtIndex:0];
    }
    DriverModel *driver = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.nameLbl.text = driver.name;
    cell.phoneLbl.text = driver.phone;
    cell.statusLbl.text = driver.statusName;
    
    return cell;
}


@end
