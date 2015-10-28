//
//  ComDetailView.h
//  Car
//
//  Created by Leon on 11/4/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CompanyModel;

@interface ComDetailView : UIView

@property (nonatomic, strong) CompanyModel *company;

+ (instancetype) comDetailView;

@end
