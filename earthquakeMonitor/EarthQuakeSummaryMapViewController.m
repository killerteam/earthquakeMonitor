//
//  EarthQuakeSummaryMapViewController.m
//  earthquakeMonitor
//
//  Created by Miguel Garcia Topete on 05/03/15.
//  Copyright (c) 2015 Miguel Garcia Topete. All rights reserved.
//

#import "EarthQuakeSummaryMapViewController.h"
#import "Eartquake.h"

@interface EarthQuakeSummaryMapViewController ()

@end

@implementation EarthQuakeSummaryMapViewController
@synthesize earthquakes,map;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.map setDelegate:self];
    [self addAnnotations];
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


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    NSLog(@"mapview");
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKAnnotationView *pinView = (MKAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView2"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView2"];
            //pinView.animatesDrop = YES;
            MKPointAnnotation *tmpannotation = (MKPointAnnotation*)annotation;
            pinView.canShowCallout = YES;
                      for (Eartquake *equake in self.earthquakes)
                      {
                        if ([tmpannotation.title isEqualToString:[NSString stringWithFormat:@"%@",equake.place]])
                        {

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
                        }
                      }
        } else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}


- (void)addAnnotations
{
    CLLocationCoordinate2D location;
    MKPointAnnotation *newAnnotation;
    self.annotationsArray = [NSMutableArray new];
    
    for (Eartquake *equake in self.earthquakes)
    {
        location.latitude = equake.latitude;
        location.longitude = equake.longitude;
        newAnnotation = [[MKPointAnnotation alloc]init];
        newAnnotation.title = equake.place;
        newAnnotation.coordinate = location;
        [self.annotationsArray addObject:newAnnotation];
        
    }
    
    [self.map addAnnotations:self.annotationsArray];

}




@end
