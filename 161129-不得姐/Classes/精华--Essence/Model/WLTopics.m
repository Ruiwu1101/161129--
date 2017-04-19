//
//  WLTopics.m
//  161129-不得姐
//
//  Created by wl on 2016/12/8.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLTopics.h"
#import "WLTopicViewController.h"
#import "WLTopicCell.h"
@implementation WLTopics
{
    CGFloat _cellHieght;
    CGRect _pictureF;
}
+ (instancetype)topicWithDict:(NSDictionary *)dict
{
    WLTopics *topic = [[self alloc] init];
//    topic.screen_name = dict[@"screen_name"];
//    topic.comment = dict[@"comment"];
//    topic.repost = dict[@"repost"];
//    topic.text = dict[@"text"];
//    topic.love = dict[@"text"];
//    topic.profile_image = dict[@"profile_image"];
//    topic.ding = dict[@"ding"];
//    topic.hate = dict[@"hate"];
//    topic.created_at = dict[@"created_at"];
//    topic.height = dict[@"height"];
//    topic.width = dict[@""];
    [topic setValuesForKeysWithDictionary:dict];
    return topic;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"cache_version"]) {
        self.cache_version = [value integerValue];
    }
}

- (CGFloat)cellHieght
{
    CGFloat tabBarH = [[WLTopicViewController alloc] init].tabBarController.tabBar.height;
    CGFloat margin = 10;
    CGFloat imageY = 50 + margin;
    
    if (!_cellHieght ) {
        //文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT);
        
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        CGFloat topH = imageY + textH + 2 * margin ;
        
        _cellHieght = topH;
        if (self.type == WLTopicTypePicture) {
            
            CGFloat pictureW = maxSize.width;
            CGFloat pictureH = self.height * pictureW / self.width;
            //pictureview的frame
            if (pictureH >= 1000) {
                
                _pictureF = CGRectMake(10, topH - 5, pictureW, 300);
                self.isBig = YES;
                _cellHieght = topH + 300 + margin;
            }else{
                
                _pictureF = CGRectMake(10, topH - 5, pictureW, pictureH);
                self.isBig = NO;
                _cellHieght = topH + pictureH + margin;
            }
            
        }else if (self.type == WLTopicTypeVoice){
            
            CGFloat voiceH = self.height * maxSize.width / self.width;
            _voiceF = CGRectMake(10, topH - 5, maxSize.width, voiceH);
            
            _cellHieght = topH + voiceH + margin;
        }else if (self.type == WLTopicTypeVideo){
            CGFloat videoH = self.height * maxSize.width / self.width;
            _voideoF = CGRectMake(10, topH - 5, maxSize.width, videoH);
            
            _cellHieght = topH + videoH + margin;
        
        }
    }
    
    return _cellHieght += tabBarH + 2 * margin;
}
@end
//@property (nonatomic,copy) NSString *screen_name;
////评论数量
//@property (nonatomic,copy) NSString *comment;
////转发数量
//@property (nonatomic,copy) NSString *repost;
////帖子内容
//@property (nonatomic,copy) NSString *text;
////收藏量
//@property (nonatomic,copy) NSString *love;
////头像
//@property (nonatomic,copy) NSString *profile_image;
////顶的数量
//@property (nonatomic,copy) NSString *ding;
////踩的数量
//@property (nonatomic,copy) NSString *hate;
