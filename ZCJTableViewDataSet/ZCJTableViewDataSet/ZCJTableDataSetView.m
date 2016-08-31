//
//  ZCJTableDataSetView.m
//  ZCJTableViewDataSet
//
//  Created by zhangchaojie on 16/8/30.
//  Copyright © 2016年 zhangchaojie. All rights reserved.
//

#import "ZCJTableDataSetView.h"

@interface ZCJTableDataSetView()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic) BOOL didConfigureConstraints;

@end

@implementation ZCJTableDataSetView


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.contentView];
        
        [_contentView addSubview:self.titleLbl];
        [_contentView addSubview:self.detailLbl];
        [_contentView addSubview:self.imgView];
    }
    return self;
}


- (void)updateConstraintsIfNeeded
{
    [super updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    [super updateConstraints];
    
    [_contentView removeConstraints:_contentView.constraints];
    
    CGFloat width = (self.frame.size.width > 0) ? self.frame.size.width : [UIScreen mainScreen].bounds.size.width;
    
    NSInteger multiplier = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 16 : 4;
    NSNumber *padding = @(roundf(width/multiplier));
    NSNumber *imgWidth = @(roundf(_imgView.image.size.width));
    NSNumber *imgHeight = @(roundf(_imgView.image.size.height));
    NSNumber *trailing = @(roundf((width-[imgWidth floatValue])/2.0));
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self,_contentView,_titleLbl,_detailLbl,_imgView);
    NSDictionary *metrics = NSDictionaryOfVariableBindings(padding,trailing,imgWidth,imgHeight);
    
    if (!self.didConfigureConstraints) {
        self.didConfigureConstraints = YES;
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[self]-(<=0)-[_contentView]"
                              
                                                                     options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]-(<=0)-[_contentView]"
                                                                     options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    }
    
    [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[_titleLbl]-padding-|"
                                                                         options:0 metrics:metrics views:views]];
    
    
    [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[_detailLbl]-padding-|"
                                                                         options:0 metrics:metrics views:views]];
    
    
    [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-trailing-[_imgView(100)]-trailing-|"
                                                                         options:0 metrics:metrics views:views]];
    
    NSMutableString *format = [NSMutableString new];
    NSMutableArray *subviews = [NSMutableArray new];
    
    if (_imgView.image) [subviews addObject:@"[_imgView(100)]"];
    if (_titleLbl.attributedText.string.length > 0) [subviews addObject:@"[_titleLbl]"];
    if (_detailLbl.attributedText.string.length > 0) [subviews addObject:@"[_detailLbl]"];
    
    [subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [format appendString:obj];
        if (idx < subviews.count-1) {
            [format appendString:@"-11-"];
        }
    }];
    
    if (format.length > 0) {
        [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|%@|", format]
                                                                             options:0 metrics:metrics views:views]];
    }
}

#pragma mark - Getter
-(UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView.backgroundColor = [UIColor clearColor];
        
    }
    return _contentView;
}

-(UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.backgroundColor = [UIColor clearColor];
        
        _titleLbl.font = [UIFont systemFontOfSize:27.0];
        _titleLbl.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _titleLbl.numberOfLines = 1;
    }
    return _titleLbl;
}

-(UILabel *)detailLbl {
    if (!_detailLbl) {
        _detailLbl = [UILabel new];
        _detailLbl.translatesAutoresizingMaskIntoConstraints = NO;
        
        _detailLbl.backgroundColor = [UIColor clearColor];
        
        _detailLbl.font = [UIFont systemFontOfSize:17.0];
        _detailLbl.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _detailLbl.textAlignment = NSTextAlignmentCenter;
        _detailLbl.lineBreakMode = NSLineBreakByWordWrapping;
        _detailLbl.numberOfLines = 0;
    }
    return _detailLbl;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imgView;
}

@end
