//
//  ViewController.m
//  TriShake
//
//  Created by Corinn Pope on 1/28/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import "ViewController.h"
#import "MyWorkoutList.h"

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
    //set up iAd
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    [adView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    CGRect adFrame = adView.frame;
    adFrame.origin.y = self.view.frame.size.height-adView.frame.size.height;
    adView.frame = adFrame;
    [self.view addSubview:adView];
    
    [super viewDidLoad];
    
    //set up Picker View
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.opaque = NO;

    //set up arrays
    
    rowOneItems = [[NSMutableArray alloc] initWithObjects:@"Bike",@"Run",@"Swim",nil];
    rowTwoItems = [[NSMutableArray alloc] initWithObjects:@"Easy",@"Medium",@"Hard",nil];
    rowThreeItems = [[NSMutableArray alloc] initWithObjects:@"<30 mins", @"30-60 mins", @">60 mins", nil];
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

    // MLIU 2013-02-18: handle 0 matching results
    if ([workout count] > 0) {
        // show the first matching workout - swap in code for multiple matches here
        self.workoutDescriptionLabel.text = [workout objectAtIndex:0];
    } else {
        self.workoutDescriptionLabel.text = NO_WORKOUTS_FOUND_MESSAGE;
    }
}

- (NSString *)convertDurationToSQLValue:(NSString *)input {
    // MLIU 2013-02-18: the picker says "## mins" but the database only has the "##" part
    return [[input componentsSeparatedByString:@" mins"] objectAtIndex:0];
}


@end