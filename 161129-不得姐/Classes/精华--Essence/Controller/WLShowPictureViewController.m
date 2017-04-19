//
//  WLShowPictureViewController.m
//  161129-不得姐
//
//  Created by wl on 2016/12/12.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLShowPictureViewController.h"
#import "WLTopics.h"
#import "WLProgressView.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
@interface WLShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//大图
@property (nonatomic,weak) UIImageView *imageView;
    @property (weak, nonatomic) IBOutlet WLProgressView *progressView;
    
@end

@implementation WLShowPictureViewController    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.size = [UIScreen mainScreen].bounds.size;
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screeneH = [UIScreen mainScreen].bounds.size.height;
    CGFloat pictureH = self.topic.height * screenW / self.topic.width;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    //监听imageview点击
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [imageView addGestureRecognizer:tap];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    if (pictureH > screeneH) {//图片一个屏幕不够显示
        self.imageView.frame = CGRectMake(0, 0, screenW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
        }else{//图片够一个屏幕显示
            self.imageView.height = pictureH;
            self.imageView.width = screenW;
            //CGPoint center = CGPointMake(0, 0);
            CGPoint center = self.view.center;
            center.y = [UIScreen mainScreen].bounds.size.height * 0.5;
            //center.x = [UIScreen mainScreen].bounds.size.width * 0.5;
            self.imageView.center = center;
    }
    //马上显示下载进度
    [self.progressView setProgress:self.topic.picProgress animated:YES];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        NSLog(@"img%@------src%@",NSStringFromCGSize(self.imageView.size),NSStringFromCGSize(self.scrollView.contentSize));
    }];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError: contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
@end
