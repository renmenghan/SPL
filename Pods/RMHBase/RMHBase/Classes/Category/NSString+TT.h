//
//  NSString+TT.h
//  RMHBase_Example
//
//  Created by 任梦晗 on 2016/2/23.
//  Copyright © 2016年 renmenghan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TT)

/**
 *  对字符串进行 urlencode
 *
 *  @return urlencode 后的字符串
 */
- (NSString *)urlencode;

/**
 *  对字符串进行 urldecode
 *
 *  @return urldecode 后的字符串
 */
- (NSString *)urldecode;

/**
 *  计算字符串的 MD5
 *
 *  @return MD5
 */
- (NSString *)md5;

/**
 *  去除字符串中的空格、回车等
 *
 *  @return
 */
- (NSString *)trim;

/**
 *  计算文本Size
 *
 *  @param font
 *  @param width
 *
 *  @return
 */
- (CGSize)sizeWithUIFont:(UIFont *)font forWidth:(CGFloat)width;

/**
 *  计算文本Size sizeWithUIFont实际上是调用了该方法
 *
 *  @param attribute
 *  @param width
 *
 *  @return
 */
- (CGSize)sizeWithUIAttribute:(NSDictionary *)attribute forWidth:(CGFloat)width;

/**
 *  汉字的拼音
 *
 *  @return 拼音
 */
- (NSString *)pinyin;
@end
