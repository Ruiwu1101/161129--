//
//  WLTopicViewController.h
//  161129-不得姐
//
//  Created by wl on 2016/12/10.
//  Copyright © 2016年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    WLTopicTypeAll = 1,
    WLTopicTypeVideo = 41,
    WLTopicTypeVoice = 31,
    WLTopicTypePicture = 10,
    WLTopicTypeWord = 29
    
}WLTopicType;

@interface WLTopicViewController : UITableViewController

//帖子的类型
@property (nonatomic,assign) WLTopicType type;
@end
