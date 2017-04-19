//
//  WLCategoryUserCell.m
//  161129-不得姐
//
//  Created by wl on 2016/12/2.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLCategoryUserCell.h"
#import "WLCategoryUsers.h"
#import <UIImageView+WebCache.h>
@interface WLCategoryUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCount;
@property (weak, nonatomic) IBOutlet UIButton *concernBtn;

@end
@implementation WLCategoryUserCell
- (IBAction)concernClick:(id)sender {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.concernBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(WLCategoryUsers *)user
{
    _user = user;
    
    self.nameLabel.text = user.screen_name;
    
    self.fansCount.text = [NSString stringWithFormat:@"%@人关注",user.fans_count];
    
    [self.iconView setIconView:user.header];
    
}

@end
