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
    EventSource *sourceCountDown = [EventSource eventSourceWithURL:serverURL];
    [sourceCountDown addEventListener:@"COUNTDOWN" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
    }];
    
    EventSource *sourceMarco = [EventSource eventSourceWithURL:serverURL];
    [sourceMarco addEventListener:@"MARCO" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
    }];
    
    EventSource *sourceClose = [EventSource eventSourceWithURL:serverURL];
    [sourceClose addEventListener:@"CLOSE" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
    }];
    
    
    // Request Roomcode
    NSURLRequest *requestRoomCode = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:5000/roomcode"]];
    
    NSURLConnection *connRoomCode = [[NSURLConnection alloc] initWithRequest:requestRoomCode delegate:self];
    
    // Request Marco
    NSURLRequest *requestMarco = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:5000/marco"]];
    
    NSURLConnection *connMarco = [[NSURLConnection alloc] initWithRequest:requestMarco delegate:self];
    
    // Request CountDown
    NSURLRequest *requestCountDown = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:5000/countdown"]];
    
    NSURLConnection *connCountDown = [[NSURLConnection alloc] initWithRequest:requestCountDown delegate:self];
    
    // Request Close
    NSURLRequest *requestClose = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:5000/close"]];
    
    NSURLConnection *connClose = [[NSURLConnection alloc] initWithRequest:requestClose delegate:self];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSString* temp = [json objectForKey:@"roomcode"];
    if (temp != nil){
        _roomcode = temp;
        NSLog(_roomcode);
    }
    NSLog(@"did recieve data\n");
    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //NSLog(@"loading finished\n");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"connection failed\n");
}

@end
