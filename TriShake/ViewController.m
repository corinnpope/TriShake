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
//@synthesize adBanner;
//@synthesize bannerIsVisible;

- (void)viewDidLoad
{
    //shrink picker view
    //pickerView.transform = CGAffineTransformMakeScale(.8, 0.8);
    
    [super viewDidLoad];
    //self.adBanner.delegate=self;
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
//    adBanner.delegate=nil;
    [super viewDidUnload];
}
//#pragma mark ADBannerViewDelegate
//
//- (void)bannerViewDidLoadAd:(ADBannerView *)banner
//{
//    if (!bannerIsVisible)
//    {
//        NSLog(@"bannerViewDidLoadAd");
//        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
//        banner.frame = CGRectOffset(banner.frame, 0, -50);
////        buttonFrame.frame = CGRectOffset(buttonFrame.frame, 0, -50);
////        web.frame = CGRectMake(web.frame.origin.x,
////                               web.frame.origin.y,
////                               web.frame.size.width,
////                               web.frame.size.height-50);
//        [UIView commitAnimations];
//        bannerIsVisible = YES;
//    }
//}
//- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
//{
//    if (bannerIsVisible)
//    {
//        NSLog(@"bannerView:didFailToReceiveAdWithError:");
//        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
//        // assumes the banner view is at the top of the screen.
//        banner.frame = CGRectOffset(banner.frame, 0, 50);
////        buttonFrame.frame = CGRectOffset(buttonFrame.frame, 0, 50);
////        web.frame = CGRectMake(web.frame.origin.x,
////                               web.frame.origin.y,
////                               web.frame.size.width,
////                               web.frame.size.height+50);
//        [UIView commitAnimations];
//        bannerIsVisible = NO;
//    }
//}



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