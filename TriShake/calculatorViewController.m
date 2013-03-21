//
//  calculatorViewController.m
//  TriShake
//
//  Created by Corinn Pope on 2/21/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import "calculatorViewController.h"

@interface calculatorViewController () 

@end

@implementation calculatorViewController {
    double sprintSwimPace;
    double olySwimPace;
    double halfSwimPace;
    double fullSwimPace;
    double sprintBikePace;
    double olyBikePace;
    double halfBikePace;
    double fullBikePace;
    double sprintRunPace;
    double olyRunPace;
    double halfRunPace;
    double fullRunPace;
    double t1Pace;
    double t2Pace;
    double projectedSprintTime;
    double projectedOlyTime;
    double projectedHalfTime;
    double projectedFullTime;
}

@synthesize swimSlider, bikeSlider, runSlider, t1Slider, t2Slider;
@synthesize swimPaceLabel, bikePaceLabel, runPaceLabel, t1PaceLabel, t2PaceLabel;
@synthesize projectedFinishTime, olyFinishTime, halfFinishTime, fullFinishTime;

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

    //set default values for calculator so sliders have something to work with when button is pressed

    swimSlider.value=2.0;
    bikeSlider.value=20;
    runSlider.value = 8;
    t1Slider.value = 3.0;
    t2Slider.value = 3.0;

    [swimSlider sendActionsForControlEvents:UIControlEventValueChanged];
    [bikeSlider sendActionsForControlEvents:UIControlEventValueChanged];
     [runSlider sendActionsForControlEvents:UIControlEventValueChanged];
     [t1Slider sendActionsForControlEvents:UIControlEventValueChanged];
     [t2Slider sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Math!

- (IBAction)swimSliderChanged:(id)sender {
    //convert from min/100m to sec/m
    double swimMS = self.swimSlider.value * 60;
    double swimPaceDouble = (swimMS / 100);
    
    //do distance for race here
    double swimSprint = swimPaceDouble * 750;
    double swimOly = swimPaceDouble * 1500;
    double swimHalf = swimPaceDouble * 1900;
    double swimFull = swimPaceDouble * 3800;
  
    sprintSwimPace = swimSprint;
    olySwimPace = swimOly;
    halfSwimPace = swimHalf;
    fullSwimPace = swimFull;

    //change label to hh:mm:ss format
    NSTimeInterval intervalValue = self.swimSlider.value * 60;
    NSDateFormatter *hmsFormatter = [[NSDateFormatter alloc] init];
    [hmsFormatter setDateFormat:@"HH:mm:ss"];
    [hmsFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSLog(@"formatted date: %@", [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]]);
    swimPaceLabel.text = [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]];
    
    [swimSlider addTarget:self action:@selector(swimSliderChanged:)forControlEvents:UIControlEventValueChanged];
    
    NSLog(@"Swim pace double is :%g", swimPaceDouble);
    
}

- (IBAction)bikeSliderChanged:(id)sender {
    
    //convert mph to m/s for bike
    double bikeMS = self.bikeSlider.value * .44;
    //do distance for race here
    double bikePaceDouble = (20000 / bikeMS);
    double bikePaceOly = (40000/bikeMS);
    double bikePaceHalf = (90000/bikeMS);
    double bikePaceFull = (180000/bikeMS);
    
    sprintBikePace = bikePaceDouble;
    olyBikePace = bikePaceOly;
    halfBikePace = bikePaceHalf;
    fullBikePace = bikePaceFull;
    
    bikePaceLabel.text = [[NSString alloc] initWithFormat:@"%1.2f",(self.bikeSlider.value)];
    
    [bikeSlider addTarget:self action:@selector(bikeSliderChanged:)forControlEvents:UIControlEventValueChanged];
    
    NSLog(@"Bike pace double is :%f", sprintBikePace);
}

- (IBAction)runSliderChanged:(id)sender {
    //convert min/mil to s/m
    double runMS = self.runSlider.value * 0.037;
    
    //do distance here
    double runPaceDouble = (runMS * 5000);
    double runPaceOly = (runMS * 10000);
    double runPaceHalf = (runMS * 21100);
    double runPaceFull = (runMS * 42200);
    
    sprintRunPace = runPaceDouble;
    olyRunPace = runPaceOly;
    halfRunPace = runPaceHalf;
    fullRunPace = runPaceFull;

    //moved from after set label
    [runSlider addTarget:self action:@selector(runSliderChanged:)forControlEvents:UIControlEventValueChanged];
    
    //change label to hh:mm:ss format
    NSTimeInterval intervalValue = self.runSlider.value * 60;
    NSDateFormatter *hmsFormatter = [[NSDateFormatter alloc] init];
    [hmsFormatter setDateFormat:@"HH:mm:ss"];
    [hmsFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSLog(@"formatted date: %@", [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]]);
    runPaceLabel.text = [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]];
    

    
    NSLog(@"Run pace double is :%g", sprintRunPace);
}

- (IBAction)t1SliderChanged:(id)sender {
    //convert minutes per transition to seconds per transition
    double t1PaceConversion = self.t1Slider.value * 60;
    t1Pace = t1PaceConversion;
    
    //change label to hh:mm:ss format
    NSTimeInterval intervalValue = t1Pace;
    NSDateFormatter *hmsFormatter = [[NSDateFormatter alloc] init];
    [hmsFormatter setDateFormat:@"HH:mm:ss"];
    [hmsFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSLog(@"formatted date: %@", [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]]);
    t1PaceLabel.text = [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]];
    
    NSLog (@"t1 pace is: %f", t1Pace);
}

- (IBAction)t2SliderChanged:(id)sender {
    //convert minutes per transition to seconds per transition
    double t2PaceConversion = self.t2Slider.value * 60;
    t2Pace = t2PaceConversion;
    
        //change label to hh:mm:ss format
    NSTimeInterval intervalValue = t2Pace;
    NSDateFormatter *hmsFormatter = [[NSDateFormatter alloc] init];
    [hmsFormatter setDateFormat:@"HH:mm:ss"];
    [hmsFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSLog(@"formatted date: %@", [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]]);
    
    t2PaceLabel.text = [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]];
    
    NSLog (@"t2 pace is: %f", t2Pace);
}

- (IBAction)changeTime:(id)sender {
    projectedSprintTime = (sprintRunPace + sprintBikePace + sprintSwimPace + t1Pace + t2Pace);
    projectedOlyTime = (olyRunPace + olyBikePace + olySwimPace + t1Pace + t2Pace);
    projectedHalfTime = (halfRunPace + halfBikePace + halfSwimPace + t1Pace + t2Pace);
    projectedFullTime = (fullRunPace + fullBikePace + fullSwimPace + t1Pace + t2Pace);
    
    
    
    NSTimeInterval sprintValue = projectedSprintTime;
    NSTimeInterval olyValue = projectedOlyTime;
    NSTimeInterval halfValue = projectedHalfTime;
    NSTimeInterval fullValue = projectedFullTime;
    NSDateFormatter *hmsFormatter = [[NSDateFormatter alloc] init];
    [hmsFormatter setDateFormat:@"HH:mm:ss"];
    [hmsFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSLog(@"formatted date: %@", [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:sprintValue]]);
    
    self.projectedFinishTime.text = [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:sprintValue]];
    self.olyFinishTime.text = [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:olyValue]];
    self.halfFinishTime.text = [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:halfValue]];
    self.fullFinishTime.text = [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:fullValue]];
    
}

@end
