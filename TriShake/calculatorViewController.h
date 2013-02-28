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
    UISlider *t1Slider;
    UISlider *t2Slider;
    
    UILabel *projectedFinishTime;
    
    UILabel *swimPaceLabel;
    UILabel *bikePaceLabel;
    UILabel *runPaceLabel;
    UILabel *t1PaceLabel;
    UILabel *t2PaceLabel;
}

@property (strong, nonatomic) IBOutlet UISlider *swimSlider;
@property (strong, nonatomic) IBOutlet UISlider *bikeSlider;
@property (strong, nonatomic) IBOutlet UISlider *runSlider;
@property (strong, nonatomic) IBOutlet UISlider *t1Slider;
@property (strong, nonatomic) IBOutlet UISlider *t2Slider;



@property (strong, nonatomic) IBOutlet UILabel *swimPaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *bikePaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *runPaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *t1PaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *t2PaceLabel;

@property (strong, nonatomic) IBOutlet UILabel *projectedFinishTime;

- (IBAction)swimSliderChanged:(id)sender;
- (IBAction)bikeSliderChanged:(id)sender;
- (IBAction)runSliderChanged:(id)sender;
- (IBAction)changeTime:(id)sender;
- (IBAction)t1SliderChanged:(id)sender;
- (IBAction)t2SliderChanged:(id)sender;


- (void) displayProjectedRaceTime;


@end
