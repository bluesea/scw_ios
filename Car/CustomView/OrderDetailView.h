//
//  OrderDetailView.h
//  Car
//
//  Created by Leon on 11/7/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BusinessDetail;
@interface OrderDetailView : UIView

@property (nonatomic, strong) BusinessDetail *bz;

+ (instancetype) orderView;

@end
