//
//  ViewController.m
//  UICollectionViewDemo
//
//  Created by bradleyjohnson on 2016/10/27.
//  Copyright © 2016年 bradleyjohnson. All rights reserved.
//

#import "ViewController.h"
#import "MainCollectionViewCell.h"
#import "MainCollectionHeaderView.h"
#import "MainCollectionFooterView.h"

#import "MainModel.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) UICollectionView * mainCollectionView;

@property (nonatomic , strong) NSArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.mainCollectionView];
}

#pragma mark - data source methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray * subArray = self.dataArray[section];
    return subArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    cell.contentView.frame = cell.bounds;
    cell.backgroundColor = [UIColor lightGrayColor];
    
    MainModel * model = self.dataArray[indexPath.section][indexPath.row];
    
    cell.title = model.indexStr;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionReusableView * reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        MainCollectionHeaderView * headerV = (MainCollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[MainCollectionHeaderView reuseIdentifier] forIndexPath:indexPath];

        headerV.backgroundColor = [UIColor redColor];
        headerV.title = [NSString stringWithFormat:@"这是第 %ld 组头部视图",indexPath.section];
        
        reusableview = headerV;
        
    }
    
    if (kind == UICollectionElementKindSectionFooter){
        
        MainCollectionFooterView * footerV = (MainCollectionFooterView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[MainCollectionFooterView reuseIdentifier] forIndexPath:indexPath];
        
        footerV.backgroundColor = [UIColor greenColor];
        footerV.title = [NSString stringWithFormat:@"这是第 %ld 组尾部视图",indexPath.section];

        reusableview = footerV;
        
    }

    return reusableview;
}

//是否允许移动 item
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0)
{
    return YES;
}

//移动 item 行为
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath NS_AVAILABLE_IOS(9_0)
{
    
}

#pragma mark - UICollectionViewDelegate methods
//是否允许某个 item 的高亮，返回NO，则不能进入高亮状态
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//高亮状态触发的方法
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor grayColor];
    
    NSLog(@"%ld--%ld : 高亮状态触发",indexPath.section,indexPath.item);
}
//高亮状态结束触发的方法
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor lightGrayColor];
    
    NSLog(@"%ld--%ld : 高亮状态结束触发",indexPath.section,indexPath.item);
}
//能否选中某个 item，返回NO，则不能被选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//能否取消某个 item 的选中状态，返回NO，则不能取消被选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//选中某个 item 触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainModel * model = self.dataArray[indexPath.section][indexPath.item];
    NSLog(@"选中 : %@",model.indexStr);
}

//取消某个 item 触发
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"取消选中 : %ld--%ld",indexPath.section,indexPath.item);
}

//将要加载某个 item 触发
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0)
{
    
}

//将要加载某个头部尾部视图时触发
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0)
{
    
}

//加载完成某个 item 时触发
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//加载完成某个头部尾部视图时触发
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    
}

//这个方法设置是否展示长按菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

//这个方法用于设置要展示的菜单选项 只支持 cut: 、copt: 、paste: ， 通过对对应方法的返回来设置
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    return YES;
}

//这个方法用于实现点击菜单按钮后的触发方法,通过测试，只有copy，cut和paste三个方法可以使用
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    NSLog(@"%@",NSStringFromSelector(action));
}

//这个方法用于通过layout进行重新布局调用的方法
//- (nonnull UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout
//{
//    
//}

#pragma mark - UICollectionViewDelegateFlowLayout methods
// cell 尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.bounds.size.width-5-5-10*2)/3.0, 50);
}

// 装载内容 cell 的内边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

//item最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

//头视图尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 50);
}

//尾视图尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 50);
}



