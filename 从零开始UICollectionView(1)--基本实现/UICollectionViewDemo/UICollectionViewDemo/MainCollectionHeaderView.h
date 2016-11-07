//
//  MainCollectionHeaderView.h
//  UICollectionViewDemo
//
//  Created by bradleyjohnson on 2016/10/27.
//  Copyright © 2016年 bradleyjohnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionHeaderView : UICollectionReusableView

+(NSString *)reuseIdentifier;

@property (nonatomic , strong) NSString * title;

@end
