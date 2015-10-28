//
//  OrderDetailViewController.m
//  Car
//
//  Created by Leon on 11/11/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "OrderDetailController.h"
#import "BusinessView.h"
#import "DriverView.h"
#import "ArrivedView.h"
#import "HuidanView.h"
#import "AccidentView.h"
#import "CheckView.h"
#import "Check.h"
#import "AccidentDetail.h"
#import "OrderAbstract.h"
#define PADDING 8

@interface OrderDetailController ()

@property (weak, nonatomic) IBOutlet UIScrollView *mainView;

/** 通用订单头 */
@property (nonatomic, weak) BusinessView *orderView;
/** 司机视图 */
@property (nonatomic, weak) DriverView *drView;
/** 意见视图 */
@property (nonatomic, weak) CheckView *checkView;
/** 回单视图*/
@property (nonatomic, weak) HuidanView *huidanView;
/** 事故视图 */
@property (nonatomic, weak) AccidentView *accView;
/** 到达视图 */
@property (nonatomic, weak) ArrivedView *arrivedView;

@property (weak, nonatomic) IBOutlet UIView *btnView1;
@property (weak, nonatomic) IBOutlet UIView *btnView2;
@property (weak, nonatomic) IBOutlet UIView *btnView3;
@property (weak, nonatomic) IBOutlet UIView *btnView4;

- (IBAction)checkAction:(UIButton *)sender;
- (IBAction)settleAction;


@property (nonatomic, assign) NSInteger showBtnType;

@property (nonatomic, assign) CGFloat height;

@end

@implementation OrderDetailController

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
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    LSLog(@"viewDidLoad");
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    LSLog(@"viewWillAppear");
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    LSLog(@"viewDidAppear");
    [self loadData];
}

- (void)initUI{
    BusinessView *businessView = [BusinessView businessViewStyle:BzViewStyleWithMoney];
    businessView.frame = (CGRect){PADDING,PADDING, businessView.frame.size};
    _orderView = businessView;
    
    [self.mainView addSubview:businessView];
    
    _height = CGRectGetMaxY(businessView.frame) + PADDING;
    
    if (_order.status == kOrderStatusGrabed ||
        _order.status == kOrderStatusUndoed ||
        _order.status == kOrderStatusPassed ||
        _order.status == kOrderStatusTransporting)
    {
        //司机view
        DriverView *driverView = [DriverView driverView];
        driverView.frame = (CGRect) {PADDING, _height, driverView.frame.size};
        _height = CGRectGetMaxY(driverView.frame) + PADDING;
        _drView = driverView;
        //checkView
        CheckView *checkView = [CheckView checkView];
        checkView.frame = (CGRect) {PADDING, _height, checkView.frame.size};
        _height = CGRectGetMaxY(checkView.frame) + PADDING;
        _checkView = checkView;
        
        [self.mainView addSubview:driverView];
        [self.mainView addSubview:checkView];
        
    } else if (_order.status == kOrderStatusArrived || _order.status == kOrderStatusConfirm){
        ArrivedView *arrivedView = [ArrivedView arrivedView];
        arrivedView.frame = (CGRect) {PADDING, _height, arrivedView.frame.size};
        _height = CGRectGetMaxY(arrivedView.frame) + PADDING;
        
        _arrivedView = arrivedView;
        [self.mainView addSubview:arrivedView];
        
    } else if (_order.status ==  kOrderStatusSlipsent || _order.status == kOrderStatusSlipgot ){
        HuidanView *huidanView = [HuidanView huidanView];
        huidanView.frame = (CGRect) {PADDING, _height, huidanView.frame.size};
        _height = CGRectGetMaxY(huidanView.frame) + PADDING;
        
        _huidanView = huidanView;
        [self.mainView addSubview:huidanView];
        
    } else if (_order.status == kOrderStatusAccident || _order.status == kOrderStatusAccover){
        
        AccidentView *accidentView = [AccidentView accidentView];
        accidentView.frame = (CGRect) {PADDING, _height, accidentView.frame.size};
        _height = CGRectGetMaxY(accidentView.frame) + PADDING;
        
        _accView = accidentView;
        [self.mainView addSubview:accidentView];
    }
    
}



- (void)loadData{
    [[HttpRequest shareRequst]getOrderInfoWithOrderId:[NSString stringWithFormat:@"%d",_order.id] userId:UserDefaults(@"userId") success:^(id obj) {
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.integerValue == 0){
            NSDictionary *record = [obj valueForKey:@"record"];
            
            [self dealWithRecord:record];
            
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
}


- (void) dealWithRecord:(NSDictionary *)record{
    
    OrderAbstract *order = [OrderAbstract orderAbstractWithDic:[record valueForKey:@"order"]];
    
    _orderView.order = order;
    
    if (_order.status == kOrderStatusGrabed ||
        _order.status == kOrderStatusUndoed ||
        _order.status == kOrderStatusPassed ||
        _order.status == kOrderStatusTransporting)
    {
        DriverModel *driver = [DriverModel driverWithDic:[record valueForKey:@"driver"]];
        //司机view
        _drView.driver = driver;
        //checkView
        Check *check = [Check checkWithDic:[record valueForKey:@"check"]];
        _checkView.check = check;
        
    } else if (_order.status == kOrderStatusArrived || _order.status == kOrderStatusConfirm){
        _arrivedView.dic = [record valueForKey:@"arrived"];
        
        
    } else if (_order.status ==  kOrderStatusSlipsent || _order.status == kOrderStatusSlipgot ){
        _huidanView.dic = [record valueForKey:@"slipsent"];
        
    } else if (_order.status == kOrderStatusAccident || _order.status == kOrderStatusAccover){
        AccidentDetail *accident = [AccidentDetail accidentDetailWithDic:[record valueForKey:@"accident"]];
        _accView.accident = accident;
    }
    
    _showBtnType = [[record valueForKey:@"showButton"] integerValue];
    if (_showBtnType != 0){
        UIView *view = [self.mainView viewWithTag:_showBtnType];
        view.hidden = NO;
        view.frame = CGRectMake(PADDING, _height, view.frame.size.width, view.frame.size.height);
        _height = CGRectGetMaxY(view.frame) + PADDING;
    }
    
    self.mainView.contentSize = CGSizeMake(0, _height);
    
    self.mainView.hidden = NO;
    
    [MBProgressHUD hideHUD];
    
}
- (IBAction)checkAction:(UIButton *)sender {
    
    [MBProgressHUD showMessage:@"正在提交"];
    
    [[HttpRequest shareRequst] orderCheckWithOrderId:[NSString stringWithFormat:@"%d",_order.id] userId:UserDefaults(@"userId") type:[NSString stringWithFormat:@"%d",_showBtnType] value:[NSString stringWithFormat:@"%d",sender.tag] success:^(id obj) {
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.intValue == 0){
            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
    
}

- (IBAction)settleAction {
    
}
@end
