//
//  AnchorModel.h
//  DFishTV
//
//  Created by 张海勇 on 2017/6/26.
//  Copyright © 2017年 张海勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnchorModel : NSObject

//房间号
@property (nonatomic,strong)NSString *room_id;
//房间对应的图片
@property (nonatomic,strong)NSString *room_src;
/// 判断是手机直播还是电脑直播
// 0 : 电脑直播 1 : 手机直播
@property (nonatomic,strong)NSString *isVertical;
//房间名称
@property (nonatomic,strong)NSString *room_name;
//主播昵称
@property (nonatomic,strong)NSString *nickname;
//在线观看人数
@property (nonatomic,strong)NSString *online;
//所在城市
@property (nonatomic,strong)NSString *anchor_city;
@end
