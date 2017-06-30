//
//  HomeViewController.m
//  WeiboHomeDemo
//
//  Created by zengchunjun on 2017/6/19.
//  Copyright © 2017年 zengchunjun. All rights reserved.
//

#import "HomeViewController.h"

#import "TableViewController1.h"
#import "TableViewController2.h"
#import "TableViewController3.h"


#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface HomeViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate,TableViewScrollingProtocol>

// 最底部scrollview的contentsize约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fullScrollHeightConst;
//headerView的高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeightConst;


@property (weak, nonatomic) IBOutlet UIScrollView *fullScrollView;


@property (weak, nonatomic) IBOutlet UIButton *headerView;

@property (weak, nonatomic) IBOutlet UIView *titleView;

//底部 承载 自控制器的view的scrollview
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (nonatomic, assign) BOOL isInitialize;// 是否已经初始化子控制器

@property (nonatomic, strong) NSMutableArray *titleButtons;

@property (nonatomic, weak) UIButton *selectButton;

@property (nonatomic,assign)CGFloat offsetY;//记录 Y轴的偏移量
//记录是否 titleView已经在顶部，由此 来判断 是否由哪个scrollview（最底层的fullscrollview和下面的三个tableview）来偏移
@property (nonatomic,assign)BOOL isTop;

@end

@implementation HomeViewController


- (NSMutableArray *)titleButtons
{
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.title  = @"home";
    // Do any additional setup after loading the view from its nib.
    
    self.fullScrollView.delegate = self;
    self.scrollView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addChildViewControllers];// 添加子控制器
    
    if (_isInitialize == NO) {
        // 4.设置所有标题
        [self setupAllTitle];
        
        _isInitialize = YES;
    }

    // 获取headerView中的信息后进行设置
    [self setHeaderViewData];
    
}

- (void)setHeaderViewData
{
    // 设置 headerView的数据后，再确定header的高度约束
    self.headerViewHeightConst.constant = CGRectGetMaxY(self.headerView.frame);
    
    self.fullScrollHeightConst.constant = self.headerViewHeightConst.constant - 64;
}

- (void)addChildViewControllers
{
    
    TableViewController1 *tab1 = [[TableViewController1 alloc] init];
    tab1.delegate = self;
    tab1.title = @"tab1";
    [self addChildViewController:tab1];
    
    TableViewController2 *tab2 = [[TableViewController2 alloc] init];
    tab2.delegate = self;
    tab2.title = @"tab2";
    [self addChildViewController:tab2];
    
    TableViewController3 *tab3 = [[TableViewController3 alloc] init];
    tab3.delegate = self;
    tab3.title = @"tab3";
    [self addChildViewController:tab3];
}


#pragma mark - 设置所有标题
- (void)setupAllTitle
{
    // 添加所有标题按钮
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = ScreenW / count;
    CGFloat btnH = self.titleView.bounds.size.height;
    CGFloat btnX = 0;
    for (NSInteger i = 0; i < count; i++) {
        
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        btnX = i * btnW;
        titleButton.frame = CGRectMake(btnX, 0, btnW, btnH);
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 监听按钮点击
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 把标题按钮保存到对应的数组
        [self.titleButtons addObject:titleButton];
        
        if (i == 0) {
            [self titleClick:titleButton];
        }
        
        [self.titleView addSubview:titleButton];
    }
    
    // 设置内容的滚动范围
    self.scrollView.contentSize = CGSizeMake(count * ScreenW, 0);
    
}

#pragma mark - 处理标题点击
- (void)titleClick:(UIButton *)button
{
    NSInteger i = button.tag;
    
    // 1.标题颜色 变成 红色
    [self selButton:button];
    
    // 2.把对应子控制器的view添加上去
    [self setupOneViewController:i];
    
    // 3.内容滚动视图滚动到对应的位置
    CGFloat x = i * [UIScreen mainScreen].bounds.size.width;
    self.scrollView.contentOffset = CGPointMake(x, 0);
}


#pragma mark - 选中标题
- (void)selButton:(UIButton *)button
{
    _selectButton.transform = CGAffineTransformIdentity;
    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    // 标题居中
//    [self setupTitleCenter:button];
    
    // 字体缩放:形变
    button.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    _selectButton = button;
}

