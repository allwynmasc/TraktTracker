//
//  RWViewController.m
//  ShowTracker
//
//  Created by Joshua on 3/1/14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import "ViewController.h"
#import "TraktAPIClient.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TraktAPIClient *client = [TraktAPIClient sharedClient];
    
    [client getShowsForDate:[NSDate date]
                   username:@"rwtestuser"
               numberOfDays:3
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                        NSLog(@"Success -- %@", responseObject);
                    }
                    failure:^(NSURLSessionDataTask *task, NSError *error) {
                        NSLog(@"Failure -- %@", error);
                    }];
}

#pragma mark - Actions

- (IBAction)pageChanged:(id)sender
{
    
}

@end
