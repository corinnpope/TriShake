//
//  checklistTableViewController.m
//  TriShake
//
//  Created by Corinn Pope on 3/4/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import "checklistTableViewController.h"

@interface checklistTableViewController ()

@end

@implementation checklistTableViewController



@synthesize selectedIndexPath;
@synthesize checkedCells;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
   self.checkedCells = [[NSMutableArray alloc]init];
    
    
    [super viewDidLoad];
    
    //Initialize the array.
    
    sectionArray = [[NSMutableArray alloc] init];
    
    NSArray *essentialsArray = [NSArray arrayWithObjects:@"Identification", @"Registration Confirmation", @"Goggles",@"Tri-Suit", @"Wetsuit", @"Bike", @"Helmet", @"Bike Shoes", @"Flat Kit", @"Running Shoes",  @"Watch", @"Water Bottle", @"Body Glide", nil];
    NSDictionary *essentialsDict = [NSDictionary dictionaryWithObject:essentialsArray forKey:@"Items"];
    
    NSArray *preRaceArray = [NSArray arrayWithObjects:@"USAT Card", @"Directions to Race", @"Medication", @"Keys", @"Phone & Charger", @"Money", @"Insurance Card", @"First Aid Kit", @"MP3 Player & Headphones", @"Sunscreen", @"Hair Ties", @"Timing Chip", nil];
    NSDictionary *preRaceDict = [NSDictionary dictionaryWithObject:preRaceArray forKey:@"Items"];
    
    NSArray *swimArray = [NSArray arrayWithObjects:@"Swim Cap", @"Goggle DeFogger", @"Earplugs", @"Noseplug", @"Swim Stretch Cords", nil];
    NSDictionary *swimDict = [NSDictionary dictionaryWithObject:swimArray forKey:@"Items"];
    
    NSArray *bikeArray = [NSArray arrayWithObjects:@"Bar-end Plugs", @"Race Wheels", @"Aero-Bars", @"Rubber Bands", @"Water/Fuel", @"Multi-tool", @"Socks", @"Sunglasses", @"Gloves", @"Race Belt", @"Bike Jacket", @"Chamois Cream", nil];
    NSDictionary *bikeDict = [NSDictionary dictionaryWithObject:bikeArray forKey:@"Items"];
    
    NSArray *runArray = [NSArray arrayWithObjects:@"Speed Laces", @"Fuel Belt", @"Hat/Visor", @"Knee Brace", @"Water/Fuel", @"Multi-tool", @"Socks", @"Sunglasses", nil];
    NSDictionary *runDict = [NSDictionary dictionaryWithObject:runArray forKey:@"Items"];
    
    NSArray *transitionArray = [NSArray arrayWithObjects:@"Towel", @"Transition Mat", @"Transition Area Marker", nil];
    NSDictionary *transitionDict = [NSDictionary dictionaryWithObject:transitionArray forKey:@"Items"];
    
    
    NSArray *postRaceArray = [NSArray arrayWithObjects:@"Extra Clothes", @"Food", @"Wet-Wipes", @"Deodorant", @"Trash Bags", @"Foam Roller", nil];
    NSDictionary *postRaceDict = [NSDictionary dictionaryWithObject:postRaceArray forKey:@"Items"];
    
    
    [sectionArray addObject:essentialsDict];
    [sectionArray addObject:preRaceDict];
    [sectionArray addObject:swimDict];
    [sectionArray addObject:bikeDict];
    [sectionArray addObject:runDict];
    [sectionArray addObject:transitionDict];
    [sectionArray addObject:postRaceDict];
    
    //Set the title
    self.navigationItem.title = @"Race Checklist";
    //self.tableView.allowsMultipleSelection = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dictionary = [sectionArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"Items"];
    return [array count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"Essentials";
    if (section == 1)
        return @"Pre-Race";
    if (section == 2)
        return @"Swim";
    if (section == 3)
        return @"Bike";
    if (section == 4)
        return @"Run";
    if (section == 5)
        return @"Transition";
    else
        return @"Post-Race";
}

#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    static NSString *cellIdentifier=@"cell";
    UITableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //if array contains the index path, add a checkmark, if not, no checkmark
    if([self.checkedCells containsObject:indexPath])
    {
        
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else 
    {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    // Display text for each cell using data from section array
    NSDictionary *dictionary = [sectionArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Items"];
    NSString *cellValue = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    
    return cell;
}
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // check the array to see if it contains the object path, if it doesn't, add index path, if it does, remove index path
    if(![self.checkedCells containsObject:indexPath])
    {
    [self.checkedCells addObject:indexPath];
    }
    else
    {
        [self.checkedCells removeObject:indexPath];
    }
    //add or remove a checkmark to the selected cell
    
   UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.checkedCells addObject:selectedIndexPath];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.checkedCells removeObject:selectedIndexPath];
}
}
@end
