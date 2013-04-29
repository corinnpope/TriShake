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
    NSMutableArray *checkedCells;
    NSIndexPath *selectedIndexPath;

}

@property (nonatomic, retain) NSMutableArray *checkedCells;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property(nonatomic, retain) NSIndexPath *checkedData;



@end