#pragma mark - private methods
//长按手势状态控制移动 item
-(void)didReceiveLongPress:(UILongPressGestureRecognizer *)longpress
{
    if (self.mainCollectionView == nil) return;
    
    CGPoint location = [longpress locationInView:self.mainCollectionView];
    
    NSIndexPath * indexpath = [self.mainCollectionView indexPathForItemAtPoint:location];
    
    static UICollectionViewCell * cell;
    static UIView * fakeCell;
    static CGPoint beginLocation;
    static NSIndexPath * beginIndex;

    switch (longpress.state) {
        case UIGestureRecognizerStateBegan:
        {
            cell = [self.mainCollectionView cellForItemAtIndexPath:indexpath];
            cell.hidden = YES;
            
            fakeCell = [self customSnapshoFromView:cell.contentView];
            fakeCell.frame = cell.frame;
            [self.mainCollectionView addSubview:fakeCell];
            
            beginLocation = location;
            beginIndex = indexpath;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat moveX = location.x-beginLocation.x;
            CGFloat moveY = location.y-beginLocation.y;
            
            fakeCell.center = CGPointMake(fakeCell.center.x+moveX, fakeCell.center.y+moveY);
            
            beginLocation = location;
            
            
            NSIndexPath * nowIndexpath = [self.mainCollectionView indexPathForItemAtPoint:location];
            UIView * nowView = [self.mainCollectionView cellForItemAtIndexPath:nowIndexpath];

            if ((nowIndexpath.section==0&&nowIndexpath.row==0)&&(nowView==nil)) {
                
                nowIndexpath = [NSIndexPath indexPathForItem:[self.mainCollectionView numberOfItemsInSection:beginIndex.section]-1 inSection:beginIndex.section];

            }

            [self changeDataSourcesFromSources:beginIndex toDestination:nowIndexpath];
            
            [self.mainCollectionView moveItemAtIndexPath:beginIndex toIndexPath:nowIndexpath];
            
            beginIndex = nowIndexpath;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [fakeCell removeFromSuperview];
            fakeCell = nil;
            
            cell.hidden = NO;
        }
            break;
        default:
        {            
            [fakeCell removeFromSuperview];
            fakeCell = nil;
            
            cell.hidden = NO;

        }
            break;
    }
}

-(void)changeDataSourcesFromSources:(NSIndexPath *)sourceIndexPath toDestination:(NSIndexPath *)destinationIndexPath
{
    NSMutableArray * moveArray = [NSMutableArray arrayWithArray:self.dataArray];
    
    MainModel * model = moveArray[sourceIndexPath.section][sourceIndexPath.item];
    NSMutableArray * subArray = [NSMutableArray arrayWithArray:moveArray[sourceIndexPath.section]];
    [subArray removeObject:model];
    moveArray[sourceIndexPath.section] = [NSArray arrayWithArray:subArray];
    
    NSMutableArray * subToArray = [NSMutableArray arrayWithArray:moveArray[destinationIndexPath.section]];
    [subToArray insertObject:model atIndex:destinationIndexPath.item];
    moveArray[destinationIndexPath.section] = [NSArray arrayWithArray:subToArray];
    
    self.dataArray = [NSArray arrayWithArray:moveArray];
}

#pragma mark 创建cell的快照
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    // 用cell的图层生成UIImage，方便一会显示
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 自定义这个快照的样子（下面的一些参数可以自己随意设置）
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
//    snapshot.layer.masksToBounds = NO;
//    snapshot.layer.cornerRadius = 0.0;
//    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
//    snapshot.layer.shadowRadius = 5.0;
//    snapshot.layer.shadowOpacity = 0.4;
    return snapshot;
}

#pragma mark - initializes attributes

-(UICollectionView *)mainCollectionView
{
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
        
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        
        [_mainCollectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:[MainCollectionViewCell reuseIdentifier]];
        [_mainCollectionView registerClass:[MainCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[MainCollectionHeaderView reuseIdentifier]];
        [_mainCollectionView registerClass:[MainCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[MainCollectionFooterView reuseIdentifier]];
        
        //添加长按手势来移动 item
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didReceiveLongPress:)];
        [_mainCollectionView addGestureRecognizer:longPress];
        _mainCollectionView.userInteractionEnabled = YES;
    }
    
    return _mainCollectionView;
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSArray alloc] init];
        
        NSMutableArray * theArray = [NSMutableArray array];
        for (NSInteger index = 0; index < 3; index++) {
            NSMutableArray * subArray = [NSMutableArray array];
            for (NSInteger indexJ = 0; indexJ < 10; indexJ++) {
                MainModel * model = [MainModel new];
                model.indexStr = [NSString stringWithFormat:@"%ld-%ld",index,indexJ];
                model.scale = (arc4random()%11)/10.0+1;
                [subArray addObject:model];
            }
            [theArray addObject:[NSArray arrayWithArray:subArray]];
        }
        
        _dataArray = [NSArray arrayWithArray:theArray];
    }
    
    return _dataArray;
}

@end
