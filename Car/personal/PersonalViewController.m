//
//  PersonalViewController.m
//  Car
//
//  Created by Leon on 8/30/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "PersonalViewController.h"
#import "OrderListController.h"
#import "MyMsgListController.h"
#import "MenuUtil.h"
#import "PermissionUtil.h"
#import "AMRatingControl.h"
#import "UIImageView+WebCache.h"

@interface PersonalViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITableView *personView;
@property (weak, nonatomic) IBOutlet UIImageView *avatorImage;  //头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;        //姓名
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *comNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UILabel *starTagLabel;
@property (nonatomic, weak) AMRatingControl *ratingControl;

@property (weak, nonatomic) IBOutlet UIView *starView;

//司机
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;       //业务总金额
@property (weak, nonatomic) IBOutlet UILabel *completeLabel;    //已完成业务数
@property (weak, nonatomic) IBOutlet UILabel *unCompleteLabel;  //未完成业务数
//@property (nonatomic, strong) NSString *type;

//管理员
@property (weak, nonatomic) IBOutlet UILabel *pubCount;
@property (weak, nonatomic) IBOutlet UILabel *transCount;
@property (weak, nonatomic) IBOutlet UILabel *pubMoney;

//运力
//@property (weak, nonatomic) IBOutlet UILabel *allDrivers;
//@property (weak, nonatomic) IBOutlet UILabel *busyDrivers;
//@property (weak, nonatomic) IBOutlet UILabel *jobDrivers;
//@property (weak, nonatomic) IBOutlet UILabel *freeDrivers;

//资源
@property (weak, nonatomic) IBOutlet UILabel *unSettledFee;
@property (weak, nonatomic) IBOutlet UILabel *unSettledTrans;

//管理员view
@property (weak, nonatomic) IBOutlet UIView *commonManageView;

@property (weak, nonatomic) IBOutlet UIView *managerView;

@property (weak, nonatomic) IBOutlet UIView *yunliView;
@property (weak, nonatomic) IBOutlet UIView *headerView;

//司机view
@property (weak, nonatomic) IBOutlet UIView *driverView;

//action
//司机订单查看
- (IBAction)driverOrderAction:(UIButton *)sender;

@property (nonatomic, strong) NSArray *menuArray;

@end

@implementation PersonalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"个人中心";
        UIBarButtonItem *msgBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"message.png"] style:UIBarButtonItemStyleDone target:self action:@selector(gotoMsg)];
        self.navigationItem.rightBarButtonItem = msgBtn;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [MBProgressHUD showMessage:@"正在加载"];
    
    if([PermissionUtil checkPermissionWithRole:ROLE_DRIVER]){
        //隐藏管管理员视图
        self.managerView.hidden = YES;
        self.yunliView.hidden = YES;
        
        _menuArray = [MenuUtil driverMenu];
        AMRatingControl *coloredRatingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(0, 0)
                                                                               emptyColor:[UIColor grayColor]
                                                                               solidColor:[UIColor yellowColor]
                                                                             andMaxRating:5];
        [self.starView addSubview:coloredRatingControl];
        _ratingControl = coloredRatingControl;
        self.starTagLabel.hidden = NO;
        _commonManageView.hidden = YES;
        
    } else if ([PermissionUtil checkPermissionWithRole:ROLE_MANAGER_TRA]){
        self.driverView.hidden = YES;
        self.yunliView.hidden = YES;
        _menuArray = [MenuUtil transManagerMenu];
        
        
    } else if ([PermissionUtil checkPermissionWithRole:ROLE_MANAGER_RES]){
        self.driverView.hidden = YES;
        self.yunliView.hidden = YES;
        _menuArray = [MenuUtil resourceManagerMenu];
    }
    
    [self loadData];
    
}

- (void)loadData{
    [[HttpRequest shareRequst] showMyCenterWithId:UserDefaults(@"userId") success:^(id obj) {
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.intValue == 0){
            NSDictionary *dic = [[obj valueForKey:@"record"] valueForKey:@"myCenter"];
            _roleLabel.text = dic[@"ruleName"];
            _nameLabel.text = dic[@"name"];
            _comNameLabel.text = dic[@"comName"];
            _timeLabel.text = [NSString stringWithFormat:@"%@",dic[@"activeTime"]];
            [_avatorImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"headPicUrl"]]]];
            
            if([PermissionUtil checkPermissionWithRole:ROLE_DRIVER]){
                _moneyLabel.text= [NSString stringWithFormat:@"%@元",dic[@"orderMoneys"]];
                _completeLabel.text = [NSString stringWithFormat:@"%@",dic[@"countCOMP"]];
                _unCompleteLabel.text =[NSString stringWithFormat:@"%@",dic[@"countUNCP"]];
                NSInteger starNum = [dic[@"starNum"] integerValue];
                [_ratingControl setRating:starNum];
                
            } else {
                _pubCount.text = [NSString stringWithFormat:@"%@",dic[@"pubCount"]];
                _transCount.text = [NSString stringWithFormat:@"%@",dic[@"transCount"]];
                _pubMoney.text = [NSString stringWithFormat:@"%@元",dic[@"pubMoney"]];
                _unSettledFee.text = [NSString stringWithFormat:@"%@元",dic[@"unSettledFee"]];
                
                _unSettledTrans.text = [NSString stringWithFormat:@"%@元",dic[@"unSettledTrans"]];
                
            }
            self.tableView.hidden = NO;
            [MBProgressHUD hideHUD];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 39;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"personCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [[_menuArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou.png"]];
    cell.backgroundColor = RGBColor(235, 233, 234);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *classString = [[_menuArray objectAtIndex:indexPath.row] objectForKey:@"vc"];
    
    if(classString != nil && !([classString isEqualToString:@""])){
        Class someClass = NSClassFromString(classString);
        UIViewController *next = [[someClass alloc] init];
        next.title = [[_menuArray objectAtIndex:indexPath.row] objectForKey:@"title"];
        [self.navigationController pushViewController:next animated:YES];
    } else {
        LSLog(@"----未定义视图!!");
    }
    
}


#pragma mark - Action
#pragma mark 消息中心
- (void)gotoMsg{
    LSLog(@"----go to msg");
    MyMsgListController *msgList = [[MyMsgListController alloc] init];
    [self.navigationController pushViewController:msgList animated:YES];
}

#pragma mark 所有订单
- (IBAction)driverOrderAction:(UIButton *)sender {
    OrderListController *list = [[OrderListController alloc]init];
    list.type = sender.tag;
    list.title = sender.titleLabel.text;
    [self.navigationController pushViewController:list animated:YES];
}


@end
