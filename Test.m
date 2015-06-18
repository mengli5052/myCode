//
//  Test.m
//  15041065Z_JaDe
//
//  Created by qianfeng on 15/4/30.
//  Copyright (c) 2015年 郑军铎. All rights reserved.
//

#import "Test.h"

@implementation Test
/*
 1. 判断中间目录是否存在 (10分)
 比如 传入字符串 @"/home/qianfeng/oc.txt" 和 @"qianfeng" 返回:YES
 传入字符串 @"/usr/qianfeng/oc.txt 和 @"fengqian" 返回:NO
 */
- (BOOL)isPath:(NSString*)path includeMiddleDirectory:(NSString*)dir {
    NSArray* arr = [path componentsSeparatedByString:@"/"];
    for (NSInteger i = 1; i < arr.count - 1; i++) {
        if ([dir isEqualToString:arr[i]]) {
            return YES;
        }
    }
    return NO;
}

/*
 2.将一个字符串数组中的元素组合成一个合法路径（10分）
 已知一个数组存放的是目录名字，要求组合成一个合法路径
 比如:数组中存放的是 home qianfeng iOS
 返回  /home/qiangfeng/iOS
 */
- (NSString*)joinPathOfComponents:(NSArray*)comp {
    NSString* str = @"";
    for (NSString* s in comp) {
        str = [str stringByAppendingFormat:@"/%@", s];
    }
    return str;
}

/*3.
 传入一段字符串，字符串中可能有任何字符，要求找出字符串中最长的单词，即最长的连续英语字母，返回该单词的字母个数(20分)
 
 比如：
 输入 Yes, I hate the guy who make this fucking examination paper!
 返回：11 即examination的长度。
 */
- (NSUInteger)numbersOfLongestWordInString:(NSString*)s {
    for (NSInteger i = 0; i < s.length; i++) {
        unichar ch = [s characterAtIndex:i];
        if (!(isalpha(ch))) {
            s = [s stringByReplacingCharactersInRange:NSMakeRange(i, 1)
                                           withString:@" "];
        }
    }
    NSArray* arr = [s componentsSeparatedByString:@" "];
    //    NSMutableArray* newArr = [arr mutableCopy];
    //    [newArr removeObject:@""];
    NSUInteger max = 0;
    for (NSString* str in arr) {
        if (str.length > max) {
            max = str.length;
        }
    }
    return max;
}

/*
 4.输入左边数字就输出右边对应字母 (20分)
 
 1 - A
 2 - B
 …..
 26 - Z
 27 - AA
 52 - AZ
 53 - BA
 54 - BB
 ….
 702 - ZZ
 …
 8888888888-ABTCNCWV
 输入左边数字就输出右边对应字母；
 */
- (void)printEnglish:(NSInteger)n {
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    while (n > 0) {
        n--;
        NSNumber* num = [NSNumber numberWithInteger:n % 26];
        [arr addObject:num];
        n /= 26;
    }
    NSMutableString* str = [[NSMutableString alloc] init];
    for (NSInteger i = arr.count - 1; i >= 0; i--) {
        NSInteger j = [arr[i] integerValue];
        [str appendFormat:@"%c", (char)('A' + j)];
    }
    NSLog(@"%@", str);
}
//接上题要求输入右侧的字符串打印左侧的数字
- (void)printNumberFromString:(NSString*)str {
    NSInteger num = 0;
    for (NSInteger i = 0; i < str.length; i++) {
        unichar c = [str characterAtIndex:i];
        num = num * 26 + (int)(c - 'A' + 1);
    }
    NSLog(@"%li", num);
}

/*
 5.将字符串中单词后移(10分)
 已知字符串中的单词以空格隔开，将字符串向右移动指定单词数，首尾循环
 
 如:string传入@"Hi man welcome to qianfeng", bits传入2
 
 返回:@"to qianfeng Hi man welcome"
 */
+ (NSString*)displacemetWordInString:(NSString*)string
                             forBits:(NSUInteger)bits {
    NSArray* arr = [string componentsSeparatedByString:@" "];
    NSString* str = @"";
    NSInteger len = arr.count;
    bits = bits % len;
    bits = len - bits;
    for (NSInteger i = 0; i < len; i++) {
        str = [str stringByAppendingFormat:@"%@ ", arr[bits]];
        bits = (bits + 1) % len;
    }
    return str;
}

/*
 6.找出出现最多的单词 (10分)
 已知字符串中的单词以空格隔开，找出字符串中出现次数最多的单词，将该单词和单词出现的次数
 拼接成一个新字符串，返回新字符串。
 
 传入:@"drink your drink don't drink others drink"
 
 返回:@"drink4"
 */
- (NSString*)mostWordInString:(NSString*)String {
    NSArray* arr = [String componentsSeparatedByString:@" "];
    NSMutableDictionary* dir = [[NSMutableDictionary alloc] init];
    for (NSString* str in arr) {
        if ([dir valueForKey:str] == nil) {
            [dir setValue:@1 forKey:str];
        } else {
            NSInteger i = [[dir valueForKey:str] integerValue];
            NSNumber* n = [NSNumber numberWithInteger:i + 1];
            [dir setValue:n forKey:str];
        }
    }
    NSInteger max = 0;
    NSString* key_max = nil;
    for (NSString* key in dir) {
        NSInteger i = [[dir valueForKey:key] integerValue];
        if (i > max) {
            max = i;
            key_max = key;
        }
    }
    return [NSString stringWithFormat:@"%@%li", key_max, max];
}

/*
 7.打印杨辉三角(10分)
 输入 7
 1
 1 1
 1 2  1
 1 3  3  1
 1 4  6  4  1
 1 5 10 10  5 1
 1 6 15 20 15 6 1
 NSLog打印
 
 */

