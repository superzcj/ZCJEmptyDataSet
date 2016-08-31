//
//  UITableView+DataSet.h
//  ZCJTableViewDataSet
//
//  Created by zhangchaojie on 16/8/30.
//  Copyright © 2016年 zhangchaojie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZCJTableViewDataSetDataSouce <NSObject>

- (NSAttributedString *)titleForTableViewDataSet:(UITableView *)tableView;

- (NSAttributedString *)detailForTableViewDataSet:(UITableView *)tableView;

- (UIImage *)imageForTableViewDataSet:(UITableView *)tableView;

@end


@interface UITableView (DataSet)

@property (nonatomic, weak) id<ZCJTableViewDataSetDataSouce> dataSetSource;

@end
