//
//  calculatorViewController.h
//  TriShake
//
//  Created by Corinn Pope on 2/21/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface calculatorViewController : UIViewController {
    UISegmentedControl *raceSegmentedControl;
}

@property (strong, nonatomic) IBOutlet UISlider *swimSlider;
@property (strong, nonatomic) IBOutlet UISlider *bikeSlider;
@property (strong, nonatomic) IBOutlet UISlider *runSlider;

@property (strong, nonatomic) IBOutlet UILabel *swimPaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *bikePaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *runPaceLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *raceSegmentedControl;

@property (strong, nonatomic) IBOutlet UILabel *projectedFinishTime;

- (IBAction)swimPace:(id)sender;
- (IBAction)bikePace:(id)sender;
- (IBAction)runPace:(id)sender;
- (IBAction)transitionPace:(id)sender;

- (IBAction)raceChanged:(id)sender;
- (IBAction)transitionChanged:(id)sender;

@end
