//
//  BzDetailView.h
//  Car
//
//  Created by Leon on 11/3/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BusinessDetail;

@interface BzDetailView : UIView

@property (nonatomic, strong) BusinessDetail *bz;

+ (BzDetailView *) bzDetailView;

@end
