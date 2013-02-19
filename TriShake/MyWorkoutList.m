//
//  MyWorkoutList.m
//  TriShake
//
//  Created by Corinn Pope on 1/28/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import "MyWorkoutList.h"
#import "workoutList.h"
#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ViewController.h"


#define kTypeComponent 0
#define kDifficultyComponent 1
#define kDurationComponent 2


@implementation MyWorkoutList


//@synthesize typeSQL = _typeSQL;
//@synthesize difficultySQL = _difficultySQL;
//@synthesize durationSQL = _durationSQL;
@synthesize pickerView;



//-(NSString *)typeSQL
//{
//    _typeSQL = [[NSString alloc] init];
//    NSInteger rowOne = [pickerView selectedRowInComponent:kTypeComponent];
//    _typeSQL = [rowOneItems objectAtIndex:rowOne];
//    return _typeSQL;
//    NSLog(@"type is: %@", _typeSQL);
//}
//-(NSString *)difficultySQL
//{
//    _typeSQL = [[NSString alloc] init];
//    NSInteger rowOne = [pickerView selectedRowInComponent:kTypeComponent];
//    _typeSQL = [rowOneItems objectAtIndex:rowOne];
//    return _typeSQL;
//}
//-(NSString *)durationSQL
//{
//    _durationSQL = [[NSString alloc] init];
//    NSInteger rowThree = [pickerView selectedRowInComponent:kDurationComponent];
//    _durationSQL = [rowThreeItems objectAtIndex:rowThree];
//    return _durationSQL;
//}

- (NSMutableArray *) getMyWorkout{
    //sqlite3 *db;
    
    NSMutableArray *workoutArray = [[NSMutableArray alloc] init];
    @try {
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"workoutList.sqlite"];
        
        NSLog(@"Db path is %@",dbPath);
        BOOL success = [fileMgr fileExistsAtPath:dbPath];        
        if(!success){
          NSLog(@"Cannot locate database file '%@'.", dbPath);
        }
        
        if
        (!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
        NSLog(@"error with message '%s'.", sqlite3_errmsg(db));

        //using this sql statement for now because its the only one I can get to work
        const char *sql = "SELECT workoutId, type, difficulty, duration, description FROM workoutTbl";
        
        ///////////////
        sqlite3_stmt *sqlStatement;
        
        if (sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK) {
        NSLog(@"%s Prepare failure '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(db), sqlite3_errcode(db));
        }
        
        //...
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
           
        workoutList *MyWorkout = [[workoutList alloc]init];
        MyWorkout.workoutId = sqlite3_column_int(sqlStatement, 0);
        MyWorkout.type = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
        MyWorkout.difficulty = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)];
        MyWorkout.duration = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
        MyWorkout.description = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 4)];
        [workoutArray addObject:MyWorkout];
       }
        sqlite3_finalize(sqlStatement);
    }
    @catch (NSException *exception) {
       NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        sqlite3_close(db);
        return workoutArray;
    }
}


# pragma mark - New functions -
- (NSArray *)getWorkoutListwithType:(NSString *)workoutType withDifficulty:(NSString *)difficulty withLength:(NSString *)length {
    NSMutableArray *workouts;
    @try {
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"workoutList.sqlite"];
        //        NSLog(@"Db path is %@",dbPath);
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        
        if (!success){
            NSLog(@"Cannot locate database file '%@'.", dbPath);
        }
        
        if (!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK)) {
            NSLog(@"error with message '%s'.", sqlite3_errmsg(db));
        }
        
        //        MLIU 2013-02-18: only alloc/init the array if the SQL database opens properly
        workouts = [[NSMutableArray alloc] init];
        sqlite3_stmt *sqlStatement;
        
        //        MLIU 2013-02-18: i added "%%" as a wildcard so the query will say "difficulty LIKE '>30%' and match >30 MINS, >30 HOURS, etc.
        NSString *sqlString = [NSString stringWithFormat: @"SELECT description FROM workoutTbl WHERE type LIKE '%@%%' AND difficulty LIKE '%@%%' AND duration LIKE '%@%%'", workoutType, difficulty, length];
        NSLog(@"query: %@", sqlString);
        
        const char *sql = [sqlString UTF8String];
        
        //////////////
        
        if (sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK) {
            NSLog(@"%s Prepare failure '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(db), sqlite3_errcode(db));
        }
        
        //...
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            [workouts addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)]];
        }
        sqlite3_finalize(sqlStatement);
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        sqlite3_close(db);
    }
    
    //    MLIU 2013-02-18: pass back an immutable copy of the array. if the array is nil, then the database never opened and there will be an error
    return [workouts copy];
}

@end