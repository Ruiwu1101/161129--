//
//  WLPictureView.m
//  161129-不得姐
//
//  Created by wl on 2016/12/12.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLPictureView.h"
#import "WLTopics.h"
#import "WLProgressView.h"
#import <UIImageView+WebCache.h>
#import "WLShowPictureViewController.h"
@interface WLPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *bigBtn;
@property (weak, nonatomic) IBOutlet WLProgressView *progressView;


@end

@implementation WLPictureView

+ (instancetype)picture
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(WLTopics *)topic
{
    _topic = topic;
    //马上显示最新的下载进度
    [self.progressView setProgress:topic.picProgress animated:YES];
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:topic.image2] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        //计算进度值
        topic.picProgress = 1.0 * receivedSize / expectedSize;
        //显示进度值
        [self.progressView setProgress:topic.picProgress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        //如果是大图才进行处理
        if (topic.isBig == NO) return;
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        //将下载好的图片绘制到图像上下文上
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = image.size.height * width / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        //获得图片
        self.pictureView.image = UIGraphicsGetImageFromCurrentImageContext();
        //结束图形上下文
        UIGraphicsEndImageContext();
    }];
    //判断GIF标识
    self.gifView.hidden = ![topic.is_gif integerValue];
    //是否是大图
    if (topic.isBig) {//是大图
        self.bigBtn.hidden = NO;
    }else{//非大图
        self.bigBtn.hidden = YES;
    }
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.pictureView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modal)];
    [self.pictureView addGestureRecognizer:gesture];
}

- (void)modal
{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    WLShowPictureViewController *showVC = [[WLShowPictureViewController alloc] init];
    showVC.topic = self.topic;
    [vc presentViewController:showVC animated:NO completion:nil];
    vc.preferredContentSize = [UIScreen mainScreen].bounds.size;
}
@end
