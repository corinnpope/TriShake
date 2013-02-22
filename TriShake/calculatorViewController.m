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


@implementation calculatorViewController

@synthesize swimSlider, bikeSlider, runSlider;
@synthesize swimPaceLabel, bikePaceLabel, runPaceLabel;
@synthesize raceSegmentedControl;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Math!


- (IBAction)swimPace:(id)sender {
    
    //swim pace to user is min-100m
    NSString *swimPaceText = [[NSString alloc] initWithFormat:@"%1.2f",self.swimSlider.value];
    swimPaceLabel.text = swimPaceText;
    
    double swimMS = self.swimSlider.value * 1.667;
    double swimPace = (swimMS * raceSegmentedControl.selectedSegmentIndex)/3600;
    NSLog(@"%f", swimPace);
    
}


- (IBAction)bikePace:(id)sender {
    //bike pace to user is mph
    NSString *bikePaceText = [[NSString alloc] initWithFormat:@"%1.2f",(self.bikeSlider.value)];
    bikePaceLabel.text = bikePaceText;
    
    //convert mph to m/s for bike
    double bikeMS = self.bikeSlider.value * .447;
    double bikePace = (bikeMS * raceSegmentedControl.selectedSegmentIndex) / 3600;
    NSLog(@"%f", bikePace);
    
}


- (IBAction)runPace:(id)sender {
    //run pace to user is min per mile
    NSString *runPaceText = [[NSString alloc] initWithFormat:@"%1.2f",self.runSlider.value];
    runPaceLabel.text = runPaceText;
    
    //convert min/mil to m/s
    double runMS = self.runSlider.value * 26.82;
    //convert m/s to hours using runDistance from selected segment in segmentcontroller
//double runPace = (runMS * self.raceSegmentedControl.selectedSegmentIndex.runDistance)/3600;
    
    //NSLog (@"%f", runPace);
}


- (IBAction)transitionPace:(id)sender {
}
- (IBAction)transitionChanged:(id)sender {
}


- (IBAction)raceChanged:(id)sender {
    

    float *swimDistance;
    float *bikeDistance;
    float *runDistance;
    
     if (self.raceSegmentedControl.selectedSegmentIndex ==0) {
         //[raceSegmentedControl titleForSegmentAtIndex:raceSegmentedControl.selectedSegmentIndex];
            swimDistance = 750;
            bikeDistance = 20000;
            runDistance = 5000;
     }
    
     if (self.raceSegmentedControl.selectedSegmentIndex ==1) {
            swimDistance = 1500;
            bikeDistance = 40000;
            runDistance = 10000;
     }
            
     if (self.raceSegmentedControl.selectedSegmentIndex ==2) {
            swimDistance= 1900;
            bikeDistance = 90000;
            runDistance = 21100;
     }
    
     if (self.raceSegmentedControl.selectedSegmentIndex ==3) {
            swimDistance = 3800;
            bikeDistance = 180000;
            runDistance = 42200;
     }
}


@end
