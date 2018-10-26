//
//  Get4-9DifferentNumbers.m
//  iOS7Toutorials
//
//  Created by MBP on 14-7-2.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import "WGGetGestureSecrets.h"
#import <UIKit/UIKit.h>

@implementation WGGetGestureSecrets
struct WGCoord{
    int m,n;
};
typedef struct WGCoord WGCoord;

CG_INLINE WGCoord
WGCoordMake(int m, int n){
    //将m，n限定在有效范围内，范围视9宫格、16宫格大小而定，当前为9宫格的范围大小5*5
    if (m<0||m>2) {
        m = (int )NSNotFound;
    }
    if (n<0||n>2) {
        n = (int )NSNotFound;
    }
    WGCoord coord; coord.m = m;coord.n = n;
    return coord;
}

CG_INLINE int WGCoordValueMake(WGCoord coord){
    return numbers[coord.m * 3 + coord.n];
}

static int numbers[9] = {1,2,3,4,5,6,7,8,9};//九宫格数字

//当dx==2&&dy==2时，为self原点，不处理
static int dx[5][5]= {
    {-2,-2,-2,-2,-2},
    {-1,-1,-1,-1,-1},
    {0,0,0,0,0},
    {1,1,1,1,1},
    {2,2,2,2,2},
};

static int dy[5][5] = {
    {-2,-1,0,1,2},
    {-2,-1,0,1,2},
    {-2,-1,0,1,2},
    {-2,-1,0,1,2},
    {-2,-1,0,1,2}
};





 int min = 0;//密码最小最大长度
 int max = 0;


+ (id )getGestureSecretsByMinLength:(int)min_ MaxLength:(int)max_{
    
    min = min_;
    max = max_;
    
    //以1-9为组，存储这9组数据
    NSMutableArray *allSecrets = [NSMutableArray array];
    
    //9宫格遍历
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            NSArray *thisSecrets = [self calculateSecretFromCoord:WGCoordMake(i, j)];
            [allSecrets addObject:thisSecrets];
        }
    }

//    NSLog(@"%@",allSecrets);
    
    return allSecrets;
}

/**
 *  以index对应的value为密码第一位，开始计算所有符合条件的密码串
 *
 *  @param index numbers下标
 *
 *  @since v1.0
 */
+ (NSArray *)calculateSecretFromCoord:(WGCoord )coord{
    NSMutableArray *thisSecrets = [NSMutableArray array];
    
    NSString *startStr = [NSString stringWithFormat:@"%d",WGCoordValueMake(coord)];
    
    [self ergodicAllDirectionWithExistString:startStr
                                AndFromCoord:coord
                    QualifiedSecretContainer:thisSecrets];
    
    //排序
    [thisSecrets sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return ([(NSString *)obj1 length] > [(NSString *)obj2 length]);
    }];
    
    
    return thisSecrets;
}

/**
 *  遍历5*5-1个路径，寻求合格点
 *
 *  @param origin    原本已经遍历到的密码
 *  @param coord     末尾，或者起始点坐标
 *  @param container 有符合条件的密码的存储容器
 *
 *  @since v1.0
 */
+ (void)ergodicAllDirectionWithExistString:(NSString *)origin
                              AndFromCoord:(WGCoord )coord
                  QualifiedSecretContainer:(NSMutableArray *)container{
    
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            if (i==2&&j==2) {
                continue;
            }else{
                WGCoord nextCoord = WGCoordMake(coord.m+dx[i][j], coord.n+dy[i][j]);
                if (nextCoord.m==(int )NSNotFound || nextCoord.n==(int )NSNotFound) {
                    continue;
                }else{//范围符合条件
#pragma mark - 此处代码为9宫格手势密码所有排列，如果只需要4-9位数字，并且数字不重复的话，只需要把下面的if注释掉即可
                    //去掉 两点之间有第三点的情况
                    if ( (coord.m==nextCoord.m&&abs(coord.n-nextCoord.n)==2) ||
                        (coord.n==nextCoord.n&&abs(coord.m-nextCoord.m)==2) ) {
                        continue;
                    }
                    
                    NSString *nextSecret = [self checkStringDidHaveTheCoordValue:origin Coord:nextCoord];
                    if (nextSecret) {//如果存在，检测长度是否符合最大最小值
                        if (nextSecret.length<min) {//如果长度不足，遍历递归
                            [self ergodicAllDirectionWithExistString:nextSecret
                                                        AndFromCoord:nextCoord
                                            QualifiedSecretContainer:container];
                        }else if (nextSecret.length>max){
                            continue;
                        }
                        else{//符合长度，直接add进container
                            [container addObject:nextSecret];
                            
                            if (nextSecret.length<max) {
                                //若长度还未达到最大值，可以从此节点开始，另起一个递归操作，比如当前nextSecret。length==4，开始递归5长度的密码串，直到密码长度达到最大值，停止更长长度的密码递归
                                [self ergodicAllDirectionWithExistString:nextSecret
                                                            AndFromCoord:nextCoord
                                                QualifiedSecretContainer:container];
                            }
                            
                        }
                    }else{//未查询到符合条件的新密码
                        continue;
                    }
                }
            }
        }
    }
    
    
}


/**
 *  检测 原有字符串中，是否已包含coord对应的value的数字，不包含，扩展为新字符串返回，否则返回nil
 *
 *  @param str   原有密码字符串
 *  @param coord 下一个坐标点
 *
 *  @return 新密码
 *
 *  @since v1.0
 */
+ (NSString *)checkStringDidHaveTheCoordValue:(NSString *)str Coord:(WGCoord )coord{
    NSString *coordValueStr = [NSString stringWithFormat:@"%d",WGCoordValueMake(coord)];
    NSRange range = [str rangeOfString:coordValueStr];
    if (range.length==0) {
        return [str stringByAppendingString:coordValueStr];
    }
    return nil;
}



#pragma mark - 笨办法遍历所有不同数字 ，效率太低， 未处理2点之间存在第三点的情况
//- (void)startCalculateWithMinLength:(int )min_ MaxLength:(int )max_{
//    
//    //k表示当前密码长度
//    for (int k = min_; k <= max_; k++) {
//        NSMutableString *maxNumberStr = [NSMutableString string];
//        NSMutableString *minNumberStr = [NSMutableString string];
//        
//        int maxN = 9;
//        int minN = 1;
//        for (int m = k; m >0; m--) {
//            [maxNumberStr appendFormat:@"%d",maxN--];
//            [minNumberStr appendFormat:@"%d",minN++];
//        }
//        
//        ///
//        NSMutableArray *total = [NSMutableArray array];
//        
//        for (int i = maxNumberStr.intValue; i >=minNumberStr.intValue; i--) {
//            
//            
//            NSString *s = [NSString stringWithFormat:@"%d",i];
//            
//            if ([s rangeOfString:@"0"].length) {
//                continue;
//            }
//            
//            NSMutableArray *a1 = [NSMutableArray array];
//            NSMutableSet *s1 = [NSMutableSet set];
//            for (int j = 0; j < s.length; j++) {
//                id obj = [s substringWithRange:NSMakeRange(j, 1)       ];
//                [a1 addObject:obj];
//                [s1 addObject:obj];
//            }
//            
//            if (a1.count==s1.count) {
//                [total addObject:s];
//            }
//            
//        }
//        
//        NSLog(@"%d",total.count);
//        
//
//    }
//    
//
//}


@end
