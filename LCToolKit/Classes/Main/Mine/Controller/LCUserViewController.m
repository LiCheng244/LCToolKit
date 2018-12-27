//
//  LCUserViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2017/12/11.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "LCUserViewController.h"
#import "LCMineHeaderCell.h"

#define IconImgViewWidth 70

@interface LCUserViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation LCUserViewController



- (UIImage *)imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;

    return img;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"个人中心";

    self.titles = @[@"公开文章", @"私密文章", @"收藏的文章", @"喜欢的文章", @"我的文章", @"公开文章", @"私密文章", @"收藏的文章", @"喜欢的文章", @"我的文章", @"公开文章", @"私密文章"];

    [self setupNavTitleView];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LCMineHeaderCell class]) bundle:nil] forCellReuseIdentifier:@"LCMineHeaderCell"];
}


/** 自定义导航栏的 titleView */
-(void)setupNavTitleView{

    // 自定义导航 titleView
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 0, IconImgViewWidth, IconImgViewWidth/2);

    // 头像图片
    self.iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_icon"]];
    self.iconImgView.frame = CGRectMake(0, 0, IconImgViewWidth, IconImgViewWidth);
    self.iconImgView.backgroundColor = [UIColor whiteColor];
    self.iconImgView.layer.cornerRadius = IconImgViewWidth/2;
    self.iconImgView.layer.masksToBounds = YES;
    [titleView addSubview:self.iconImgView];

    // 设置
    self.navigationItem.titleView = titleView;
}


#pragma mark - <UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }else{
        return self.titles.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) { // 个人信息

        LCMineHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"LCMineHeaderCell"];
        return headerCell;

    } else { // 列表

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"UITableViewCell"];
        }
        cell.textLabel.text = self.titles[indexPath.row];


        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 220;
    }else{
        return 50;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    /// 注意：
    // 当前视图y值偏移量 + tableView 的顶部的内边距
    CGFloat contentSet = scrollView.contentOffset.y + self.tableView.contentInset.top;

    if (contentSet >= 0 && contentSet <= IconImgViewWidth/2) { // 头像的下半部分还没有偏移到导航栏时

        // 偏移量 0 - IconImgViewWidth/2 图片逐渐缩小
        // 偏移量 IconImgViewWidth/2 - 0 图片逐渐放大
        self.iconImgView.transform = CGAffineTransformMakeScale(1-contentSet/IconImgViewWidth, 1-contentSet/IconImgViewWidth);
        self.iconImgView.lc_y = 0;

    } else if (contentSet > IconImgViewWidth/2){ // 向上滚动 超过固定高度后， 图片变为原来的一半大小

        self.iconImgView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        self.iconImgView.lc_y = 0;

    } else if (contentSet < 0){  // 在正常界面向下拉时，界面不变
        self.iconImgView.transform = CGAffineTransformMakeScale(1, 1);
        self.iconImgView.lc_y = 0;
    }

    /**
     *      CGAffineTransformMakeScale

     *  缩放效果  两个参数： 代表宽，高的缩放比例
     */
}




@end
