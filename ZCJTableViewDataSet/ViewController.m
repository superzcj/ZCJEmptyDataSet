//
//  ViewController.m
//  ZCJTableViewDataSet
//
//  Created by zhangchaojie on 16/8/30.
//  Copyright © 2016年 zhangchaojie. All rights reserved.
//

#import "ViewController.h"
#import "ZCJTableDataSetView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ZCJTableDataSetView *dsView = [[ZCJTableDataSetView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    dsView.titleLbl.attributedText = [[NSAttributedString alloc] initWithString:@"我是标题"];
    dsView.detailLbl.attributedText = [[NSAttributedString alloc] initWithString:@"我是详情"];
    [self.view addSubview:dsView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
