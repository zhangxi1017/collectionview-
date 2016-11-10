//
//  SecondViewController.h
//  collectionview的多选
//
//  Created by Zhangguodong on 16/11/10.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SecondViewController;
@protocol SecondViewControllerDelegate <NSObject>

- (void)SecondViewController:(SecondViewController *)vc seletedArr:(NSArray *)seletedArr;

@end

@interface SecondViewController : UIViewController
/**
 * 代理
 */
@property(nonatomic,weak)id<SecondViewControllerDelegate>delegate;
/**
 * 被选中的数据
 */
@property (nonatomic, strong) NSSet* selectedContactIds;
@end
