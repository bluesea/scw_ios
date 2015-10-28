//
//  MsgDetailController.h
//  Car
//
//  Created by Leon on 14-9-28.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MsgDetailController : UIViewController

@property (nonatomic, strong) MessageModel *msg;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *senderLbl;
@property (weak, nonatomic) IBOutlet UITextView *contentField;

@end
