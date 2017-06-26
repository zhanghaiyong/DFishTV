//
//  AnchorGroup.m
//  DFishTV
//
//  Created by 张海勇 on 2017/6/26.
//  Copyright © 2017年 张海勇. All rights reserved.
//

#import "AnchorGroup.h"

@implementation AnchorGroup
+ (NSDictionary *)mj_objectClassInArray {

    return  @{@"anchors":[AnchorModel class]};
}
@end
