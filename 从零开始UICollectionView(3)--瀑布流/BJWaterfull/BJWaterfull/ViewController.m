//
//  ViewController.m
//  BJWaterfull
//
//  Created by bradleyjohnson on 2016/10/27.
//  Copyright © 2016年 bradleyjohnson. All rights reserved.
//

#import "ViewController.h"
#import "BJWaterfullModel.h"
#import "BJWaterfullLayout.h"
#import "BJWaterfullCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,BJWaterfullLayoutDelegate>

@property (nonatomic , strong) UICollectionView * collectionView;

@property (nonatomic , strong) NSArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
}

-(void)setUpView
{
    NSArray * plistArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data.plist" ofType:nil]];
    NSMutableArray * passArray = [NSMutableArray array];
    for (NSDictionary * dic in plistArray) {
        BJWaterfullModel * model = [BJWaterfullModel new];
        [model setValuesForKeysWithDictionary:dic];
        model.index = [plistArray indexOfObject:dic];
        [passArray addObject:model];
    }
    self.dataArray = [NSArray arrayWithArray:passArray];
    
    BJWaterfullLayout * layout = [[BJWaterfullLayout alloc] init];
    layout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor orangeColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[BJWaterfullCell class] forCellWithReuseIdentifier:[BJWaterfullCell reuseIdentifier]];
    [self.view addSubview:self.collectionView];
}

#pragma mark - delegate methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BJWaterfullCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BJWaterfullCell reuseIdentifier] forIndexPath:indexPath];
    
    cell.contentView.frame = cell.bounds;
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = self.dataArray[indexPath.row];
        
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BJWaterfullModel * model = self.dataArray[indexPath.row];
    
    NSLog(@"%ld : %@",indexPath.row,model.price);
}

-(CGFloat)BJWaterfullLayout:(BJWaterfullLayout *)layout index:(NSInteger)index weight:(CGFloat)weight
{
    BJWaterfullModel * model = self.dataArray[index];

    return weight*(model.h/model.w);
}














@end
