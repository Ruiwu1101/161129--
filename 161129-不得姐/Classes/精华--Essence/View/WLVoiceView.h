//
//  WLVoiceView.h
//  161129-不得姐
//
//  Created by wl on 2016/12/15.
//  Copyright © 2016年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLTopics;
@interface WLVoiceView : UIView
+ (instancetype)voiceView;

//帖子属性
@property (nonatomic,strong) WLTopics *topic;
@end
