

//
//  WLTopicCell.m
//  161129-不得姐
//
//  Created by wl on 2016/12/9.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLTopicCell.h"
#import <UIImageView+WebCache.h>
#import "WLTopics.h"
#import "WLPictureView.h"
#import "WLVoiceView.h"
#import "WLVideoView.h"
#import "WLTopicViewController.h"
@interface WLTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sina_VimageView;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
//段子内容
@property (weak, nonatomic) IBOutlet UILabel *text_label;

/**图片中间的内容*/
@property (nonatomic,weak) WLPictureView *pictureView;
/**音频中间的内容*/
@property (nonatomic,weak) WLVoiceView *voiceView;
/**视频中间的内容*/
@property (nonatomic,weak) WLVideoView *videoView;
@end
@implementation WLTopicCell

- (WLPictureView *)pictureView
{
    if (!_pictureView) {
        WLPictureView *pictureView = [WLPictureView picture];
        [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
    }
    
    return _pictureView;
}

- (WLVoiceView *)voiceView
{
    if (!_voiceView) {
        WLVoiceView *voiceView = [WLVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        self.voiceView = voiceView;
    }
    
    return _voiceView;
}

- (WLVideoView *)videoView
{
    if (!_videoView) {
        WLVideoView *videoView = [WLVideoView videoView];
        [self.contentView addSubview:videoView];
        self.videoView = videoView;
    }
    return _videoView;
}
- (void)setTopic:(WLTopics *)topic
{
    _topic = topic;
    [self.iconView setIconView:topic.profile_image];
    self.nameLabel.text = topic.screen_name;
    self.timeLabel.text = topic.created_at;
//    [self.dingBtn setTitle:[NSString stringWithFormat:@"%@",topic.ding] forState:UIControlStateNormal];
    [self.dingBtn setTitle:topic.ding forState:UIControlStateNormal];
//    [self.caiBtn setTitle:[NSString stringWithFormat:@"%@",topic.hate] forState:UIControlStateNormal];
     [self.caiBtn setTitle:topic.hate forState:UIControlStateNormal];
//    [self.shareBtn setTitle:[NSString stringWithFormat:@"%@",topic.repost] forState:UIControlStateNormal];
    [self.shareBtn setTitle:topic.repost forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%@",topic.comment] forState:UIControlStateNormal];
    self.text_label.text = topic.text;
   //根据帖子类型显示合适的中间内容
    if (self.topic.type == WLTopicTypePicture) {//图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (self.topic.type == WLTopicTypeVoice){//声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (self.topic.type == WLTopicTypeVideo){//视频帖子
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.voideoF;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }else{//段子帖子
     
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.sina_VimageView.hidden = YES;
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    //取消选中状态
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
//    frame.origin.x += 5;
//    frame.size.width -= 10;
    frame.origin .y +=5;
    frame.size.height -= 10;
    
    [super setFrame:frame];
    
}
@end
