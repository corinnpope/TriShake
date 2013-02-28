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
    //convert from min/100m to sec/m
    double swimMS = self.swimSlider.value * 60;
    double swimPaceDouble = (swimMS / 100);
    
    //do distance for race here
    double swimSprint = swimPaceDouble * 750;
  
    swimPace = swimSprint;

    //change label to hh:mm:ss format
    NSTimeInterval intervalValue = swimMS;
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
    
    bikePace = bikePaceDouble;
    
    bikePaceLabel.text = [[NSString alloc] initWithFormat:@"%1.2f",(self.bikeSlider.value)];
    
    [bikeSlider addTarget:self action:@selector(bikeSliderChanged:)forControlEvents:UIControlEventValueChanged];
    
    NSLog(@"Bike pace double is :%f", bikePace);
}

- (IBAction)runSliderChanged:(id)sender {
    //convert min/mil to s/m
    double runMS = self.runSlider.value * 0.037;
    
    //do distance here
    double runPaceDouble = (runMS * 5000);
    runPace = runPaceDouble;

    //change label to hh:mm:ss format
    NSTimeInterval intervalValue = self.runSlider.value * 60;
    NSDateFormatter *hmsFormatter = [[NSDateFormatter alloc] init];
    [hmsFormatter setDateFormat:@"HH:mm:ss"];
    [hmsFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSLog(@"formatted date: %@", [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]]);
    runPaceLabel.text = [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]];
    
    [runSlider addTarget:self action:@selector(runSliderChanged:)forControlEvents:UIControlEventValueChanged];
    
    NSLog(@"Run pace double is :%g", runPace);
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
    projectedRaceTime = (runPace + bikePace + swimPace + t1Pace + t2Pace);
    
    NSTimeInterval intervalValue = projectedRaceTime;
    NSDateFormatter *hmsFormatter = [[NSDateFormatter alloc] init];
    [hmsFormatter setDateFormat:@"HH:mm:ss"];
    [hmsFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSLog(@"formatted date: %@", [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]]);
    
    self.projectedFinishTime.text = [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]];
    
    
}

@end
