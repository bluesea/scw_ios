//
//  NearbyBusinessController.m
//  Car
//
//  Created by 高小羊 on 15/4/15.
//  Copyright (c) 2015年 com.cwvs. All rights reserved.
//

#import "NearbyBusinessController.h"
#import "BusinessCell.h"
#import "UIImageView+WebCache.h"
#import "SpeedLocation.h"
#import "BzDetailController.h"
#import "BusinessTrace.h"

@interface NearbyBusinessController ()

@end

@implementation NearbyBusinessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近业务";
    self.tableView.rowHeight = 80;
    [self startHeaderRefresh];
}

- (void)loadData
{
    //business/getMyBusis
    [[HttpRequest shareRequst] getNearbyBusinessById:UserDefaults(@"userId") longitude:[NSString stringWithFormat:@"%f",/*[SpeedLocation shareInstance].longitude*/0.f] latitude:[NSString stringWithFormat:@"%f",/*[SpeedLocation shareInstance].latitude*/0.f] page:[NSNumber numberWithInt:self.pageNum] success:^(id obj) {
        NSNumber *code = [obj objectForKey:@"code"];
        if (code.intValue == 0){
            NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
            [self checkResponseArray:array];
            for(NSDictionary *dic in array){
                BusinessTrace *bzModel = [BusinessTrace businessTraceWithDic:dic];
                
                [self.dataArray addObject:bzModel];
            }
            [self.tableView reloadData];
            
        }
        [self endRefresh];
    } fail:^(NSString *errorMsg) {
        [self endRefresh];;
    }];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    static NSString *identifier = @"BusinessCell";
    //    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BusinessCell" owner:nil options:nil]objectAtIndex:0];
    }
    
    BusinessTrace *business = [self.dataArray objectAtIndex:[indexPath row]];
    
    if (indexPath.row%2 == 0){
        cell.backgroundColor = RGBColor(234, 234, 234);
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.ori1Label.text = business.ori1;
    cell.ori2Label.text = business.ori2;
    cell.des1Label.text = business.des1;
    cell.des2Label.text = business.des2;
    cell.timeLabel.text = [business.stime substringToIndex:10];
    cell.distanceLabel.text = business.distance;
    cell.carNumLabel.text = [NSString stringWithFormat:@"%d辆%@",business.carNum,business.carTypeName];
    cell.comNameLabel.text = business.comName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.typeImage.image = [UIImage imageNamed:@"carType1.png"];
    [cell.typeImage sd_setImageWithURL:[NSURL URLWithString:business.carPic]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BzDetailController  *detail = [[BzDetailController  alloc]init];
    BusinessTrace *bm = [self.dataArray objectAtIndex:indexPath.row];
    detail.businessId = [NSString stringWithFormat:@"%d",bm.id];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
