//
//  DriverConfirmListController.m
//  Car
//
//  Created by Leon on 9/11/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "DriverListController.h"
#import "DriverModel.h"
#import "DriverConfirmViewController.h"
#import "AlertSetController.h"
#import "BzFollowViewController.h"

@interface DriverListController ()

@end

@implementation DriverListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    [self initUI];
    [self startHeaderRefresh];
}

- (void)initUI{
    if (_scanType == DriverScanTypeConfirmDirver){
        self.title = @"身份验证";
    } else  if (_scanType == DriverScanTypeAlertSet){
        self.title = @"司机列表";
    } else if (_scanType == DriverScanTypeAppointHead){
        self.title = @"司机列表";
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(appointHead)];
        self.navigationItem.rightBarButtonItem = btn;
    } else if (_scanType == DrverScanTypeLocation){
        self.title = @"司机扫描";
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bz-navi.png"] style:UIBarButtonItemStyleDone target:self action:@selector(toMap)];
        self.navigationItem.rightBarButtonItem = btn;
    }
}

#pragma mark - 指派领队
/**
 *  指派领队
 */
- (void) appointHead {
    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    if (index){
        [MBProgressHUD showMessage:@"正在提交"];
        //        LSLog(@"-->%@", [self.dataArray objectAtIndex:index.row]);
        DriverModel *driver = [self.dataArray objectAtIndex:index.row];
        NSInteger pidanId = [[NSUserDefaults standardUserDefaults] integerForKey:TRA_PIDAN_ID];
        [[HttpRequest shareRequst] endorseAppointHeadWithDrirverId:[NSString stringWithFormat:@"%d",driver.driverId] endorseId:[NSString stringWithFormat:@"%d",pidanId] success:^(id obj) {
            NSNumber *code = [obj valueForKey:@"code"];
            if (code.intValue == 0){
                [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
            } else {
                [MBProgressHUD showError:[obj valueForKey:@"msg"]];
            }
        } fail:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg];
        }];
        
    } else {
        [MBProgressHUD showError:@"请指派一个领队"];
    }
}

- (void)toMap{
    BzFollowViewController *bzFollow = [[BzFollowViewController alloc] init];
    bzFollow.driverArray = self.dataArray;
    [self.navigationController pushViewController:bzFollow animated:YES];
}


- (void)loadData{
    
    if (_scanType == DriverScanTypeAppointHead){
        [[HttpRequest shareRequst] endorseSearchHeadWithName:self.name cardNo:self.cardNo userId:UserDefaults(@"userId") page:[NSNumber numberWithInt:self.pageNum] success:^(id obj) {
            NSNumber *code = [obj objectForKey:@"code"];
            if (code.intValue == 0){
                NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
                
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
        
    } else if (_scanType == DriverScanTypeConfirmDirver ){
        [[HttpRequest shareRequst] driverValidWithName:self.name cardNo:self.cardNo managerId:UserDefaults(@"userId") page:[NSNumber numberWithInt:self.pageNum] success:^(id obj) {
            NSNumber *code = [obj objectForKey:@"code"];
            if (code.intValue == 0){
                NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
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
    } else if (_scanType ==  DriverScanTypeAlertSet){
        [[HttpRequest shareRequst] getDriverForCompanyWithId:UserDefaults(@"userId") page:[NSString stringWithFormat:@"%d",self.pageNum] name:self.name cardNo:self.cardNo success:^(id obj) {
            NSNumber *code = [obj objectForKey:@"code"];
            if (code.intValue == 0){
                NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
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
    } else if (_scanType ==  DrverScanTypeLocation){
        [[HttpRequest shareRequst] scanDriverForCompanyWithId:UserDefaults(@"userId") page:[NSString stringWithFormat:@"%d",self.pageNum] name:self.name cardNo:self.cardNo success:^(id obj) {
            NSNumber *code = [obj objectForKey:@"code"];
            if (code.intValue == 0){
                NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
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

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"driverCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    DriverModel *driver = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"姓名:%@",driver.name];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"身份证号:%@",driver.cardNo];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_scanType  == DriverScanTypeAppointHead) {
        NSIndexPath *selection = [tableView indexPathForSelectedRow];
        
        if (selection && selection.row == indexPath.row){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DriverModel *driver = [self.dataArray objectAtIndex:indexPath.row];
    
    if (_scanType == DriverScanTypeConfirmDirver){
        DriverConfirmViewController *searchView = [[DriverConfirmViewController alloc]init];
        
        //    searchView.driver = driver;
        searchView.driverId = driver.driverId;
        [self.navigationController pushViewController:searchView animated:YES];
    } else  if (_scanType == DriverScanTypeAlertSet){
        AlertSetController *alert = [[AlertSetController alloc]init];
        
        //    searchView.driver = driver;
        alert.driverId = [NSString stringWithFormat:@"%d",driver.driverId];
        [self.navigationController pushViewController:alert animated:YES];
    } else if (_scanType == DriverScanTypeAppointHead){
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_scanType == DriverScanTypeAppointHead){
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }
}
@end
