//
//  MasterViewController.m
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ViewController.h"

#import "TableHeaderView.h"

#import "RSSLoader.h"
#import "RSSItem.h"
#import "Reachability.h"

@interface MasterViewController ()
{
    NSArray *_objects;
    NSURL* feedURL;
    UIRefreshControl* refreshControl;

}
@end

@implementation MasterViewController

- (void)viewDidLoad
{
  
    //add method to check for internet connection when opening the RSS Feed
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    if(internetStatus == NotReachable){
        UIAlertView *errorView;
        
           errorView = [[UIAlertView alloc]
                        initWithTitle: NSLocalizedString(@"Network error", @"Network error")
                        message: NSLocalizedString(@"No internet connection found, this application requires an internet connection to gather the data required.", @"Network error")
                        delegate: self
                        cancelButtonTitle: NSLocalizedString(@"Close", @"Network error") otherButtonTitles: nil];
        
        [errorView show];
        //[errorView performSelectorOnMainThread:@selector(showDebug) withObject:nil waitUntilDone:YES];
    }
    
       
    
    [super viewDidLoad];
    
    //configuration of triathlon newsfeed
    self.title = @"Triathlon News";
    feedURL = [NSURL URLWithString:@"http://triathlon.competitor.com/feed"];
    
    //add refresh control to the table view
    refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self
                       action:@selector(refreshInvoked:forState:)
             forControlEvents:UIControlEventValueChanged];
    
    NSString* fetchMessage = [NSString stringWithFormat:@"Fetching: %@",feedURL];
    
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage
                                                                     attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:11.0]}];
    
    [self.tableView addSubview: refreshControl];
    
    //add the header
    self.tableView.tableHeaderView = [[TableHeaderView alloc] initWithText:@"fetching rss feed"];
    
    [self refreshFeed];
}

//- (BOOL)connected {
//    
//    Reachability *reachability = [Reachability reachabilityForInternetConnection];
//    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
//    //return internetStatus;
//    //return !(networkStatus ==NotReachable);
//}

- (void) alertViewCancel:(UIAlertView *)alertView {

        UIViewController *controller = [[UIViewController alloc]init];
        [self presentViewController:controller animated:YES completion:nil];
}

-(void) refreshInvoked:(id)sender forState:(UIControlState)state
{
    [self refreshFeed];
}


//set up close button to go back to workout picker
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 0) {
//        UIViewController *controller = [[UIViewController alloc]init];
//        [self presentViewController:controller animated:YES completion:nil];
//    }
//}

//add error message if user tries to refresh without an internet connection
-(void)refreshFeed
{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    if(internetStatus == NotReachable) {
        UIAlertView *errorView;
        
        errorView = [[UIAlertView alloc]
                     initWithTitle: NSLocalizedString(@"Network error", @"Network error")
                     message: NSLocalizedString(@"No internet connection found, this application requires an internet connection to gather the data required.", @"Network error")
                     delegate: self
                     cancelButtonTitle: NSLocalizedString(@"Close", @"Network error") otherButtonTitles: nil];
        
        [errorView show];
    
    }
    else {
    RSSLoader* rss = [[RSSLoader alloc] init];
    [rss fetchRssWithURL:feedURL
                complete:^(NSString *title, NSArray *results) {

                    //completed fetching the RSS
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //UI code on the main queue
                        [(TableHeaderView*)self.tableView.tableHeaderView setText:title];
                        
                        _objects = results;
                        [self.tableView reloadData];
                        
                        // Stop refresh control
                        [refreshControl endRefreshing];
                    });
                }];

    }}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    RSSItem *object = _objects[indexPath.row];
    cell.textLabel.attributedText = object.cellMessage;
    cell.textLabel.numberOfLines = 0;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSSItem *item = [_objects objectAtIndex:indexPath.row];
    CGRect cellMessageRect = [item.cellMessage boundingRectWithSize:CGSizeMake(200,10000)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                            context:nil];
    return cellMessageRect.size.height;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RSSItem *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
