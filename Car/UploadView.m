//
//  UploadView.m
//  LoadImageView
//
//  Created by Leon on 11/10/14.
//  Copyright (c) 2014 Leon. All rights reserved.
//

#import "UploadView.h"

@implementation UploadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    self.backgroundColor = [UIColor clearColor];
    CGFloat width = self.frame.size.width * 0.5;
    CGFloat height = self.frame.size.height;
    
    
    UIImageView *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn2 setTitle:@"上传照片" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [btn2 addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
    _img = imageView;
    _upBtn = btn2;
    [self addSubview:_img];
    [self addSubview:btn2];
    
}

- (void)awakeFromNib{
    [self initUI];
}

- (void)upload:(UIButton *)btn{
    if ([self.uploadViewDelegate respondsToSelector:@selector(uploadViewClickUpload:btn:)]){
        [self.uploadViewDelegate uploadViewClickUpload:self btn:btn];
    }
}

@end
