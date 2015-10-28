//
//  PlatformViewController.m
//  Car
//
//  Created by Leon on 8/8/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "PlatformViewController.h"
#import "PlatFormCell.h"
#import "UIImageView+WebCache.h"

@interface PlatformViewController (){
    NSArray *news;
    NSArray *companys;
    NSArray *flows;
    NSArray *bzs;
}


@end

@implementation PlatformViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"平台";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setHidden:YES];
    // Do any additional setup after loading the view from its nib.

    
}

- (void)viewDidAppear:(BOOL)animated{
    [[HttpRequest shareRequst] getPlatInfo:^(id obj) {
        NSNumber *code = [obj objectForKey:@"code"];
        if (code.intValue == 0){
            NSDictionary *platData = [[obj objectForKey:@"record"] objectForKey:@"platformData"];
            news = [platData objectForKey:@"newsList"];
            companys = [platData objectForKey:@"companyList"];
            flows = [platData objectForKey:@"flowList"];
            bzs = [platData objectForKey:@"newBusiList"];
            self.bzNewNum.text = [NSString stringWithFormat:@"%@",[platData objectForKey:@"newBusiCount"]];
            self.totalNum.text = [NSString stringWithFormat:@"%@",[platData objectForKey:@"sumBusiCount"]];
            self.completeNum.text = [NSString stringWithFormat:@"%@",[platData objectForKey:@"completeBusiCount"]];
            self.doingNum.text = [NSString stringWithFormat:@"%@",[platData objectForKey:@"transportingBusiCount"]];
            
            [self.tableView reloadData];
            [self.tableView setHidden:NO];
        }
    } fail:^(NSString *errorMsg) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return [bzs count];
            break;
        case 1:
            return [flows count];
            break;
        case 2:
            return [news count];
            break;
        case 3:

            return ([companys count] % 4 == 0) ? ([companys count] /4) : ([companys count] /4 +1) ;
        default:
            break;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSString *identifier = [NSString stringWithFormat:@"platformCell%ld",(long)indexPath.section];
    
    PlatFormCell *cell=[tableView  dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil || cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"PlatFormCell" owner:nil options:nil] objectAtIndex:indexPath.section ];
    }
    
    if (indexPath.section == 0){
        LSLog(@"000000------%@",[[bzs objectAtIndex:indexPath.row] objectForKey:@"content"]);
        cell.bzLbl.text = [[bzs objectAtIndex:indexPath.row] objectForKey:@"content"];
    } else if(indexPath.section == 1) {
        LSLog(@"000000------%@",[[flows objectAtIndex:indexPath.row] objectForKey:@"content"]);
        cell.fLbl.text = [[flows objectAtIndex:indexPath.row] objectForKey:@"content"];
    } else if (indexPath.section == 2){
        cell.newsLbl.text = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell.tLbl.text = [[news objectAtIndex:indexPath.row] objectForKey:@"ctime"];
    }else if(indexPath.section == 3){
        int count = companys.count;
        
        int temp = 4;
        
        if (count / 4 - 1  < indexPath.row){
            temp = count - 4 *indexPath.row;
        }
        
        NSRange range = NSMakeRange(0 + indexPath.row*4, temp);
        NSArray *subArray = [companys subarrayWithRange:range];
        int i =1;
        int j = 11;
        if (subArray.count > 0){
            for (NSDictionary *dic in subArray) {
                UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:i];
                [image sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"headPUrl"]] placeholderImage:[UIImage imageNamed:@"avator"]];
                [image setHidden:NO];
                UILabel *label = (UILabel *)[cell.contentView viewWithTag:j];
                label.text = [dic objectForKey:@"name"];
                [label setHidden:NO];
                i++;
                j++;
            }
        }

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3){
        return  100;
    }
    return 36;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
    label.font = [UIFont systemFontOfSize:15.0];
    label.textColor = [UIColor blueColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 40, 9,22,22)];
    [btn setImage:[UIImage imageNamed:@"plat_more.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];

    switch (section) {
        case 0:
            label.text = @"最新业务";
            btn.tag = 100;
            break;
        case 1:
            label.text = @"运力流向";
            btn.tag = 101;
            break;
        case 2:
            label.text = @"新闻中心";
            btn.tag = 102;
            break;
        case 3:
            label.text = @"最新会员";
            btn.tag = 103;
            break;
        default:
            break;
    }
    [headerView addSubview:label];
    [headerView addSubview:btn];
    return headerView;
}

- (void)loadMore:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
            LSLog(@"-----最新业务");
            break;
        case 101:
            LSLog(@"-----运力流向");
            break;
        case 102:
            LSLog(@"-----新闻中心");
            break;
        case 103:
            LSLog(@"-----最新会员");
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}



@end
