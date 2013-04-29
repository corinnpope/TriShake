//
//  RaceFinderViewController.h
//  TriShake
//
//  Created by Corinn Pope on 3/21/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
@class Reachability;



@interface RaceFinderViewController : UIViewController  {
    IBOutlet UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
    ADBannerView *adView;
    BOOL bannerIsVisible;
}
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;
@property (strong, nonatomic) IBOutlet UIButton *refreshButton;

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign) BOOL bannerIsVisible;
- (IBAction)backButton:(id)sender;
- (IBAction)forwardButton:(id)sender;
- (IBAction)refreshButton:(id)sender;


@end
