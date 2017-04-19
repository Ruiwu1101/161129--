//
//  WLRecommendTagCell.m
//  161129-不得姐
//
//  Created by wl on 2016/12/5.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLRecommendTagCell.h"
#import "WLRecommengTag.h"
#import <UIImageView+WebCache.h>
@interface WLRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sub_NumberLabel;

@end
@implementation WLRecommendTagCell

- (void)setRecoTag:(WLRecommengTag *)recoTag
{
    _recoTag = recoTag;
    self.nameLabel.text = recoTag.theme_name;
    
    [self.iconView setIconView:recoTag.image_list];
    self.sub_NumberLabel.text = [NSString stringWithFormat:@"%@人订阅",recoTag.sub_number];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 5;
    frame.size.width -= 10;
    frame.size.height -= 1;
    [super setFrame:frame];
    
}

@end
