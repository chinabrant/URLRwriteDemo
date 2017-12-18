//
//  ViewController.m
//  URLRewriteDemo
//
//  Created by brant on 2017/12/18.
//  Copyright © 2017年 Brant. All rights reserved.
//

#import "ViewController.h"
#import "YTURLRewrite.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (nonatomic, copy) NSString *urlString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)normalClick:(id)sender {
    self.resultLabel.text = [NSString stringWithFormat:@"结果：%@", [[YTURLRewrite shareInstance] rewriteUrl:@"http://www.youku.com"]];
}

- (IBAction)rewriteClick:(id)sender {
    // 关键看懂怎么拿到URL里面的参数的。(通过正则里面的括号)
    self.resultLabel.text = [NSString stringWithFormat:@"结果：%@", [[YTURLRewrite shareInstance] rewriteUrl:self.urlString]];
}


#pragma mark - lazy load
- (NSString *)urlString {
    if (!_urlString) {
        _urlString = @"http://www.baidu.com";
    }
    
    return _urlString;
}

@end
