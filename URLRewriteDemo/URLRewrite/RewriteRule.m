//
//  RewriteRule.m
//  YTURLRewrite
//
//  Created by brant on 2017/8/3.
//  Copyright © 2017年 瘦不拉机. All rights reserved.
//

#import "RewriteRule.h"

@implementation RewriteRule

- (NSString *)targetUrlWithParams:(NSArray *)params url:(NSString *)url {
    
    
    if ([self.flag isEqualToString:@"a"]) {
        // 添加
        return [NSString stringWithFormat:@"%@%@", url, self.targetUrl];
    }
    else if ([self.flag isEqualToString:@"k"]) {
        // 保留原url
        return url;
    }
    else if ([self.flag isEqualToString:@"s"]) {
        // 例如，新人专享
        url = [url stringByReplacingOccurrencesOfString:@"file://" withString:@""];
        return [NSString stringWithFormat:@"%@&url=%@", self.targetUrl, url];
    }
    
    NSString *target = self.targetUrl;
    
    // 将参数替换成从url中解析出来的参数
    for (int i = 0; i < params.count; i++) {
        NSString *para = params[i];
        para = [para stringByRemovingPercentEncoding];
        target = [target stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"$%d", i] withString:para];
    }
    
    if ([self.flag isEqualToString:@"b"]) {
        target = [NSString stringWithFormat:@"%@&urlString=%@", target, url];
    }
    
    return target;
}

@end
