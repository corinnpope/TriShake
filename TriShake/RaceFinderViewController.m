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
    
    
    adView = [[ADBannerView alloc] initWithFrame: CGRectZero];
    adView.frame = CGRectOffset(adView.frame, 0, -50);
    [self.view addSubview:adView];
    adView.delegate=self;
    self.bannerIsVisible = NO;
    
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

#pragma iAd Setup

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (!(self.bannerIsVisible))
    {
        [UIView beginAnimations:@"animateAdBanerOn" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    if (self.bannerIsVisible) {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}

@end
