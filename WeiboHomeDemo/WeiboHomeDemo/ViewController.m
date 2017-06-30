//
//  ViewController.m
//  WeiboHomeDemo
//
//  Created by zengchunjun on 2017/6/19.
//  Copyright © 2017年 zengchunjun. All rights reserved.
//

#import "ViewController.h"

#import "HomeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"viewController";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    HomeViewController *home = [[HomeViewController alloc] init];
    
    [self.navigationController pushViewController:home animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
