//
//  MyWorkoutList.h
//  TriShake
//
//  Created by Corinn Pope on 1/28/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface MyWorkoutList : NSObject{
    sqlite3 *db;
    NSMutableArray *rowOneItems;
    NSMutableArray *rowTwoItems;
    NSMutableArray *rowThreeItems;
}

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;


// MLIU 2013-02-18: added this function to only get specific workouts.  I left the original one alone in case you still wanted to pull in the entire list of workouts somewhere else (e.g. building the UIPicker options from the database)
- (NSArray *)getWorkoutListwithType:(NSString *)workoutType withDifficulty:(NSString *)difficulty withLength:(NSString *)length;

@end
