//
//  CustomNavigationController.h
//  ABBBabyLifeTrack
//
//  Created by david on 13-4-26.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationController : UINavigationController <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic,assign) BOOL clickFlag;

@end
