//
//  WLCategoryCell.m
//  161129-不得姐
//
//  Created by wl on 2016/12/1.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLCategoryCell.h"
#import "WLCategory.h"
@interface WLCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *leftView;


@end
@implementation WLCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = WLRGBColor(223, 223, 223);
    
    self.leftView.backgroundColor = WLRGBColor(251, 12, 68);
    
    self.textLabel.textColor = WLRGBColor(78, 78, 78);
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.height = self.contentView.height - 4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.leftView.hidden = NO;
        self.textLabel.textColor = WLRGBColor(251, 12, 68);
        self.backgroundColor = [UIColor whiteColor];
        self.textLabel.backgroundColor = [UIColor whiteColor];
        
    }else{
        self.leftView.hidden = YES;
        self.textLabel.textColor = WLRGBColor(78, 78, 78);
        self.textLabel.backgroundColor = WLRGBColor(223, 223, 223);
        self.backgroundColor = WLRGBColor(223, 223, 223);
    }
    
}

- (void)setCategory:(WLCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}

@end
