//
//  checklistTableViewController.h
//  TriShake
//
//  Created by Corinn Pope on 3/4/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface checklistTableViewController : UITableViewController{
    NSMutableArray *sectionArray;
    NSMutableArray *checkedCells;
    NSIndexPath *selectedIndexPath;
    int selectedRow;
    int selectedSection;
}


@property (nonatomic, readonly) NSInteger numberOfSections;
@property (nonatomic, retain) NSMutableArray *tableData;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;


- (NSString *) itemNameAtIndexPath: (NSIndexPath *) path;
- (NSInteger) countInSection: (NSInteger) section;
- (NSString *) nameForSection: (NSInteger) section;



@end
