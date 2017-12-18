//
//  RewriteRule.h
//  YTURLRewrite
//
//  Created by brant on 2017/8/3.
//  Copyright © 2017年 瘦不拉机. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RewriteRule : NSObject

// 用来匹配的原始URL的正则串
@property (nonatomic, copy) NSString *pattern;

// 转换后的目标串 参数占位用 $0, $1 这样
// 这里是一个标准的前端路由
@property (nonatomic, copy) NSString *targetUrl;

// 标记位
// 值一：k： 保留原url，不做重写
// 值二：s: 在targetUrl后面加一个url为传来的url的参数
// 值三：b: 解析参数，同时在参数里面添加一个urlString 为传来的url
@property (nonatomic, copy) NSString *flag;

// 返回重写后的url
- (NSString *)targetUrlWithParams:(NSArray *)params url:(NSString *)url;

@end