#pragma mark - 添加一个子控制器的View
- (void)setupOneViewController:(NSInteger)i
{
    
    UIViewController *vc = self.childViewControllers[i];
    if (vc.view.superview) {
        return;
    }
    CGFloat x = i * [UIScreen mainScreen].bounds.size.width;
    vc.view.frame = CGRectMake(x, 0, ScreenW  , self.scrollView.bounds.size.height);
    [self.scrollView addSubview:vc.view];
}



#pragma mark - UIScrollViewDelegate
// 滚动完成的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.fullScrollView == scrollView) { //fullScrollViw只负责监听Y轴的偏移量，来控制导航栏
        
    }else{
        // 获取当前角标
        NSInteger i = scrollView.contentOffset.x / ScreenW;
        
        // 获取标题按钮
        UIButton *titleButton = self.titleButtons[i];
        
        // 1.选中标题
        [self selButton:titleButton];
        
        // 2.把对应子控制器的view添加上去
        [self setupOneViewController:i];
    }
}

// 只要一滚动就需要字体渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 
    if (self.fullScrollView == scrollView) {//fullScrollViw只负责监听Y轴的偏移量，来控制导航栏
        
        CGFloat offsetY = scrollView.contentOffset.y;
        self.offsetY = offsetY;
        
    }else{
        // 字体缩放 1.缩放比例 2.缩放哪两个按钮
        NSInteger leftI = scrollView.contentOffset.x / ScreenW;
        NSInteger rightI = leftI + 1;
        
        // 获取左边的按钮
        UIButton *leftBtn = self.titleButtons[leftI];
        NSInteger count = self.titleButtons.count;
        
        // 获取右边的按钮
        UIButton *rightBtn;
        if (rightI < count) {
            rightBtn = self.titleButtons[rightI];
        }
        
        // 0 ~ 1 =>  1 ~ 1.3
        // 计算缩放比例
        CGFloat scaleR = scrollView.contentOffset.x / ScreenW;
        
        scaleR -= leftI;
        
        // 左边缩放比例
        CGFloat scaleL = 1 - scaleR;
        
        // 缩放按钮
        leftBtn.transform = CGAffineTransformMakeScale(scaleL * 0.3 + 1, scaleL * 0.3 + 1);
        rightBtn.transform = CGAffineTransformMakeScale(scaleR * 0.3 + 1, scaleR * 0.3 + 1);
        
        // 颜色渐变
        UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
        UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
        [rightBtn setTitleColor:rightColor forState:UIControlStateNormal];
        [leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
    }
    
    //如果在顶部，底层的fullscroll偏移量保持最高
    if (self.isTop) {
        self.fullScrollView.contentOffset = CGPointMake(0, (self.headerViewHeightConst.constant - 64));
    }
    
}



- (void)tableViewScroll:(UITableView *)tableView offsetY:(CGFloat)offsetY
{
    //titleView还没有滑到顶部，那么 fullscrollview继续滑动，底部的tableview的偏移量应该为0
    if (self.offsetY < (self.headerViewHeightConst.constant - 64)) {
        
        // 这里主要是为了下面的子tableview能够下拉刷新 底层的fullscrollview的偏移量为0并且底部的子tableview的偏移量 <0 时就需要下拉刷新，此时，就需要底部的tableView产生偏移量来显示下拉刷新的效果，所有就可以设置tableView.contentOffset = CGPointMake(0, offsetY)
        if (offsetY < 0 && self.offsetY == 0) {
            tableView.contentOffset = CGPointMake(0, offsetY);
        }else{
            tableView.contentOffset = CGPointMake(0, 0);
        }
        
    }else{ //titleView已经滑到顶部
        self.isTop = YES;
        tableView.contentOffset = CGPointMake(0, offsetY);
    }
    
    // 当底部的tableview下拉滑动到顶部，也就是titleview即将往下滑动的时候，就设置 isTop为NO,那么此时，底层的fullscrollview 就会往下滑动，
    if (offsetY <= 0 || self.offsetY == 0) {
        self.isTop = NO;
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
