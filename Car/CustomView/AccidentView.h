//
//  AccidentView.h
//  Car
//
//  Created by Leon on 10/29/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccidentDetail.h"

@interface AccidentView : UIView


@property (nonatomic, strong) AccidentDetail *accident;

+ (instancetype) accidentView;

@end
