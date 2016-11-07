//
//  MainCollectionHeaderView.m
//  UICollectionViewDemo
//
//  Created by bradleyjohnson on 2016/10/27.
//  Copyright © 2016年 bradleyjohnson. All rights reserved.
//

#import "MainCollectionHeaderView.h"

@interface MainCollectionHeaderView ()

@property (nonatomic , strong) UILabel * titleLabel;

@end

@implementation MainCollectionHeaderView

+(NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    self.titleLabel.frame = self.bounds;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = _title;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor lightGrayColor];
        _titleLabel.textColor = [UIColor blackColor];
    }
    
    return _titleLabel;
}

@end
