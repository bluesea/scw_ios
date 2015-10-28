//
//  MyForumViewController.h
//  Car
//
//  Created by Leon on 9/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCSlideSwitchView.h"

@interface MyForumViewController : UIViewController<QCSlideSwitchViewDelegate>

@property (weak, nonatomic) IBOutlet QCSlideSwitchView *myForumView;
@property (nonatomic, strong) NSArray *forumArray;

@end
