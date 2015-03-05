//
//  EarthquakeDetailViewController.m
//  earthquakeMonitor
//
//  Created by Miguel Garcia Topete on 04/03/15.
//  Copyright (c) 2015 Miguel Garcia Topete. All rights reserved.
//

#import "EarthquakeDetailViewController.h"

@interface EarthquakeDetailViewController ()

@end

@implementation EarthquakeDetailViewController
@synthesize equake,map;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.scroll setDelegate:self];
    [self.scroll setScrollEnabled:YES];
    self.scroll.contentSize = CGSizeMake(320, 500);
    self.placeLabel.text = self.equake.place;
    self.magnitudeLabel.text = [NSString stringWithFormat:@"%.2f",self.equake.mag];
    self.dateLabel.text = self.equake.timeStamp;
    self.depthLabel.text = [NSString stringWithFormat:@"%.2f",self.equake.depth];
    [self.map setDelegate:self];
    
    CLLocationCoordinate2D location;
    MKPointAnnotation *newAnnotation;
    
    location.latitude = self.equake.latitude;
    location.longitude = self.equake.longitude;
    newAnnotation = [[MKPointAnnotation alloc]init];
    newAnnotation.title = self.equake.place;
    newAnnotation.coordinate = location;
    [self.map addAnnotation:newAnnotation];
    [self.map setCenterCoordinate:location];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - MapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKAnnotationView *pinView = (MKAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            //pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            if (equake.mag>0.0 && equake.mag <=2.5) {
                pinView.image = [UIImage imageNamed:@"green.png"];
            }
            else if (equake.mag>2.5 && equake.mag <=5.0)
            {
                pinView.image = [UIImage imageNamed:@"yellow.png"];            }
            else if (equake.mag>5.0 && equake.mag <=7.5)
            {
                pinView.image = [UIImage imageNamed:@"orange.png"];
            }
            else if (equake.mag>7.5 && equake.mag <=10.0)
            {
                pinView.image = [UIImage imageNamed:@"Red.png"];
            }

            pinView.calloutOffset = CGPointMake(0, 32);
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}



@end
