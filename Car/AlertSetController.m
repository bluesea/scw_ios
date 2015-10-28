//
//  AlertSetController.m
//  Car
//
//  Created by Leon on 10/18/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "AlertSetController.h"

@interface AlertSetController ()

@property (nonatomic, strong) NSMutableArray *btnArray;

@property (weak, nonatomic) IBOutlet UIView *hourView;

@property (weak, nonatomic) IBOutlet UIView *speedView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
- (IBAction)saveAction;

- (IBAction)speedAction:(UIButton *)sender;

- (IBAction)alertAction:(UIButton *)sender;
@end

@implementation AlertSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [MBProgressHUD showMessage:@"正在加载..."];
    
    
    _btnArray = [NSMutableArray array];
    NSArray *array = [_speedView subviews];
    for (UIView *view in array){
        if([view isKindOfClass:[UIButton class]]){
            [_btnArray addObject:view];
        }
    }
    
    [self loadData];
}

- (void)loadData{
    [[HttpRequest shareRequst]getRemindConfByDriverId:_driverId success:^(id obj) {
        NSNumber *code = [obj valueForKey:@"code"];
        if(code.intValue == 0){
            NSDictionary *remindConf = [[obj objectForKey:@"record"] objectForKey:@"remindConf"];
            NSString *hourIds = [remindConf valueForKey:@"hourIds"];
            NSNumber *speedId = [remindConf valueForKey:@"speedId"];
            NSArray *array = [hourIds componentsSeparatedByString:@","];
            for (NSString * str in array) {
                UIButton *btn = (UIButton *)[self.hourView viewWithTag:str.integerValue + 2000];
                [btn setSelected:YES];
            }
            
            UIButton *btn = (UIButton *)[self.speedView viewWithTag:speedId.integerValue + 1000];
            [btn setSelected:YES];
            
            [self.mainView setHidden:NO];
            [MBProgressHUD hideHUD];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
        
        
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction {
    NSString *speedId;
    for (UIButton *btn in _btnArray) {
        if ([btn isSelected]){
            speedId = [NSString stringWithFormat:@"%d", btn.tag-1000];
        }
    }
//    NSMutableString *tmphourIds = [NSMutableString stringWithFormat:@""];
//    NSArray *views = [self.hourView subviews];
//    for (UIView *subView in views) {
//        if ([subView isKindOfClass:[UIButton class]]){
//            UIButton *btn = (UIButton *)subView;
//            if ([btn isSelected]){
//                [tmphourIds appendFormat:@"%d,",btn.tag-2000 ];
//            }
//        }
//    }
//    
//    NSString *hourIds = tmphourIds.length > 0 ? [tmphourIds substringToIndex:tmphourIds.length-1]:@"";
//    
//    [MBProgressHUD showMessage:@"正在保存"];
//    
//    [[HttpRequest shareRequst]saveRemindByDriverId:_driverId speedId:speedId hourIds:hourIds success:^(id obj) {
//        NSNumber *code = [obj valueForKey:@"code"];
//        if(code.intValue == 0){
//            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
//        } else {
//            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
//        }
//        
//        
//    } fail:^(NSString *errorMsg) {
//        
//        [MBProgressHUD showError:errorMsg];
//    }];
    
    [MBProgressHUD showMessage:@"正在保存"];
    [[HttpRequest shareRequst]saveRemindByDriverId:_driverId speedId:speedId hourIds:nil success:^(id obj) {
        NSNumber *code = [obj valueForKey:@"code"];
        if(code.intValue == 0){
            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
    } fail:^(NSString *errorMsg) {
        
        [MBProgressHUD showError:errorMsg];
    }];

    
    
}

- (IBAction)speedAction:(UIButton *)sender{
    if (![sender isSelected]){
        [sender setSelected:YES];
        for (UIButton *btn in _btnArray) {
            if (btn != sender){
                [btn setSelected:NO];
            }
        }
    }
}

- (IBAction)alertAction:(UIButton *)sender {
//    if ([sender isSelected]){
//        [sender setSelected:NO];
//    } else {
//        [sender setSelected:YES];
//    }
}
@end
