//
//  FinanceManagerController.m
//  Car
//
//  Created by 高小羊 on 15/4/15.
//  Copyright (c) 2015年 com.cwvs. All rights reserved.
//

#import "FinanceManagerController.h"
#import "FinanceManagerTableViewCell.h"
#import "NSString+Extension.h"

@interface FinanceManagerController ()
{
    NSString *shouldIn;     //应收帐款
    NSString *shouldPay;    //应付帐款
    NSString *serviceFee;   //应付服务费

    
    NSArray *accList;       //银行卡数据
}

@property (weak, nonatomic) IBOutlet UILabel *shouldInLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouldPayLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceFeeLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FinanceManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FinanceManagerTableViewCell" bundle:nil] forCellReuseIdentifier:@"FinanceManagerTableViewCell"];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    [MBProgressHUD showMessage:@"正在加载"];
    [[HttpRequest shareRequst] getFinanceManagerDataWithUserId:UserDefaults(@"userId") success:^(id obj) {
        NSNumber *code = [obj objectForKey:@"code"];
        if (code.intValue == 0){
            NSDictionary *accDict = [[obj objectForKey:@"record"] objectForKey:@"accCenter"];

            
            self.shouldInLabel.text = [NSString stringWithFormat:@"￥%@", [NSString parserNumber:[accDict objectForKey:@"shouldIn"]]];
            self.shouldPayLabel.text = [NSString stringWithFormat:@"￥%@", [NSString parserNumber:[accDict objectForKey:@"shouldPay"]]];
            self.serviceFeeLabel.text = [NSString stringWithFormat:@"￥%@", [NSString parserNumber:[accDict objectForKey:@"serviceFee"]]];
            
            accList = [accDict objectForKey:@"accList"];
            
            [self.tableView reloadData];
            
        }
        [MBProgressHUD hideHUD];
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [accList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 102;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FinanceManagerTableViewCell *financeCell = [tableView dequeueReusableCellWithIdentifier:@"FinanceManagerTableViewCell"];
    
    NSDictionary *accountDict = [accList objectAtIndex:indexPath.row];
    financeCell.bankNameLabel.text = [accountDict objectForKey:@"bankName"];
    financeCell.accountNameLabel.text = [accountDict objectForKey:@"accName"];
    financeCell.accountNoLabel.text = [accountDict objectForKey:@"accNo"];
    
    return financeCell;
}

@end
