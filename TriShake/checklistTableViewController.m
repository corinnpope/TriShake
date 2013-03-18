//
//  checklistTableViewController.m
//  TriShake
//
//  Created by Corinn Pope on 3/4/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

static NSString * const kCellTextKey = @"CellTextKey";
static NSString * const kCellStateKey = @"CellStateKey";

#import "checklistTableViewController.h"

@interface checklistTableViewController ()

@end

@implementation checklistTableViewController



@synthesize numberOfSections;
@synthesize activityIndicator;
@synthesize tableData;

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
    [super viewDidLoad];
    
    //Initialize the array.
    

    NSMutableArray *checkedCells = [[NSMutableArray alloc] init];
    
    sectionArray = [[NSMutableArray alloc] init];
    
    NSArray *essentialsArray = [NSArray arrayWithObjects:@"Identification", @"USAT Card/Cash", @"Goggles", @"Bike", @"Helmet", @"Bike Shoes", @"Running Shoes", @"Flat Kit", @"Tri-Suit", @"Watch", @"Wetsuit", @"Water Bottle", @"Body Glide", nil];
    NSDictionary *essentialsDict = [NSDictionary dictionaryWithObject:essentialsArray forKey:@"Items"];
    
    NSArray *preRaceArray = [NSArray arrayWithObjects:@"Registration Confirmation", @"Directions to Race", @"Medication", @"Keys", @"Phone & Charger", @"Money", @"Insurance Card", @"First Aid Kit", @"MP3 Player & Headphones", @"Sunscreen", @"Hair Ties", @"Timing Chip", nil];
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
    
    //tableData= [checklistArray mutableCopy];
    
    //Set the title
    self.navigationItem.title = @"Race Checklist";
    //self.tableView.allowsMultipleSelection = YES;

    
    
	// Do any additional setup after loading the view.
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

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  
    
    //fix checking in all sections problem
    if ([checkedCells containsObject:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    if ((indexPath.row == selectedIndexPath.row) && (indexPath.section == selectedIndexPath.section)) {
        [cell setSelected:YES animated:NO];
    }
    
    // Display text for each cell using data from section array
    NSDictionary *dictionary = [sectionArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Items"];
    NSString *cellValue = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    

    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    

    

    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if ((indexPath.row == selectedIndexPath.row) && (indexPath.section == selectedIndexPath.section)) {
        [cell setSelected:YES animated:NO];
        [checkedCells containsObject:selectedIndexPath];
        [checkedCells addObject:selectedIndexPath];
    }
    
    if ([checkedCells containsObject:indexPath])
    {
        [checkedCells removeObject:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        [checkedCells addObject:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    
}


@end
