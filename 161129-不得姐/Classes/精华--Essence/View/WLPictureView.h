//
//  WLPictureView.h
//  161129-不得姐
//
//  Created by wl on 2016/12/12.
//  Copyright © 2016年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLTopics;
@interface WLPictureView : UIView
//帖子模型
@property (nonatomic,strong) WLTopics *topic;

+ (instancetype)picture;
@end
