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

@class MyWorkoutList;

@interface ViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>
{
    IBOutlet ADBannerView *adBanner;
    NSMutableArray *workouts;
    sqlite3 *db;
    
}
//2/14 add gloabl SQL NSStrings
@property(nonatomic,retain) NSMutableArray *workouts;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic )NSMutableArray *rowOneItems;
@property (strong, nonatomic )NSMutableArray *rowTwoItems;
@property (strong, nonatomic )NSMutableArray *rowThreeItems;
@property (strong, nonatomic) IBOutlet UILabel *workoutTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *workoutDifficultyLabel;
@property (strong, nonatomic) IBOutlet UILabel *workoutDurationLabel;
@property (strong, nonatomic) IBOutlet UILabel *workoutDescriptionLabel;
@property (nonatomic, assign) NSString *typeSQL;
@property (nonatomic, assign) NSString *difficultySQL;
@property (nonatomic, assign) NSString *durationSQL;
//@property (nonatomic, assign) BOOL bannerIsVisible;
//@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;



- (IBAction)findWorkout:(id)sender;


@end
