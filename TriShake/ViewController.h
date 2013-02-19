//
//  ViewController.h
//  TriShake
//
//  Created by Corinn Pope on 1/28/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class MyWorkoutList;

@interface ViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *workouts;
    sqlite3 *db;

    
}

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


//@property (strong,nonatomic) MyWorkoutList *secondClass;


- (IBAction)findWorkout:(id)sender;


@end
