//
//  SecondViewController.m
//  collectionview的多选
//
//  Created by Zhangguodong on 16/11/10.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "SecondViewController.h"
#import "CollectionViewCell.h"

@interface SecondViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/**
 * collectionview
 */
@property(nonatomic,strong)UICollectionView *collectionview;
/**
 * 全部的数据
 */
@property(nonatomic,strong)NSMutableArray *dataArrM;

/**
 保存被选中的cel下标
 */
@property(nonatomic,strong)NSMutableIndexSet *selectedIndexSet;
/**
 * 返回按钮
 */
@property(nonatomic,strong)UIButton *backButton;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.selectedIndexSet = [NSMutableIndexSet indexSet];
    [self collectionview];
    [self backButton];
     [self updateSelections];
}
- (void)updateSelections {
    if (!self.selectedContactIds || ![self.selectedContactIds count]) {
        return;
    }
    NSIndexSet *selectedContactsIndexSet = [self.dataArrM indexesOfObjectsWithOptions:NSEnumerationConcurrent passingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //        NSLog(@"%lu",(unsigned long)idx);
        return [self.selectedContactIds containsObject:obj];
    }];
    [selectedContactsIndexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",self.selectedContactIds);
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [self.collectionview selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        [self.selectedIndexSet addIndex:indexPath.item];
    }];
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArrM.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.dataStr = self.dataArrM[indexPath.item];
    return cell;
}
// 设置是否允许选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// 设置是否允许取消选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedIndexSet addIndex:indexPath.item];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedIndexSet removeIndex:indexPath.item];
}
#pragma mark - 创建collectionview
- (UICollectionView *)collectionview {
    if (_collectionview == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(100, 40);
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 330) collectionViewLayout:flowLayout];
        _collectionview.backgroundColor = [UIColor orangeColor];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        [_collectionview registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionview.allowsMultipleSelection = YES;
        [self.view addSubview:_collectionview];
    }
    return _collectionview;
}
#pragma mark - 全部的数据
- (NSMutableArray *)dataArrM {
    if (_dataArrM == nil) {
        _dataArrM = [NSMutableArray array];
        for (NSInteger i = 0; i < 150; i ++) {
            [_dataArrM addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _dataArrM;
}
#pragma mark - 返回按钮
- (UIButton *)backButton {
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(100, 360, 100, 30);
        _backButton.backgroundColor = [UIColor orangeColor];
        [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backButton];
    }
    return _backButton;
}
- (void)backAction:(UIButton *)button {
    NSArray *seletedArr = [self.dataArrM objectsAtIndexes:self.selectedIndexSet];
    if (self.delegate && [self.delegate respondsToSelector:@selector(SecondViewController:seletedArr:)]) {
        [self.delegate SecondViewController:self seletedArr:seletedArr];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
