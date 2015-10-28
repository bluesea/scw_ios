//
//  CustomTextField.m
//  Car
//
//  Created by Leon on 14-9-24.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _init];
    }
    return self;
}

- (void)awakeFromNib{
    [self _init];
}

//取消长按
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

- (void)_init{
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15,self.frame.size.height)];
    image.image = [UIImage imageNamed:@"icon-select"];
    image.contentMode =  UIViewContentModeCenter;
    image.backgroundColor = [UIColor lightGrayColor];
    self.rightView = image;
    self.rightViewMode =  UITextFieldViewModeAlways;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

@end
