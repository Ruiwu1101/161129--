//
//  WLVoiceView.m
//  161129-不得姐
//
//  Created by wl on 2016/12/15.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLVoiceView.h"
#import "WLTopics.h"
#import <UIImageView+WebCache.h>
@interface WLVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *voiceImage;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

@end
@implementation WLVoiceView

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(WLTopics *)topic
{
    _topic = topic;
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    [self.voiceImage sd_setImageWithURL:[NSURL URLWithString:topic.image2]];
    
    NSInteger count = [topic.voicetime integerValue];
    NSInteger minute = count / 60;
    NSInteger second = count % 60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%zd:%zd",minute,second];
    
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}


- (IBAction)play:(id)sender {
    
}

@end
