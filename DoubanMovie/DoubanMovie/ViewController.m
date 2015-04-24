//
//  ViewController.m
//  DoubanMovie
//
//  Created by itugo on 15/4/24.
//  Copyright (c) 2015年 itugo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getMovieAction:(id)sender {
    
    [self getMovie];
    
}

- (void)getMovie  {
    
    NSURL * url = [NSURL URLWithString:@"https://api.douban.com/v2/movie/4212172"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"error:%@", connectionError);
            return;
        }
        
        NSLog(@"data is :%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    
}
@end