- (void)printYangHuiTriangle:(int)n {
    NSInteger arr[n][n];
    arr[0][0] = 1;
    NSMutableString* str =
    [[NSMutableString alloc] initWithFormat:@"\n%2li\n", arr[0][0]];
    for (NSInteger i = 1; i < n; i++) {
        arr[i][0] = 1;
        [str appendFormat:@"%2li ", arr[i][0]];
        for (NSInteger j = 1; j < i; j++) {
            arr[i][j] = arr[i - 1][j - 1] + arr[i - 1][j];
            [str appendFormat:@"%2li ", arr[i][j]];
        }
        arr[i][i] = 1;
        [str appendFormat:@"% li\n", arr[i][i]];
    }
    NSLog(@"%@", str);
}

/*
 8 传入一段字符串，把相同的字符按出现顺序，归在一起，并压缩(20分)
 
 比如：
 
 输入 SamSameCome
 
 输出：
 
 S2a2m3e2C1o1
 
 返回值为压缩后的结果,比如S2a2m3e2C1o1
 */
- (NSString*)compressString:(NSString*)s {
    NSMutableArray* char_arr = [[NSMutableArray alloc] init];  //字符数组
    NSMutableArray* int_arr = [[NSMutableArray alloc] init];   //计数器数组
    for (NSInteger i = 0; i < s.length; i++) {
        unichar c = [s characterAtIndex:i];
        NSString* str = [NSString stringWithFormat:@"%c", c];
        if ([char_arr containsObject:str]) {
            //获取字符下标
            NSUInteger n = [char_arr indexOfObject:str];
            //获取计数器数组下标为n的计数器
            NSUInteger count = [int_arr[n] integerValue];
            //计数器+1后再次存入计数器数组下标为n的位置
            int_arr[n] = @(count + 1);
        } else {
            [char_arr addObject:str];
            [int_arr addObject:@1];
        }
    }
    NSString* string = @"";
    for (NSInteger i = 0; i < int_arr.count; i++) {
        string = [string stringByAppendingFormat:@"%@%@", char_arr[i], int_arr[i]];
    }
    return string;
}

/*
 9 根据输入的内容用NSLog打印出菱形(10分)
 */
// count 表示正方形边长

// flagString 组成菱形的边

// blankString 组成背景正方形

//比如 [class print:5 blankString:@“+”flagString:@“#”];
/*
 + + # + +
 
 + # + # +
 
 # + + + #
 
 + # + # +
 
 + + # + +
 */

- (void)print:(NSInteger)count
  blankString:(NSString*)blankString
   flagString:(NSString*)flagString {
    NSString* str = @"\n";
    for (NSInteger i = 0; i < count; i++) {
        for (NSInteger j = 0; j < count; j++) {
            if (((i + j) % (count - 1) == count / 2) ||
                (count / 2 == (abs((int)(i - j))))) {
                str = [str stringByAppendingFormat:@" %@", flagString];
            } else {
                str = [str stringByAppendingFormat:@" %@", blankString];
            }
        }
        str = [str stringByAppendingString:@"\n"];
    }
    NSLog(@"%@", str);
}
/*
 10. 求一个字符串s的最大连续递减数字子串。(20)
 
 比如：
 输入 12345986fffwf3210abcd 输出为 3210
 输入 abcd765bbw135797531f12345 输出为 765
 
 //如果有多个相同的最大数字串那么返回最后一个
 */
- (NSString*)subNumberString:(NSString*)string {
    NSString* str = @"";
    for (NSInteger i = 0; i < string.length; i++) {
        unichar ch = [string characterAtIndex:i];
        if (isdigit(ch)) {
            NSInteger r = i;
            NSInteger count = 1;
            while (++i < string.length) {
                unichar temp = [string characterAtIndex:i];
                if ((isdigit(temp)) && (ch - temp) == 1) {
                    ch = temp;
                    count++;
                } else {
                    NSRange range = NSMakeRange(r, count);
                    NSString* str1 = [string substringWithRange:range];
                    if (str1.length >= str.length) {
                        str = str1;
                    }
                    break;
                }
            }
        } else {
            continue;
        }
    }
    return str;
}

+ (void)test {
    Test* test = [[Test alloc] init];
    NSLog(@"------第1题------");
    NSLog(@"%i",
          [test isPath:@"/home/qianfeng/oc.txt" includeMiddleDirectory:@"home"]);
    NSLog(@"------第2题------");
    NSArray *arr = [NSArray arrayWithObjects:@"home",@"qianfeng",@"iOS", nil];
    NSLog(@"%@",[test joinPathOfComponents:arr]);
    NSLog(@"------第3题------");
    NSLog(@"%lu",(unsigned long)[test numbersOfLongestWordInString:@"Yes, I hate the guy who make this fucking examination paper!"]);
    NSLog(@"------第4题------");
    [test printEnglish:27];
    [test printNumberFromString:@"ABTCNCWV"];
    NSLog(@"------第5题------");
    NSLog(@"%@",[Test displacemetWordInString:@"Hi man welcome to qianfeng" forBits:7]);
    NSLog(@"------第6题------");
    NSLog(@"%@",[test mostWordInString:@"drink your drink don't drink others drink"]);
    NSLog(@"------第7题------");
    [test printYangHuiTriangle:7];
    NSLog(@"------第8题------");
    NSLog(@"%@",[test compressString:@"SamSameCome"]);
    NSLog(@"------第9题------");
    [test print:7 blankString:@"+" flagString:@"#"];
    NSLog(@"------第10题------");
    NSLog(@"%@",[test subNumberString:@"12345986fffwf43210/bcd"]);
}

@end