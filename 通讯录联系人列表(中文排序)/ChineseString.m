//
//  ChineseString.m
//  通讯录联系人列表(中文排序)
//
//  Created by tian on 14-4-23.
//  Copyright (c) 2014年 tian. All rights reserved.
//

#import "ChineseString.h"
#import "pinyin/pinyin.h"
@implementation ChineseString

#pragma mark - 索引
+(NSMutableArray *)IndexArray:(NSArray *)stringArr{
    
    NSMutableArray *tempArray = [self returnSortChineseArray:stringArr];
    NSMutableArray *A_Result = [NSMutableArray array];
    NSString *tempString;
    //拼音分组
    for(id object in tempArray){
        NSString *pinyin = [((ChineseString *)object).pinYin substringToIndex:1];
        //找出不同并且添加到数组中去,剔除重复的首字母
        if (![tempString isEqualToString:pinyin]) {
            [A_Result addObject:pinyin];
            tempString = pinyin;
        }
    }
    
    return A_Result;
}
#pragma mark - 联系人
+(NSMutableArray *)LetterSortArray:(NSArray *)stringArr{
    
    NSMutableArray *tempArray = [self returnSortChineseArray:stringArr];
    NSMutableArray *letterResult = [NSMutableArray array];
    NSMutableArray *item = [NSMutableArray array];
    NSString *tempString;
    //拼音分组
    for (id objcet in tempArray) {
        NSString *pinYin = [((ChineseString *)objcet).pinYin substringToIndex:1];
        NSString *string = ((ChineseString *)objcet).string;
        //不同
        if (![tempString isEqualToString:pinYin]) {
            //  分组
            item = [NSMutableArray array];
            [item addObject:string];
            [letterResult addObject:item];
            //遍历
            tempString = pinYin;
        }
        //相同
        else{
            [item addObject:string];
        }
        
    }
    return letterResult;
}
#pragma mark - 过滤指定字符串   里面的指定字符根据自己的需要添加

+(NSString*)RemoveSpecialCharacter: (NSString *)str {

    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",？、 ~￥#&<>《》()[]{}【】^@/￡&curren;|&sect;&uml;「」『』￠￢￣~@#&*（）——+|《》$_€"]];

    if (urgentRange.location != NSNotFound)

    {
        return [self RemoveSpecialCharacter:[str stringByReplacingCharactersInRange:urgentRange withString:@""]];

    }
    return str;
}


#pragma mark -  返回排序好的字符及拼音
+(NSMutableArray *)returnSortChineseArray:(NSArray *)stringArr{
    
    //获取字符串中文字的拼音首字母并与字符串共同存放
    NSMutableArray *chineseStringArray = [NSMutableArray array];
    
    for (NSInteger i=0; i<stringArr.count; i++) {
        //每一个原本的字符串(英文/中文/字符)
        ChineseString *chineseString = [[ChineseString alloc]init];
        chineseString.string = [NSString stringWithString:stringArr[i]];
        if (chineseString.string == nil) {
            chineseString.string = @"";
        }
        //去除两端空格与回车
        chineseString.string = [chineseString.string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //递归过滤指定字符串   RemoveSpecialCharacter
        //chineseString.string =[ChineseString RemoveSpecialCharacter:chineseString.string];
        
        //判断首字符是否是字母
        NSString *regex = @"[A-Za-z]+.*$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",regex];
        if ([predicate evaluateWithObject:chineseString.string]) {
            //判断首字母不需要进行中文判断并转换为首字母大写
            chineseString.pinYin = [chineseString.string capitalizedString];
        }
        else{
            //判断为中文字进行中文字排序
            if (![chineseString.string isEqualToString:@""]) {
                NSString *pinYinResult = [NSString string];
                for(NSInteger j=0;j<chineseString.string.length;j++){
                    //返回中文所对应的拼音
                    NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                    pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
                }
                chineseString.pinYin = pinYinResult;
            }
            else{
            //判断为空
                chineseString.pinYin = @"";
            }
        }
        
        [chineseStringArray addObject:chineseString];
        
    }
    //按照拼音首字母对这些string进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES], nil];
    [chineseStringArray sortUsingDescriptors:sortDescriptors];
    
    return chineseStringArray;
}
@end
