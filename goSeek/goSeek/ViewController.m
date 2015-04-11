//
//  ViewController.m
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import "ViewController.h"
#import "EventSource.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"Hello World!");
    
    NSURL *serverURL = [NSURL URLWithString:@"http://localhost:5000/polo"];
    EventSource *source = [EventSource eventSourceWithURL:serverURL];
    [source addEventListener:@"COUNTDOWN" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
