//
//  OrderManageController.m
//  Car
//
//  Created by Leon on 10/29/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "OrderManageController.h"
#import "QCSlideSwitchView.h"
#import "OrderManageListController.h"
#import "OrderDetailController.h"


@interface OrderManageController () <QCSlideSwitchViewDelegate,ManageOrderListDelgate>

@property (weak, nonatomic) IBOutlet QCSlideSwitchView *orderView;
@property (nonatomic, strong) NSArray *orderListArray;
@end

@implementation OrderManageController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"订单管理";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view from its nib.
    self.orderView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"868686"];
    self.orderView.tabItemSelectedColor = [QCSlideSwitchView colorFromHexRGB:@"0d68d9"];
    self.orderView.shadowImage = [[UIImage imageNamed:@"blue_line.png"]
                                    stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    OrderManageListController *fabu = [[OrderManageListController alloc] init];
    fabu.manageOrderListDelgate = self;
    fabu.title = @"我方发布";
    fabu.orderType = OrderTypeMyPublish;
    OrderManageListController  *chengyu = [[OrderManageListController alloc ]init];
    chengyu.title = @"我方承运";
    chengyu.manageOrderListDelgate = self;
    chengyu.orderType = OrderTypeMyGet;
    _orderListArray  = @[fabu,chengyu];
    
    [self.orderView buildUI];
}

#pragma mark - 滑动tab视图代理方法

- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    return [_orderListArray count];
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return [_orderListArray objectAtIndex:number];
}

//- (void)slideSwitchView:(QCSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer *)panParam
//{
//    QCViewController *drawerController = (QCViewController *)self.navigationController.mm_drawerController;
//    [drawerController panGestureCallback:panParam];
//}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    OrderManageListController *vc = [_orderListArray objectAtIndex:number];
    [vc viewDidCurrentView];
}

- (void)managerOrderListShowDetial:(OrderManageListController *)controller index:(NSInteger)index{
    LSLog(@"%@ ->> %d", controller, index);
    OrderDetailController *order = [[OrderDetailController alloc] init];
    order.order = controller.dataArray[index];
    [self.navigationController pushViewController:order animated:YES];
}

@end
