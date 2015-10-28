//
//  MsgDetailController.m
//  Car
//
//  Created by Leon on 14-9-28.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "MsgDetailController.h"

@interface MsgDetailController ()

@end

@implementation MsgDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"消息详情";
    
    self.titleLbl.text = _msg.title;
    self.senderLbl.text =_msg.fromName;
    self.timeLbl.text = _msg.ctime;
    self.contentField.text = _msg.content;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
