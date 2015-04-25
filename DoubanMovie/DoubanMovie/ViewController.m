//
//  ViewController.m
//  DoubanMovie
//
//  Created by itugo on 15/4/24.
//  Copyright (c) 2015年 itugo. All rights reserved.
//

#import "ViewController.h"
#import "DBMovie.h"
#import "Mantle.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *getMovieButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *getMovieActivityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.getMovieActivityIndicator.hidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getMovieAction:(id)sender {
    self.getMovieButton.hidden = YES;
    self.getMovieActivityIndicator.hidden = NO;
    [self.getMovieActivityIndicator startAnimating];
    
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
        
        NSDictionary * jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:nil];
        
        DBMovie * movie = [MTLJSONAdapter modelOfClass:[DBMovie class] fromJSONDictionary:jsonDictionary error:nil];
        
#warning 在这边设置断点查看对象
        
        [[[UIAlertView alloc]initWithTitle:@"信息" message:@"获取成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        self.getMovieActivityIndicator.hidden = YES;
        [self.getMovieActivityIndicator stopAnimating];
        self.getMovieButton.hidden = NO;
    }];
    
}
@end
