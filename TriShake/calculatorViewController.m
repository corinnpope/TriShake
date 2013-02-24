//
//  calculatorViewController.m
//  TriShake
//
//  Created by Corinn Pope on 2/21/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import "calculatorViewController.h"

@interface calculatorViewController () {
    double runPaceDouble;
    double bikePaceDouble;
    double swimPaceDouble;
    double projectedRaceTime;
}

@end

@implementation calculatorViewController 

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
//    [swimSlider addTarget:self action:@selector(changeSwimSlider:) forControlEvents:UIControlEventValueChanged];
//    [bikeSlider addTarget:self action:@selector(changeBikeSlider:) forControlEvents:UIControlEventValueChanged];
//    [runSlider addTarget:self action:@selector(changeRunSlider:) forControlEvents:UIControlEventValueChanged];
//    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Math!

- (void) displayProjectedRaceTime {
    double projectedRaceTime = (swimPaceDouble + bikePaceDouble + runPaceDouble);
    NSString *projectedFinishTime = [NSString stringWithFormat:@"%g", projectedRaceTime];
    self.projectedFinishTime.text = projectedFinishTime;
}


- (IBAction)swimSliderChanged:(id)sender {
    NSString *swimPaceText = [[NSString alloc] initWithFormat:@"%1.2f",self.swimSlider.value];
    swimPaceLabel.text = swimPaceText;
    
    double swimMS = self.swimSlider.value * 1.667;
    double swimPaceDouble = (swimMS * 750)/3600;
    NSString *swimPaceString = [NSString stringWithFormat:@"%f", swimPaceDouble];
    NSLog(@"Swim pace string is: %@", swimPaceString);
    NSLog(@"Swim pace double is :%f", swimPaceDouble);
}

- (IBAction)bikeSliderChanged:(id)sender {
    //bike pace to user is mph
    NSString *bikePaceText = [[NSString alloc] initWithFormat:@"%1.2f",(self.bikeSlider.value)];
    bikePaceLabel.text = bikePaceText;
    
    //convert mph to m/s for bike
    double bikeMS = self.bikeSlider.value * .447;
    double bikePaceDouble = (bikeMS * 20000) / 3600;
    NSString *bikePaceString = [NSString stringWithFormat:@"%f", bikePaceDouble];
    NSLog(@"%@", bikePaceString);
    NSLog(@"Bike pace double is :%f", bikePaceDouble);
}

- (IBAction)runSliderChanged:(id)sender {
    //    //run pace to user is min per mile
    NSString *runPaceText = [[NSString alloc] initWithFormat:@"%1.2f",self.runSlider.value];
    runPaceLabel.text = runPaceText;
    
    //convert min/mil to m/s
    double runMS = self.runSlider.value * 26.82;
    //convert m/s to hours using runDistance from selected segment in segmentcontroller
    double runPaceDouble = (runMS * 5000)/3600;
    //NSString *runPaceString = [NSString stringWithFormat:@"%f", runPaceDouble];
    
    //NSLog (@"%@", runPaceString);
    NSLog(@"Run pace double is :%f", runPaceDouble);
}

@end
