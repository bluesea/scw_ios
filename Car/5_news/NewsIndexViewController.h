//
//  NewsIndexViewController.h
//  Car
//
//  Created by Leon on 9/11/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCSlideSwitchView.h"

@interface NewsIndexViewController : UIViewController <QCSlideSwitchViewDelegate>

@property (nonatomic, strong)NSMutableArray *newsArrays;
@property (nonatomic, assign) NSInteger board;

@property (weak, nonatomic) IBOutlet QCSlideSwitchView *slideView;


@end
