
//copyright corinn pope


#import "ViewController.h"
@interface ViewController (){
    NSMutableArray *rowOneItems;
    NSMutableArray *rowTwoItems;
    NSMutableArray *rowThreeItems;
}
@end
@implementation ViewController
@synthesize pickerView;
@synthesize rowOneItems;
@synthesize rowTwoItems;
@synthesize rowThreeItems;
@synthesize workoutResults;

- (void)viewDidLoad
{
    [super viewDidLoad];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.opaque = NO;
    
    rowOneItems = [[NSMutableArray alloc] initWithObjects:@"Bike",@"Run",@"Swim",nil];
    rowTwoItems = [[NSMutableArray alloc] initWithObjects:@"Easy",@"Medium",@"Hard",nil];
    rowThreeItems = [[NSMutableArray alloc] initWithObjects:@"<30 mins", @"30-60 mins", @">60 mins", nil];
    
}
- (void)viewDidUnload
{
    [self setPickerView:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark - Picker Methods -
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 1) 
        return [self.rowTwoItems count];
        else if (component == 2)
            return [self.rowThreeItems count];
        else
            return [self.rowOneItems count];
    }
    //or use this
    //return rowOneItems.count;
    //return rowTwoItems.count;
   // return rowThreeItems.count;
//}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 1)
        return[rowTwoItems objectAtIndex:row];
    else if(component == 2)
        return [rowThreeItems objectAtIndex:row];
    else
        return [rowOneItems objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
	   inComponent:(NSInteger)component {
    NSLog(@"Selected Leg: %@",[rowOneItems objectAtIndex:row]);
    NSLog(@"Selected Difficulty: %@",[rowTwoItems objectAtIndex:row]);
    NSLog(@"Selected Time: %@",[rowThreeItems objectAtIndex:row]);
    
    
    
    NSString *chosenCombo = [[NSString alloc] initWithFormat:@"Selected Leg: %@ Selected Difficulty: %@ Selected Time: %@", rowOneItems, rowTwoItems, rowTwoItems];
    self.workoutResults.text = chosenCombo;
    
    //ViewController *initialView;
  //  initialView=(ViewController *)self.delegate;
    
//    if (component==kAnimalComponent) {
  //      int chosenSound=[pickerView selectedRowInComponent:kSoundComponent];
    //    [initialView displayAnimal:[self.animalNames objectAtIndex:row]
      //                   withSound:[self.animalSounds objectAtIndex:chosenSound]
        //             fromComponent:@"the Animal"];
    //} else {
      //  int chosenAnimal=[pickerView selectedRowInComponent:kAnimalComponent];
        //[initialView displayAnimal:[self.animalNames objectAtIndex:chosenAnimal]
          //               withSound:[self.animalSounds objectAtIndex:row]
            //         fromComponent:@"the Sound"];
    //}
    
}



- (IBAction)findWorkout:(id)sender {
}
@end