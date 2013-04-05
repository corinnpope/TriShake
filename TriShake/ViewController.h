//
//  ViewController.h
//  TriShake
//
//  Created by Corinn Pope on 1/28/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <iAd/iAd.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <Accounts/Accounts.h>

@class MyWorkoutList;

@interface ViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,ADBannerViewDelegate,MFMailComposeViewControllerDelegate, UITextViewDelegate>
{
    ADBannerView *adView;
    BOOL bannerIsVisible;
    NSMutableArray *workouts;
    sqlite3 *db;
    int i;
    
}

@property(nonatomic,retain) NSMutableArray *workouts;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic )NSMutableArray *rowOneItems;
@property (strong, nonatomic )NSMutableArray *rowTwoItems;
@property (strong, nonatomic )NSMutableArray *rowThreeItems;
@property (strong, nonatomic) IBOutlet UILabel *workoutTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *workoutDifficultyLabel;
@property (strong, nonatomic) IBOutlet UILabel *workoutDurationLabel;
@property (strong, nonatomic) IBOutlet UITextView *workoutDescriptionLabel;


@property (nonatomic, assign) NSString *typeSQL;
@property (nonatomic, assign) NSString *difficultySQL;
@property (nonatomic, assign) NSString *durationSQL;
@property (nonatomic, assign) BOOL bannerIsVisible;
@property (strong, nonatomic) IBOutlet UIButton *tweetButtonOutlet;
@property (strong, nonatomic) IBOutlet UIButton *mailButtonOutlet;
@property (strong, nonatomic) IBOutlet UIButton *facebookButtonOutlet;

- (IBAction)mailButton:(id)sender;
- (IBAction)tweetButton:(id)sender;
- (IBAction)findWorkout:(id)sender;
- (IBAction)facebookButton:(id)sender;


@end
