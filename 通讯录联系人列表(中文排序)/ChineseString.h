//
//  ChineseString.h
//  通讯录联系人列表(中文排序)
//
//  Created by tian on 14-4-23.
//  Copyright (c) 2014年 tian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChineseString : NSObject

@property (nonatomic,retain) NSString *string;
@property (nonatomic,retain) NSString *pinYin;
//返回tableview 右边的indexArray;
+(NSMutableArray *)IndexArray:(NSArray *)stringArr;
//--- 返回联系人
+(NSMutableArray *)LetterSortArray:(NSArray *)stringArr;

@end
