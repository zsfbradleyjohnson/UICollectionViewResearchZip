//
//  BJCardCell.h
//  BJCardCollectionView
//
//  Created by bradleyjohnson on 2016/10/28.
//  Copyright © 2016年 bradleyjohnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJCardCell : UICollectionViewCell

@property (nonatomic , strong) NSString * title;


+(NSString *)reuseIdentifier;

@end
