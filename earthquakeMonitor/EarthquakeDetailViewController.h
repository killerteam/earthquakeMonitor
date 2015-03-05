//
//  EarthquakeDetailViewController.h
//  earthquakeMonitor
//
//  Created by Miguel Garcia Topete on 04/03/15.
//  Copyright (c) 2015 Miguel Garcia Topete. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Eartquake.h"
#import <MapKit/MapKit.h>
@interface EarthquakeDetailViewController : UIViewController<MKMapViewDelegate, UIScrollViewDelegate>
{
    MKMapView *mapView;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak) Eartquake *equake;
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *magnitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *depthLabel;
@end
