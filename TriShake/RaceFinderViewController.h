//
//  RaceFinderViewController.h
//  TriShake
//
//  Created by Corinn Pope on 3/21/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>



@interface RaceFinderViewController : UIViewController  {
    IBOutlet UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
    ADBannerView *adView;
    BOOL bannerIsVisible;
}

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign) BOOL bannerIsVisible;


@end
