//
//  BJWaterfullModel.h
//  BJWaterfull
//
//  Created by bradleyjohnson on 2016/10/27.
//  Copyright © 2016年 bradleyjohnson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BJWaterfullModel : NSObject

@property (nonatomic , assign) CGFloat w;
@property (nonatomic , assign) CGFloat h;
@property (nonatomic , strong) NSString * price;
@property (nonatomic , strong) NSString * img;

@property (nonatomic , assign) NSInteger index;



@end
