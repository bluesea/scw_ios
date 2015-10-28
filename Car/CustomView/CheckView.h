//
//  CheckView.h
//  Car
//
//  Created by Leon on 11/11/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Check.h"

@interface CheckView : UIView

@property (nonatomic, strong) Check *check;

+ (instancetype) checkView;

@end
