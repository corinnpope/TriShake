//
//  ViewController.m
//  TriShake
//
//  Created by Corinn Pope on 1/28/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import "ViewController.h"
#import "MyWorkoutList.h"
#import <Twitter/Twitter.h>
#define letOSHandleLogin FALSE

#define kTypeComponent 0
#define kDifficultyComponent 1
#define kDurationComponent 2
#define NO_WORKOUTS_FOUND_MESSAGE @"Sorry, no workouts were found for these options."


@interface ViewController (){
    NSMutableArray *rowOneItems;
    NSMutableArray *rowTwoItems;
    NSMutableArray *rowThreeItems;
    
}

@end

@implementation ViewController
@synthesize pickerView;
@synthesize rowOneItems;
@synthesize rowTwoItems;
@synthesize rowThreeItems;
@synthesize workoutTypeLabel;
@synthesize workouts;
@synthesize workoutDurationLabel;
@synthesize workoutDifficultyLabel;
@synthesize workoutDescriptionLabel;
@synthesize typeSQL;
@synthesize difficultySQL;
@synthesize durationSQL;
@synthesize bannerIsVisible;

- (void)viewDidLoad
{
    
    //set up iAd at top of frame
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    adView.frame = CGRectOffset(adView.frame, 0, -50);
    [adView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:adView];
    adView.delegate=self;
    self.bannerIsVisible=NO;

    [super viewDidLoad];
    
    
    //offset pickerview for iAds
    pickerView.frame = CGRectOffset(pickerView.frame, 0, -50);
    pickerView.transform = CGAffineTransformMakeScale(.8, .8);
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.opaque = NO;
    workoutDescriptionLabel.delegate = self;
    
    //set up arrays
    
    rowOneItems = [[NSMutableArray alloc] initWithObjects:@"Bike",@"Run",@"Swim",nil];
    rowTwoItems = [[NSMutableArray alloc] initWithObjects:@"Easy",@"Medium",@"Hard",nil];
    rowThreeItems = [[NSMutableArray alloc] initWithObjects:@"<30 mins", @"30-60 mins", @">60 mins", nil];
    
    //load button images from disk
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        UIImage *twitterIcon = [UIImage imageWithContentsOfFile:@"twitter-bird-white-on-blue.png"];
        UIImage *facebookIcon =[UIImage imageWithContentsOfFile:@"facebook.png"];
        UIImage *mailIcon =[UIImage imageWithContentsOfFile:@"mail_icon.png"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tweetButtonOutlet setBackgroundImage:twitterIcon forState:UIControlStateNormal];
            [self.facebookButtonOutlet setBackgroundImage:facebookIcon forState:UIControlStateNormal];
            [self.mailButtonOutlet setBackgroundImage:mailIcon forState:UIControlStateNormal];
        });
        
    });
}

- (void)viewDidUnload
{
    [self setPickerView:nil];
    [self setWorkoutTypeLabel:nil];
    [self setWorkoutDifficultyLabel:nil];
    [self setWorkoutDurationLabel:nil];
    adView.delegate=nil;
    [super viewDidUnload];
}
#pragma mark ADBannerViewDelegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // banner is invisible now and moved out of the screen on 50 px
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // banner is visible and we move it out of the screen, due to connection issue
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"Banner view is beginning an ad action");
    BOOL shouldExecuteAction = YES;
    if (!willLeave && shouldExecuteAction)
    {
        // stop all interactive processes in the app
    }
    return shouldExecuteAction;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    // resume everything you've stopped
}

#pragma mark - Picker Methods -
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
    
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 1) 
        return [self.rowTwoItems count];
        else if (component == 2)
            return [self.rowThreeItems count];
        else
            return [self.rowOneItems count];
    }
    
    
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 1)
        return[rowTwoItems objectAtIndex:row];
    else if(component == 2)
        return [rowThreeItems objectAtIndex:row];
    else
        return [rowOneItems objectAtIndex:row];
}


# pragma Share/Social Buttons
- (IBAction)mailButton:(id)sender {
    MFMailComposeViewController *mailComposer;
    mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setSubject:@"My Workout from TriAlly"];
    NSString *chosenWorkout = self.workoutDescriptionLabel.text;
    [mailComposer setMessageBody:[NSString stringWithFormat: @"My workout for today: %@  #triAlly", chosenWorkout] isHTML:NO];
    [self presentViewController:mailComposer animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tweetButton:(id)sender {

    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        NSString *chosenWorkout = self.workoutDescriptionLabel.text;
        //shorten workout to 140 characters for twitter
        chosenWorkout = [chosenWorkout substringToIndex:MIN(114, [chosenWorkout length])];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"Today's workout: %@ #TriAlly", chosenWorkout]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                      message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
            [alertView show];
        }
}

- (IBAction)facebookButton:(id)sender {
    
    //Check if facebook is linked
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) 
    {
        SLComposeViewController *facebookSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        //set facebook message
        NSString *chosenWorkout = self.workoutDescriptionLabel.text;
        [facebookSheet setInitialText:[NSString stringWithFormat:@"My workout for today: %@  #TriAlly", chosenWorkout]];
        //dismiss facebook sheet
        [self presentViewController:facebookSheet animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                            message:@"It looks like you can't connect to Facebook right now, make sure your device has an internet connection and you have at least one Facebook account setup under settings"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}


# pragma Find Workout Button
- (IBAction)findWorkout:(id)sender {
    //set labels to show what the user picked
    
    NSInteger rowOne = [pickerView selectedRowInComponent:kTypeComponent];
    self.typeSQL = [rowOneItems objectAtIndex:rowOne];
    self.workoutTypeLabel.text = typeSQL;
   
    NSInteger rowTwo = [pickerView selectedRowInComponent:kDifficultyComponent];
    self.difficultySQL = [rowTwoItems objectAtIndex:rowTwo];
    self.workoutDifficultyLabel.text = [rowTwoItems objectAtIndex:rowTwo];
    
    NSInteger rowThree = [pickerView selectedRowInComponent:kDurationComponent];
    self.durationSQL = [rowThreeItems objectAtIndex:rowThree];
    self.workoutDurationLabel.text = [rowThreeItems objectAtIndex:rowThree];

    
    // MLIU 2013-02-18: prepare a new list of workouts
    MyWorkoutList *workoutData = [[MyWorkoutList alloc] init];
    NSArray *workout = [workoutData getWorkoutListwithType:self.typeSQL withDifficulty:self.difficultySQL withLength:[self convertDurationToSQLValue:self.durationSQL]];

//set up button to act as a next button when pressed again
    
    if ((i+1) > workout.count) {
        i = 0;
    }
    self.workoutDescriptionLabel.text = [workout objectAtIndex:i];
    i++;
}

- (NSString *)convertDurationToSQLValue:(NSString *)input {
    // MLIU 2013-02-18: the picker says "## mins" but the database only has the "##" part
    return [[input componentsSeparatedByString:@" mins"] objectAtIndex:0];
}


@end