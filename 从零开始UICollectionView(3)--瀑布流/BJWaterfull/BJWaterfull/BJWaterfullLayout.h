//
//  BJWaterfullLayout.h
//  BJWaterfull
//
//  Created by bradleyjohnson on 2016/10/27.
//  Copyright © 2016年 bradleyjohnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BJWaterfullLayout;

@protocol BJWaterfullLayoutDelegate <NSObject>

@required;
-(CGFloat)BJWaterfullLayout:(BJWaterfullLayout *)layout index:(NSInteger)index weight:(CGFloat)weight;

@end

@interface BJWaterfullLayout : UICollectionViewLayout

@property (nonatomic , weak) id<BJWaterfullLayoutDelegate> delegate;

@end
