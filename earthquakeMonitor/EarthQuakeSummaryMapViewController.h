//
//  EarthQuakeSummaryMapViewController.h
//  earthquakeMonitor
//
//  Created by Miguel Garcia Topete on 05/03/15.
//  Copyright (c) 2015 Miguel Garcia Topete. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface EarthQuakeSummaryMapViewController : UIViewController<MKMapViewDelegate>
{
//    NSMutableArray *earthquakes;
}

@property (weak) NSMutableArray *earthquakes;
@property (strong) NSMutableArray *annotationsArray;
@property (weak, nonatomic) IBOutlet MKMapView *map;



-(void)addAnnotations;
@end
