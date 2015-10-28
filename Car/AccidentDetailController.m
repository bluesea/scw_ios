//
//  AccidentDetailController.m
//  Car
//
//  Created by Leon on 10/28/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "AccidentDetailController.h"
#import "BusinessView.h"
#import "DriverView.h"
#import "AccidentView.h"
#import "BusinessDetail.h"
#import "AccidentDetail.h"
#import "DriverModel.h"

#define  PADDING 8

@interface AccidentDetailController ()

@property (weak, nonatomic) IBOutlet UIScrollView *mainView;
@property (nonatomic, weak) BusinessView *bzView;
@property (nonatomic, weak) AccidentView *acView;
@property (nonatomic, weak) DriverView *drView;
@property  (nonatomic, assign) CGFloat height;
@end

@implementation AccidentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    BusinessView *businessView = [BusinessView businessViewStyle:BzViewStyleWithMoney];
    
    businessView.frame = CGRectMake(PADDING, PADDING, businessView.frame.size.width, businessView.frame.size.height);
    [self.mainView addSubview: businessView];
    _bzView = businessView;
    
    _height = CGRectGetMaxY(_bzView.frame) + PADDING;
    
    DriverView *driverView = [DriverView driverView];
    driverView.frame = CGRectMake(PADDING, _height,driverView.frame.size.width, driverView.frame.size.height);
    
    [self.mainView addSubview:driverView];
    _drView = driverView;
    
    _height = CGRectGetMaxY(_drView.frame) + PADDING;
    
    AccidentView *accidentView = [AccidentView accidentView];
    accidentView.frame = CGRectMake(PADDING, _height, accidentView.frame.size.width, accidentView.frame.size.height);
    
    [self.mainView addSubview:accidentView];
    _acView = accidentView;
    
     _height = CGRectGetMaxY(_acView.frame) + PADDING;
    
    self.mainView.contentSize = CGSizeMake(0, _height);
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.mainView setHidden:YES];

    [MBProgressHUD showMessage:@"正在加载"];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadData];
}

- (void)loadData{
    [[HttpRequest shareRequst] getAccidentDetialWithId:_order.id success:^(id obj) {
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.integerValue == 0){
            NSDictionary *record = [obj valueForKey:@"record"];
            OrderAbstract *order = [OrderAbstract orderAbstractWithDic:[record valueForKey:@"order"]];

            _bzView.order = order;
            
            DriverModel *driver = [DriverModel driverWithDic:[record valueForKey:@"driver"]];
            _drView.driver = driver;
            
            AccidentDetail *ac = [AccidentDetail accidentDetailWithDic:[record valueForKey:@"accident"]];
            _acView.accident = ac;

            [MBProgressHUD hideHUD];
            
            [self.mainView setHidden:NO];
            
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
    } fail:^(NSString *errorMsg) {
        LSLog(@"%@",errorMsg);
        [MBProgressHUD showError:errorMsg];
    }];
}

@end
