//
//  WLVideoView.h
//  161129-不得姐
//
//  Created by wl on 2016/12/15.
//  Copyright © 2016年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLTopics;
@interface WLVideoView : UIView
+ (instancetype)videoView;
//帖子模型
@property (strong,nonatomic)WLTopics *topic;
@end
