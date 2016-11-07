//
//  BJWaterfullCell.m
//  BJWaterfull
//
//  Created by bradleyjohnson on 2016/10/27.
//  Copyright © 2016年 bradleyjohnson. All rights reserved.
//

#import "BJWaterfullCell.h"
#import "BJWaterfullModel.h"
#import "UIImageView+WebCache.h"

@interface BJWaterfullCell ()

@property (nonatomic , strong) UIImageView * showImg;
@property (nonatomic , strong) UILabel * priceLabel;


@end

@implementation BJWaterfullCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.showImg];
        [self.contentView addSubview:self.priceLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = self.contentView.bounds.size.height;
    self.showImg.frame = CGRectMake(0, 0, width, height*0.8);
    self.priceLabel.frame = CGRectMake(0, height*0.8, width, height*0.2);
}

+(NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

-(void)setModel:(BJWaterfullModel *)model
{
    _model = model;

    self.priceLabel.text = _model.price;
    
    [self.showImg sd_setImageWithURL:[NSURL URLWithString:_model.img]];
}


-(UIImageView *)showImg
{
    if (!_showImg) {
        _showImg = [[UIImageView alloc] init];
    }
    
    return _showImg;
}
-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.textColor = [UIColor redColor];
    }
    
    return _priceLabel;
}


@end
