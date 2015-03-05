//
//  EarthquakeTableViewController.h
//  earthquakeMonitor
//
//  Created by Miguel Garcia Topete on 04/03/15.
//  Copyright (c) 2015 Miguel Garcia Topete. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Eartquake.h"
@interface EarthquakeTableViewController : UITableViewController <UIScrollViewDelegate, UITableViewDataSource,UITableViewDelegate>

@property (strong) NSMutableArray *earthquakes;


-(void)startDownload;
-(void)getData: (NSData*)data;
-(void)refreshData:(UIRefreshControl*)refresh;
- (IBAction)refresh:(id)sender;
@end
