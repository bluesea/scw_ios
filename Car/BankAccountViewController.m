//
//  BankAccountViewController.m
//  Car
//
//  Created by Leon on 10/20/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BankAccountViewController.h"
#import "BankAccount.h"
#import "AddAccountController.h"

@interface BankAccountViewController (){
    NSMutableArray *accountArray;
}

@end

@implementation BankAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"账号管理";
        UIBarButtonItem *addBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAccount)];
        self.navigationItem.rightBarButtonItem = addBtn;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height- 64);
    
    self.accountTable = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    
    self.accountTable.delegate = self;
    self.accountTable.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [MBProgressHUD showMessage:@"正在加载"];
    
    accountArray =[NSMutableArray array];
    
    [[HttpRequest shareRequst]getAccountListById:UserDefaults(@"userId") success:^(id obj) {
        
        LSLog(@"---->%@",obj);
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.intValue == 0){
            NSArray *array = [[obj valueForKey:@"record"] valueForKey:@"accounts"];
            for (NSDictionary *dic in array) {
                BankAccount *account = [BankAccount accountWithDid:dic];
                [accountArray addObject:account];
            }
            [self.view addSubview:self.accountTable];
            [MBProgressHUD hideHUD];
            [self.accountTable reloadData];
        } else{
           [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
        
        
    } fail:^(NSString *errorMsg) {
        LSLog(@"---fail");
        [MBProgressHUD showError:errorMsg];
    }];

}


- (void)addAccount{
    AddAccountController *account = [[AddAccountController alloc] init];
    
    [self.navigationController pushViewController:account animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [accountArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"accountCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
    }
    BankAccount *accout = [accountArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = accout.bankName;
    cell.detailTextLabel.text = accout.accNo;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BankAccount *account = [accountArray objectAtIndex:indexPath.row];
        
        
        [MBProgressHUD showMessage:@"正在删除"];
        
        [[HttpRequest shareRequst] deleteAccountById:account.id success:^(id obj) {
            NSNumber *code = [obj valueForKey:@"code"];
            if (code.intValue == 0){
                [accountArray removeObject:account];
                // Delete the row from the data source.
                [self.accountTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [MBProgressHUD hideHUD];
                
            } else {
               [MBProgressHUD showError:[obj valueForKey:@"msg"]];
            }
        } fail:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg];
        }];
        
    }
}



@end
