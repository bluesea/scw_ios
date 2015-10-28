//
//  UploadView.h
//  LoadImageView
//
//  Created by Leon on 11/10/14.
//  Copyright (c) 2014 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  UploadView;

@protocol UploadViewDelegate <NSObject>

@optional
- (void) uploadViewClickUpload:(UploadView *)uploadView btn:(UIButton *)upBtn;

@end

@interface UploadView : UIView

@property (nonatomic, weak) UIImageView *img;
@property (nonatomic, weak) UIButton *upBtn;

@property (nonatomic, weak) id<UploadViewDelegate> uploadViewDelegate;

@end
