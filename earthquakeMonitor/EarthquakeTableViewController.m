//
//  EarthquakeTableViewController.m
//  earthquakeMonitor
//
//  Created by Miguel Garcia Topete on 04/03/15.
//  Copyright (c) 2015 Miguel Garcia Topete. All rights reserved.
//



#import "EarthquakeTableViewController.h"
#import "EarthquakeCell.h"
#import "EarthquakeDetailViewController.h"
#import "EarthQuakeSummaryMapViewController.h"
#define getURL @"http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"
@interface EarthquakeTableViewController ()

@end
@implementation EarthquakeTableViewController
@synthesize earthquakes;

- (void)viewDidLoad {
    [super viewDidLoad];
    earthquakes = [[NSMutableArray alloc]init];
    [self startDownload];
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return earthquakes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"EquakeCell";
    Eartquake *equake = [self.earthquakes objectAtIndex:indexPath.row];
    EarthquakeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[EarthquakeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    // Configure the cell...
    cell.titleLabel.text = equake.place;
    if (equake.mag>0.0 && equake.mag <=2.5) {
        cell.magLabel.textColor = [UIColor greenColor];
    }
    else if (equake.mag>2.5 && equake.mag <=5.0)
    {
        cell.magLabel.textColor = [UIColor yellowColor];
    }
    else if (equake.mag>5.0 && equake.mag <=7.5)
    {
        cell.magLabel.textColor = [UIColor orangeColor];
    }
    else if (equake.mag>7.5 && equake.mag <=10.0)
    {
        cell.magLabel.textColor = [UIColor redColor];
    }
    cell.accessoryView.backgroundColor = [UIColor lightGrayColor];
    cell.magLabel.text = [NSString stringWithFormat:@"%.2f",equake.mag];
    cell.timeLabel.text = equake.lapsed;
    return cell;

    
    
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   if ([segue.identifier isEqualToString:@"mapsSegue"])
   {
       EarthQuakeSummaryMapViewController *vc = [[EarthQuakeSummaryMapViewController alloc]init];
       vc = [segue destinationViewController];
       vc.earthquakes = self.earthquakes;
   }
   else
   {
        EarthquakeCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        Eartquake *equake = [self.earthquakes objectAtIndex:indexPath.row];
        EarthquakeDetailViewController *vc = [segue destinationViewController];
        vc.equake = equake;
   }
}



#pragma mark - Methods


-(void)startDownload
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURL *url = [NSURL URLWithString:getURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    [self getData:data];
}
-(void)getData: (NSData*)data
{
    NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

    NSArray *parsedArray = [parsedData objectForKey:@"features"];
    [self.earthquakes removeAllObjects];
    for (NSDictionary *element in parsedArray)
    {
        Eartquake *equake = [Eartquake equakeWithDictionary:element];
        [self.earthquakes addObject:equake];
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.tableView reloadData];

    
}

-(void)refreshData:(UIRefreshControl*)refresh
{
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing Earthquakes"];
    [self startDownload];
    
//    NSLocale *locale = [NSLocale currentLocale];
//    NSString *localeIdentifier = locale.localeIdentifier;
//    NSLocale *currentLocale = [[NSLocale alloc]initWithLocaleIdentifier:localeIdentifier];
   NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setLocale:currentLocale];
//    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lupdated = [NSString stringWithFormat:@"Last Updated on: %@",[formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:lupdated];
    
    [refresh endRefreshing];
}

- (IBAction)refresh:(id)sender
{
    [self startDownload];

}

@end
