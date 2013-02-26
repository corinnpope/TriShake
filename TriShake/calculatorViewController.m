//
//  calculatorViewController.m
//  TriShake
//
//  Created by Corinn Pope on 2/21/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import "calculatorViewController.h"

@interface calculatorViewController () {

}

@end

@implementation calculatorViewController {
    double swimPace;
    double bikePace;
    double runPace;
    double t1Pace;
    double t2Pace;
    double projectedRaceTime;
}

@synthesize swimSlider, bikeSlider, runSlider, t1Slider, t2Slider;
@synthesize swimPaceLabel, bikePaceLabel, runPaceLabel, t1PaceLabel, t2PaceLabel;
@synthesize projectedFinishTime;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Math!

- (IBAction)swimSliderChanged:(id)sender {
    //set text label to value of slider
    swimPaceLabel.text = [[NSString alloc] initWithFormat:@"%1.2f",self.swimSlider.value];
  
    //get seconds to meters
    double swimMS = self.swimSlider.value * 60;
    double swimPaceDouble = (swimMS / 100);
    double swimSprint = swimPaceDouble * 750;
    //
    //do distance for races here
    //
  
    swimPace = swimSprint;
    
//    NSString *swimPaceString = [NSString stringWithFormat:@"%f", swimPaceDouble];
//    NSLog(@"Swim pace string is: %@", swimPaceString);
    NSLog(@"Swim pace double is :%f", swimSprint);
    
}

- (IBAction)bikeSliderChanged:(id)sender {
    //bike pace to user is mph
    bikePaceLabel.text = [[NSString alloc] initWithFormat:@"%1.2f",(self.bikeSlider.value)];
    
    //convert mph to m/s for bike
    double bikeMS = self.bikeSlider.value * .44;
    //do distance for race here
    double bikePaceDouble = (20000 / bikeMS);
    
    bikePace = bikePaceDouble;
    
    NSLog(@"Bike pace double is :%f", bikePace);
}

- (IBAction)runSliderChanged:(id)sender {
    //run pace to user is min per mile
    runPaceLabel.text = [[NSString alloc] initWithFormat:@"%1.2f",self.runSlider.value];
    
    //convert min/mil to m/s
    double runMS = self.runSlider.value * 0.037;
    
    //convert m/s to hours using runDistance from selected segment in segmentcontroller
    double runPaceDouble = (runMS * 5000);
    runPace = runPaceDouble;

    NSLog(@"Run pace double is :%g", runPace);
}

- (IBAction)t1SliderChanged:(id)sender {
    t1PaceLabel.text = [[NSString alloc] initWithFormat:@"%1.2f", self.t1Slider.value];
    double t1PaceConversion = self.t1Slider.value * 60;
    t1Pace = t1PaceConversion;
    NSLog (@"t1 pace is: %f", t1Pace);
}

- (IBAction)t2SliderChanged:(id)sender {
    t2PaceLabel.text = [[NSString alloc] initWithFormat:@"%1.2f", self.t2Slider.value];
    double t2PaceConversion = self.t2Slider.value * 60;
    t2Pace = t2PaceConversion;
    NSLog (@"t2 pace is: %f", t2Pace);
}

- (IBAction)changeTime:(id)sender {
    projectedRaceTime = (runPace + bikePace + swimPace + t1Pace + t2Pace)/60;
    NSString *projectedFinishTime = [NSString stringWithFormat:@"%1.2f", projectedRaceTime];
    self.projectedFinishTime.text = projectedFinishTime;
}

@end
