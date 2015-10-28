//
//  ArrivedView.m
//  Car
//
//  Created by Leon on 10/30/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ArrivedView.h"
#import "UIImageView+WebCache.h"
@interface ArrivedView ()

@property (weak, nonatomic) IBOutlet UIImageView *receiptPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *mancarPhoto;


@end


@implementation ArrivedView

+ (instancetype) arrivedView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ArrivedView" owner:nil options:nil] lastObject];

}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    [_receiptPhoto sd_setImageWithURL:[NSURL URLWithString:[_dic valueForKey:@"receiptPhoto"] ] placeholderImage:[UIImage imageNamed:@"no_pic"]];
    
    [_mancarPhoto sd_setImageWithURL:[NSURL URLWithString:[_dic valueForKey:@"mancarPhoto"] ] placeholderImage:[UIImage imageNamed:@"no_pic"]];
}

@end
