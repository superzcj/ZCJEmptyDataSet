//
//  UITableView+DataSet.m
//  ZCJTableViewDataSet
//
//  Created by zhangchaojie on 16/8/30.
//  Copyright © 2016年 zhangchaojie. All rights reserved.
//

#import "UITableView+DataSet.h"
#import "ZCJTableDataSetView.h"
#import <objc/runtime.h>

static void *ZCJContentSizeCtx = &ZCJContentSizeCtx;
static NSString* const kContentSize = @"contentSize";
static char const * const kDataSetView = "dataSetView";
static char const * const kDataSetDataSource = "dataSetDataSource";

@implementation UITableView (DataSet)
@dynamic dataSetSource;


- (void)reloadDataSet {
    if (self.dataSource && [self totalRows] == 0) {
        
        [self.dataSetView updateConstraintsIfNeeded];
        
        
        self.dataSetView.titleLbl.attributedText = [self titleLableText];
        self.dataSetView.detailLbl.attributedText = [self detailLableText];
        self.dataSetView.imgView.image = [self image];
        
        self.dataSetView.hidden = NO;
        self.dataSetView.alpha = 1;
        
        [self.dataSetView updateConstraints];
        [self.dataSetView layoutIfNeeded];
    }
}

- (NSInteger)totalRows {
    NSInteger sections = [self.dataSource numberOfSectionsInTableView:self];
    NSInteger totalRows = 0;
    for (int i=0; i<sections; i++) {
        NSInteger rows = [self.dataSource tableView:self numberOfRowsInSection:i];
        totalRows += rows;
    }
    
    return totalRows;
}

- (NSAttributedString *)titleLableText {
    if ([self.dataSetSource respondsToSelector:@selector(titleForTableViewDataSet:)]) {
        return [self.dataSetSource titleForTableViewDataSet:self];
    }
    return nil;
}

- (NSAttributedString *)detailLableText {
    if ([self.dataSetSource respondsToSelector:@selector(detailForTableViewDataSet:)]) {
        return [self.dataSetSource detailForTableViewDataSet:self];
    }
    return nil;
}

- (UIImage *)image {
    if ([self.dataSetSource respondsToSelector:@selector(imageForTableViewDataSet:)]) {
        return [self.dataSetSource imageForTableViewDataSet:self];
    }
    return nil;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (context == ZCJContentSizeCtx) {
        NSValue *new = [change objectForKey:@"new"];
        NSValue *old = [change objectForKey:@"old"];
        if (new && old && ![new isEqualToValue:old]) {
            if ([keyPath isEqualToString: kContentSize]) {
                [self reloadDataSet];
            }
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (id<ZCJTableViewDataSetDataSouce>)dataSetSource
{
    return objc_getAssociatedObject(self, kDataSetDataSource);
}

- (void)setDataSetSource:(id<ZCJTableViewDataSetDataSouce>)source
{
    [self addObserver:self forKeyPath:kContentSize options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld|NSKeyValueObservingOptionPrior context:ZCJContentSizeCtx];
    
    objc_setAssociatedObject(self, kDataSetDataSource, source, OBJC_ASSOCIATION_ASSIGN);
}

- (ZCJTableDataSetView *)dataSetView {
    id view = objc_getAssociatedObject(self, kDataSetView);
    if (!view) {
        ZCJTableDataSetView *view = [[ZCJTableDataSetView alloc] initWithFrame:self.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        view.hidden = YES;
        view.alpha = 0;
        
        [self addSubview:view];
        
        objc_setAssociatedObject(self, kDataSetView, view, OS_OBJECT_USE_OBJC_RETAIN_RELEASE);
    }
    return view;
}

@end
