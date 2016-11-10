//
//  CollectionViewCell.m
//  collectionview的多选
//
//  Created by Zhangguodong on 16/11/10.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

/**
 * 显示数据的label
 */
@property(nonatomic,strong)UILabel *dataLabel;

@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self dataLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.dataLabel.frame = CGRectMake(0, 10, self.contentView.frame.size.width, 44);
}

- (void)setDataStr:(NSString *)dataStr {
    _dataStr = dataStr;
    self.dataLabel.text = dataStr;
}
#pragma mark - 显示数据的Label
- (UILabel *)dataLabel {
    if (_dataLabel == nil) {
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.textAlignment = NSTextAlignmentCenter;
        _dataLabel.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_dataLabel];
    }
    return _dataLabel;
}
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.dataLabel.backgroundColor = [UIColor blueColor];
    }else {
        self.dataLabel.backgroundColor = [UIColor purpleColor];
    }
}
@end
