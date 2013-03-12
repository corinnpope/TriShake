//
//  checklistTableViewController.h
//  TriShake
//
//  Created by Corinn Pope on 3/4/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface checklistTableViewController : UITableViewController {
    NSMutableArray *sectionArray;
    NSIndexPath *checkedIndexPath;
}


@property (nonatomic, readonly) NSInteger numberOfSections;
@property (nonatomic, retain) NSMutableArray *tableData;
@property (nonatomic, retain) NSIndexPath *checkedIndexPath;

- (NSString *) itemNameAtIndexPath: (NSIndexPath *) path;
- (NSInteger) countInSection: (NSInteger) section;
- (NSString *) nameForSection: (NSInteger) section;


@end
