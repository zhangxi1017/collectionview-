//
//  ViewController.m
//  collectionview的多选
//
//  Created by Zhangguodong on 16/11/10.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()<SecondViewControllerDelegate>
/**
 * 保存被选中的数据
 */
@property(nonatomic,strong)NSArray *seletedArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 30);
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonAction:(UIButton *)button {
    SecondViewController *targetVC = [[SecondViewController alloc] init];
    targetVC.delegate = self;
    targetVC.selectedContactIds = [self contactIdsForContacts:self.seletedArr];
    [self.navigationController pushViewController:targetVC animated:YES];
}
- (NSSet *)contactIdsForContacts:(NSArray *)seletedArr {
    NSMutableSet *contactIdSet = [NSMutableSet set];
    for (NSString *str in seletedArr) {
        [contactIdSet addObject:str];
    }
    return contactIdSet;
}
#pragma mark - SecondViewControllerDelegate
- (void)SecondViewController:(SecondViewController *)vc seletedArr:(NSArray *)seletedArr {
    NSLog(@"%@",seletedArr);
    self.seletedArr = seletedArr;
}
@end
