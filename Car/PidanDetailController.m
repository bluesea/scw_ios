//
//  PidanDetailController.m
//  Car
//
//  Created by Leon on 10/27/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "PidanDetailController.h"
#import "PermissionUtil.h"
#import "ComDetailView.h"
#import "BusinessView.h"
#import "BzDetailView.h"
#import "BusinessDetail.h"
#import "CompanyModel.h"
#import "DriverScanController.h"

#define PADDING 8

@interface PidanDetailController ()

@property (weak, nonatomic) IBOutlet UIScrollView *mainView;
@property (weak, nonatomic) IBOutlet UIView *opinionView;
@property (weak, nonatomic) IBOutlet UILabel *opinionLabel;
@property (nonatomic, weak) BusinessView *bzView;
@property (nonatomic, weak) ComDetailView *comView;
@property (nonatomic, weak) BzDetailView *bzDetailView;
@property (weak, nonatomic) IBOutlet UIView *resBtnView;
@property (weak, nonatomic) IBOutlet UIView *traBtnView;

// ResAction
- (IBAction)agreeAction;
- (IBAction)disagreeAction;

//TraAction
- (IBAction)appointHead;


@end

@implementation PidanDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //    UIScrollView
    self.title = @"批单详情";
    
    [MBProgressHUD showMessage:@"正在加载"];
    
    [self initUI];
    
    [self loadData];
}

#pragma mark - UI
- (void) initUI{
    
    CGFloat mainWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewWidth = mainWidth - 2 * PADDING;
    CGFloat height = 0;
    // 资源型公司管理员展示
    if ([PermissionUtil checkPermissionWithRole:ROLE_MANAGER_RES]){
        
        _bzView = [BusinessView businessViewStyle:BzViewStyleWithNone];
        _bzView.frame = CGRectMake(PADDING, PADDING, viewWidth , 120);
        
        [self.mainView addSubview:_bzView];
        _comView = [ComDetailView comDetailView];
        
        _comView.frame = CGRectMake(PADDING, CGRectGetMaxY(_bzView.frame)+ PADDING , viewWidth, 386);
        
        [self.mainView addSubview:_comView];
        
        
        _opinionView.frame = CGRectMake(PADDING, CGRectGetMaxY(_comView.frame) + 8, viewWidth, 40);
        
        height = CGRectGetMaxY(_opinionView.frame) + 8;
        
        if (_endorse.status == EndorseStatusGrabed){
            _resBtnView.hidden = NO;
            _resBtnView.frame = CGRectMake(PADDING, height, viewWidth, 40);
            height = CGRectGetMaxY(_resBtnView.frame) + 8;
        }
        
        _mainView.contentSize = CGSizeMake(0, height + PADDING);
        
    }
    // 运力型公司管理员展示
    else if ([PermissionUtil checkPermissionWithRole:ROLE_MANAGER_TRA]){
        
        _bzView = [BusinessView businessViewStyle:BzViewStyleWithTime];
        _bzView.frame = CGRectMake(PADDING, PADDING, viewWidth, 120);
        [self.mainView addSubview:_bzView];
        
        _bzDetailView = [BzDetailView bzDetailView];
        _bzDetailView.frame = CGRectMake(PADDING, CGRectGetMaxY(_bzView.frame)+ PADDING , viewWidth, 618);
        [self.mainView addSubview:_bzDetailView];
        
        _opinionView.frame = CGRectMake(PADDING, CGRectGetMaxY(_bzDetailView.frame) + 8, viewWidth, 40);
        
        height = CGRectGetMaxY(_opinionView.frame) + 8;
        
        if (_endorse.status == EndorseStatusPassed ) {
            _traBtnView.hidden = NO;
            _traBtnView.frame = CGRectMake(PADDING, height, viewWidth, 40);
            height = CGRectGetMaxY(_traBtnView.frame) + 8;
        }
        _mainView.contentSize = CGSizeMake(0, height + PADDING);
    }
}


#pragma mark - Data
- (void)loadData{
    
    if ([PermissionUtil checkPermissionWithRole:ROLE_MANAGER_RES]){
        
        [[HttpRequest shareRequst] getEndorseDetailForResWithId:[NSString stringWithFormat:@"%d",_endorse.id] success:^(id obj) {
            NSNumber *code = [obj valueForKey:@"code"];
            if (code.intValue == 0){
                NSDictionary *record = [obj valueForKey:@"record"];
                
                //titleView
                NSDictionary *endorseDic = [record valueForKey:@"endorse"];
                EndorseAbstract *endorse = [EndorseAbstract endorseAbstractWithDic:endorseDic];
                _bzView.endorse = endorse;
                
                //companyView
                NSDictionary *comDic = [record valueForKey:@"company"];
                CompanyModel *com = [CompanyModel companyWithDic:comDic];
                _comView.company = com;
                
                //资源方意见
                self.opinionLabel.text  = [[record valueForKey:@"resCheck"] valueForKey:@"name"];
                
                
                [self.mainView setHidden:NO];
                [MBProgressHUD hideHUD];
            } else  {
                [MBProgressHUD showError:[obj valueForKey:@"msg"]];
            }
            
            
        } fail:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg];
        }];
        
    } else if ([PermissionUtil checkPermissionWithRole:ROLE_MANAGER_TRA]){
        [[HttpRequest shareRequst] getEndorseDetailForTraWithId:[NSString stringWithFormat:@"%d",_endorse.id] success:^(id obj) {
            NSNumber *code = [obj valueForKey:@"code"];
            if (code.intValue == 0){
                NSDictionary *record = [obj valueForKey:@"record"];
                
                //titleView
                NSDictionary *endorseDic = [record valueForKey:@"endorse"];
                EndorseAbstract *endorse = [EndorseAbstract endorseAbstractWithDic:endorseDic];
                _bzView.endorse = endorse;
                
                //businessView
                NSDictionary *busiDic = [record valueForKey:@"business"];
                BusinessDetail *bz = [BusinessDetail businessDetailWithDic:busiDic];

                _bzDetailView.bz = bz;
                
                
                //资源方意见
                self.opinionLabel.text  = [[record valueForKey:@"resCheck"] valueForKey:@"name"];
                
                
                [self.mainView setHidden:NO];
                [MBProgressHUD hideHUD];
            } else  {
                [MBProgressHUD showError:[obj valueForKey:@"msg"]];
            }
            
        } fail:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg];
        }];
    }
    
    
}

#pragma  mark 同意按钮
- (IBAction)agreeAction {
    [MBProgressHUD showMessage:@"正在提交"];
    [[HttpRequest shareRequst] endorseCheckWithEndorseId:_endorse.id auditValue:@"1" success:^(id obj) {
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

#pragma mark 不同意
- (IBAction)disagreeAction {
    [MBProgressHUD showMessage:@"正在提交"];
    [[HttpRequest shareRequst] endorseCheckWithEndorseId:_endorse.id auditValue:@"2" success:^(id obj) {
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

#pragma mark 指派领队
- (IBAction)appointHead {
    DriverScanController *appointHead = [[DriverScanController alloc] init];
    appointHead.title = @"领队查找";
    //    appointHead.driverScanType = DriverScanTypeAppointHead;
    [[NSUserDefaults standardUserDefaults] setInteger:_endorse.id forKey:TRA_PIDAN_ID];
    [self.navigationController pushViewController:appointHead animated:YES];
}
@end
