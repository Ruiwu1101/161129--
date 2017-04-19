//
//  WLTopics.h
//  161129-不得姐
//
//  Created by wl on 2016/12/8.
//  Copyright © 2016年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLTopics : NSObject
//发帖人昵称
@property (nonatomic,copy) NSString *screen_name;
//评论数量
@property (nonatomic,copy) NSString *comment;
//转发数量
@property (nonatomic,copy) NSString *repost;
//帖子内容
@property (nonatomic,copy) NSString *text;
//收藏量
@property (nonatomic,copy) NSString *love;
//头像
@property (nonatomic,copy) NSString *profile_image;
//顶的数量
@property (nonatomic,copy) NSString *ding;
//踩的数量
@property (nonatomic,copy) NSString *hate;

//新浪会员
@property (nonatomic,assign,getter=isSina_V) BOOL sina_v;

//动态图
@property (nonatomic,copy) NSString *is_gif;
//系统审核通过的时间
@property (nonatomic,copy) NSString *created_at;
//图片
@property (nonatomic,copy) NSString *image0;
@property (nonatomic,copy) NSString *image1;
@property (nonatomic,copy) NSString *image2;
//图片的高度
@property (nonatomic,assign) CGFloat height;
//图片的宽度
@property (nonatomic,assign) CGFloat width;

//快取副本
@property (nonatomic,assign) NSInteger cache_version;

//帖子类型
@property (nonatomic,assign) NSInteger type;
//音频时长
@property (nonatomic,copy) NSString *voicetime;
//音频URL
@property (nonatomic,copy) NSString *voiceuri;
//音频播放次数
@property (nonatomic,assign) NSInteger playcount;
//视频时长
@property (nonatomic,copy) NSString *videotime;
//视频URL
@property (nonatomic,copy) NSString *videouri;
//视频播放次数
@property (nonatomic,assign) NSInteger playfcount;

/** 额外属性*/
//cell的高度
@property (nonatomic,assign,readonly) CGFloat cellHieght;
/**图片的frame*/
@property (nonatomic,assign,readonly) CGRect pictureF;
/**音频的frame*/
@property (nonatomic,assign,readonly) CGRect voiceF;
/**视频的frame*/
@property (nonatomic,assign,readonly) CGRect voideoF;
/**是否是大图*/
@property (nonatomic,assign,getter=isBig) BOOL isBig;
/**图片下载进度*/
@property (nonatomic,assign) CGFloat picProgress;
+ (instancetype)topicWithDict:(NSDictionary *)dict;
@end
