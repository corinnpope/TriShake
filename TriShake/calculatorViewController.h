//
//  calculatorViewController.h
//  TriShake
//
//  Created by Corinn Pope on 2/21/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface calculatorViewController : UIViewController {
    UISlider *swimSlider;
    UISlider *bikeSlider;
    UISlider *runSlider;
    UILabel *projectedFinishTime;
    UILabel *swimPaceLabel;
    UILabel *bikePaceLabel;
    UILabel *runPaceLabel;
}

@property (strong, nonatomic) IBOutlet UISlider *swimSlider;
@property (strong, nonatomic) IBOutlet UISlider *bikeSlider;
@property (strong, nonatomic) IBOutlet UISlider *runSlider;

@property (strong, nonatomic) IBOutlet UILabel *swimPaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *bikePaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *runPaceLabel;

@property (strong, nonatomic) IBOutlet UILabel *projectedFinishTime;

- (IBAction)swimSliderChanged:(id)sender;
- (IBAction)bikeSliderChanged:(id)sender;
- (IBAction)runSliderChanged:(id)sender;


- (void) changeSwimSlider:(id)sender;
- (void) changeBikeSlider:(id)sender;
- (void) changeRunSlider:(id)sender;
- (void) displayProjectedRaceTime;

@end
