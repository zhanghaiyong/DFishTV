//
//  AnchorGroup.h
//  DFishTV
//
//  Created by 张海勇 on 2017/6/26.
//  Copyright © 2017年 张海勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
#import "AnchorModel.h"
@interface AnchorGroup : NSObject<MJKeyValue>
// 组显示的标题
@property (nonatomic,strong)NSString *tag_name;
// 组显示的图标
@property (nonatomic,strong)NSString *icon_name;
// 游戏对应的图标
@property (nonatomic,strong)NSString *icon_url;
// 定义主播的模型对象数组
@property (nonatomic,strong)NSArray  *anchors;

@property (nonatomic,strong)NSArray  *room_list;

@end
