//
//  YTURLRewrite.m
//  YTURLRewrite
//
//  Created by brant on 2017/8/3.
//  Copyright © 2017年 瘦不拉机. All rights reserved.
//

#import "YTURLRewrite.h"
#import "RewriteRule.h"

@interface YTURLRewrite ()

@property (nonatomic, strong) NSMutableArray *rules;

@end

@implementation YTURLRewrite

+ (YTURLRewrite *)shareInstance {
    static dispatch_once_t onceToken;
    static YTURLRewrite *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self initRules];
    }
    return self;
}

// 初始化规则串，暂放在本地 这个方法里面的东西都是字符串，可以通过接口下发
- (void)initRules {
    // 商品详情  http://m.jxsg.com/product/234.html
    RewriteRule *rule = [RewriteRule new];
    
    rule.pattern = @"^(?:https?:)\\/\\/www.youku.(com|test)$";
    
    rule.targetUrl = [NSString stringWithFormat:@"这个是优酷的链接"];
    rule.flag = @"";
    [self.rules addObject:rule];
    
    RewriteRule *rule2 = [RewriteRule new];
    
    rule2.pattern = @"^(?:https?:)\\/\\/www.baidu.(com|test)$";
    
    rule2.targetUrl = [NSString stringWithFormat:@"这个是解析到的参数，这里的文字可以换成你的URLScheme路由：$1"];
    rule2.flag = @"";
    [self.rules addObject:rule2];
    
}


/**
 重写url

 @param url 要重写的url
 @return 返回重写后的url
 */
- (NSString *)rewriteUrl:(NSString *)url {
    
    for (RewriteRule *rule in self.rules) {
        NSArray *array = [YTURLRewrite matchString:url toRegexString:rule.pattern];
        if (array.count > 0) {
            // 匹配到了
            return [rule targetUrlWithParams:array url:url];
        }
    }
    
    return url;
}

/**
 *  正则匹配返回符合要求的字符串 数组
 *
 *  @param string   需要匹配的字符串
 *  @param regexStr 正则表达式
 *
 *  @return 符合要求的字符串 数组 (按(),分级,正常0)
 */
+ (NSArray *)matchString:(NSString *)string toRegexString:(NSString *)regexStr {
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray * matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSTextCheckingResult *match in matches) {
        
        for (int i = 0; i < [match numberOfRanges]; i++) {
            //以正则中的(),划分成不同的匹配部分
            //            if ( [match rangeAtIndex:i].location < string.length) {
            NSString *component = [string substringWithRange:[match rangeAtIndex:i]];
            
            [array addObject:component];
            //            }
            
            
        }
        
    }
    
    return array;
}

#pragma mark - lazy load

- (NSMutableArray *)rules {
    if (!_rules) {
        _rules = [[NSMutableArray alloc] init];
    }
    
    return _rules;
}

@end
