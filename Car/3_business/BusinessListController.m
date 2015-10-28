//
//  BusinessListController.m
//  Car
//
//  Created by Leon on 14-9-28.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "BusinessListController.h"
#import "BusinessCell.h"
#import "OrderAbstract.h"
#import "BzDetailController.h"
#import "CustomTextField.h"

#define CAR_TYPE_CATEGORY       @[@"全部", @"驾运", @"平板车", @"轿运车"]

@interface BusinessListController ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSString *formName;
}
@property (nonatomic, strong) CustomTextField *categoryTxtField;
@property (nonatomic, strong) UIPickerView *dataPicker;

@end

@implementation BusinessListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"业务浏览";
    
    //初始化formName数据
    formName = @"全部";
    //添加选择框
    _categoryTxtField = [[CustomTextField alloc] initWithFrame:CGRectMake(3, 2, 314, 36)];
    _categoryTxtField.layer.borderColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1].CGColor;
    _categoryTxtField.layer.borderWidth = 1.0f;
    _categoryTxtField.text = CAR_TYPE_CATEGORY[0];
    
    ((UITableView *)self.view).tableHeaderView = _categoryTxtField;
//    [self.view addSubview:_categoryTxtField];
    

    _dataPicker = [[UIPickerView alloc] init];
    self.dataPicker.delegate = self;
    self.dataPicker.dataSource = self;
    
    self.categoryTxtField.inputView = self.dataPicker;
    
    CGRect frame = self.tableView.frame;
    frame.origin.y += 40;
    frame.size.height -= 40;
    self.tableView.frame = frame;
    
    self.tableView.rowHeight = 80;
    [self startHeaderRefresh];
    
    
}

- (void)loadData
{
    [[HttpRequest shareRequst] getBzListFtFByPage:[NSNumber numberWithInt:self.pageNum] formName:formName success:^(id obj) {
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
    } fail:
     ^(NSString *errorMsg) {
         [MBProgressHUD showError:errorMsg];
         [self endRefresh];
     }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BusinessCell" owner:nil options:nil]objectAtIndex:1];
    }
    OrderAbstract  *order = [self.dataArray objectAtIndex:indexPath.row];
    if (indexPath.row%2 == 0){
        cell.backgroundColor = RGBColor(234, 234, 234);
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.ori1Label.text = order.ori1;
    cell.ori2Label.text = order.ori2;
    cell.des1Label.text = order.des1;
    cell.des2Label.text = order.des2;
    cell.timeLabel.text = [order.stime substringToIndex:10];
    
    cell.carNumLabel.text = [NSString stringWithFormat:@"%d辆%@",order.carNum,order.carTypeName];
    cell.comNameLabel.text = order.comName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BzDetailController *detail = [[BzDetailController alloc]init];
    
    OrderAbstract *bz = [self.dataArray objectAtIndex:indexPath.row];
    
    detail.businessId = [NSString stringWithFormat:@"%d",bz.id];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [CAR_TYPE_CATEGORY count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [CAR_TYPE_CATEGORY objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.categoryTxtField.text = [CAR_TYPE_CATEGORY objectAtIndex:row];
    
    formName = [CAR_TYPE_CATEGORY objectAtIndex:row];

    //重新加载数据
    
    [self startHeaderRefresh];
}



@end
