//
//  YTURLRewrite.h
//  YTURLRewrite
//
//  Created by brant on 2017/8/3.
//  Copyright © 2017年 瘦不拉机. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTURLRewrite : NSObject

+ (YTURLRewrite *)shareInstance;

/**
 重写url
 
 @param url 要重写的url
 @return 返回重写后的url
 */
- (NSString *)rewriteUrl:(NSString *)url;

@end
