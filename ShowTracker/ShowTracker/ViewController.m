//
//  RWViewController.m
//  ShowTracker
//
//  Created by Joshua on 3/1/14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import "ViewController.h"
#import "TraktAPIClient.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import <Nimbus/NIAttributedLabel.h>
#import <SAMCategories/UIScreen+SAMAdditions.h>

@interface ViewController ()

@property (nonatomic, strong) NSArray *jsonResponse;
@property (nonatomic) BOOL pageControlUsed;
@property (nonatomic) NSInteger previousPage;

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.previousPage = -1;
    
    TraktAPIClient *client = [TraktAPIClient sharedClient];
    
    [client getShowsForDate:[NSDate date]
                   username:@"rwtestuser"
               numberOfDays:3
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                        // Save response object
                        self.jsonResponse = responseObject;
                        
                        // Get the number of shows
                        NSInteger shows = 0;
                        for (NSDictionary *day in self.jsonResponse)
                            shows += [day[@"episodes"] count];
                        
                        // Set up page control
                        self.showsPageControl.numberOfPages = shows;
                        self.showsPageControl.currentPage = 0;
                        
                        // Set up scroll view
                        self.showsScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * shows, CGRectGetHeight(self.showsScrollView.frame));
                        
                        // Load first show
                        [self loadShow:0];
                    }
                    failure:^(NSURLSessionDataTask *task, NSError *error) {
                        NSLog(@"Failure -- %@", error);
                    }];
}

#pragma mark - Actions

- (IBAction)pageChanged:(id)sender
{
    
}

- (void)loadShow:(NSInteger)index
{
    // 1 - Find the show for the given index
    NSDictionary *show = nil;
    NSInteger shows = 0;
    
    for (NSDictionary *day in self.jsonResponse) {
        NSInteger count = [day[@"episodes"] count];
        
        // 2 - Did you find the right show?
        if (index < shows + count) {
            show = day[@"episodes"][index - shows];
            break;
        }
        
        // 3 - Increment the shows counter
        shows += count;
    }
    
    // 4 - Load the show information
    NSDictionary *showDict = show[@"show"];
    
    // 5 - Display the show title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(index * CGRectGetWidth(self.showsScrollView.bounds) + 20, 40, CGRectGetWidth(self.showsScrollView.bounds) - 40, 40)];
    titleLabel.text = showDict[@"title"];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // 6 - Add to scroll view
    [self.showsScrollView addSubview:titleLabel];
}

@end







