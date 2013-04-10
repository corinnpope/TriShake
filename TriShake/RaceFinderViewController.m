//
//  RaceFinderViewController.m
//  TriShake
//
//  Created by Corinn Pope on 3/21/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import "RaceFinderViewController.h"

@interface RaceFinderViewController ()

@end

@implementation RaceFinderViewController

@synthesize webView, activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad {
    //set up activity indicator for when page is loading
    activityIndicator = [[UIActivityIndicatorView alloc] init];
	activityIndicator.hidesWhenStopped = YES;
	[self.activityIndicator startAnimating];
    
    [super viewDidLoad];
    [self loadView];
}


- (void)viewWillAppear:(BOOL)animated   {
    
    //set up web page load
    NSString *urlAddress = @"http://m.usatriathlon.org/events/sanctioned-event-calendar.aspx";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObject = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObject];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	// starting the load, show the activity indicator in the status bar
    activityIndicator.hidden = FALSE;
    [activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	// finished loading, hide the activity indicator in the status bar
    activityIndicator.hidden = TRUE;
	[activityIndicator stopAnimating];
}




@end
