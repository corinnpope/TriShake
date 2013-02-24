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
    double projectedRaceTime;
}

@synthesize swimSlider, bikeSlider, runSlider;
@synthesize swimPaceLabel, bikePaceLabel, runPaceLabel;
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

- (void) displayProjectedRaceTime {
    //NSNumber *projectedRaceTime = [NSNumber numberWithDouble:(swimPaceDouble + bikePaceDouble + runPaceDouble)];
    
    //NSString *projectedFinishTime = [NSString stringWithFormat:@"%g", projectedRaceTime];
    //self.projectedFinishTime.text = projectedFinishTime;
}


- (IBAction)swimSliderChanged:(id)sender {
    //set text label to value of slider
    swimPaceLabel.text = [[NSString alloc] initWithFormat:@"%1.2f",self.swimSlider.value];
  
    
    double swimMS = self.swimSlider.value * 1.667;
    double swimPaceDouble = (swimMS * 750)/3600;
    NSString *swimPaceString = [NSString stringWithFormat:@"%f", swimPaceDouble];
    swimPace = swimPaceDouble;
    NSLog(@"Swim pace string is: %@", swimPaceString);
    NSLog(@"Swim pace double is :%f", swimPaceDouble);
    
}

- (IBAction)bikeSliderChanged:(id)sender {
    //bike pace to user is mph
    bikePaceLabel.text = [[NSString alloc] initWithFormat:@"%1.2f",(self.bikeSlider.value)];
    
    //convert mph to m/s for bike
    double bikeMS = self.bikeSlider.value * .447;
    double bikePaceDouble = (bikeMS * 20000) / 3600;
    bikePace = bikePaceDouble;
    NSString *bikePaceString = [NSString stringWithFormat:@"%f", bikePaceDouble];
    NSLog(@"%@", bikePaceString);
    NSLog(@"Bike pace double is :%f", bikePaceDouble);
}

- (IBAction)runSliderChanged:(id)sender {
    //    //run pace to user is min per mile
    runPaceLabel.text = [[NSString alloc] initWithFormat:@"%1.2f",self.runSlider.value];
    
    //convert min/mil to m/s
    double runMS = self.runSlider.value * 26.82;
    //convert m/s to hours using runDistance from selected segment in segmentcontroller
    double runPaceDouble = (runMS * 5000)/3600;
    runPace = runPaceDouble;
    NSString *runPaceString = [NSString stringWithFormat:@"%f", runPaceDouble];
    NSLog (@"%@", runPaceString);
    NSLog(@"Run pace double is :%f", runPaceDouble);
}

- (IBAction)changeTime:(id)sender {
    projectedRaceTime = runPace + bikePace + swimPace;
    NSString *projectedFinishTime = [NSString stringWithFormat:@"%g", projectedRaceTime];
    self.projectedFinishTime.text = projectedFinishTime;

}

@end
