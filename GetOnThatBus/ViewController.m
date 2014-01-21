//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Andrew Webb on 1/21/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "DetailViewController.h"
#import "BusStopAnnotation.h"
#import "AppDelegate.h"


static NSString *JSONURL = @"http://dev.mobilemakers.co/lib/bus.json";

@interface ViewController () <MKMapViewDelegate>
{
    __weak IBOutlet MKMapView *busMapView;
    CLLocationCoordinate2D MMHQCOORDINATE;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDataFromJSON];
    
    MMHQCOORDINATE = CLLocationCoordinate2DMake(41.89373984, -87.63532979);
     
    MKPointAnnotation* annotation = [MKPointAnnotation new];
    annotation.title = @"Mobile Makers";
    annotation.coordinate = MMHQCOORDINATE;
    [busMapView addAnnotation:annotation];
}

-(void)viewDidAppear:(BOOL)animated
{
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(MMHQCOORDINATE, span);
    busMapView.showsUserLocation = YES;
    [busMapView setRegion:region animated:animated];
}

-(void)loadDataFromJSON
{
    NSURL *URL = [NSURL URLWithString:JSONURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         CTABUSES = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError][@"row"];
         
        
         for (NSDictionary* CTABus in CTABUSES) {
             
             double latitude = [CTABus[@"latitude"] doubleValue];
             double longitude = [CTABus[@"longitude"] doubleValue];
             
             CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude,longitude);
             BusStopAnnotation* annotation = [BusStopAnnotation new];
             annotation.title = CTABus[@"cta_stop_name"];
             annotation.subtitle = [NSString stringWithFormat:@"Routes: %@",CTABus[@"routes"]];
             annotation.coordinate = coordinate;
             annotation.CTABus = CTABus;
             [busMapView addAnnotation:annotation];
             
         }
     }];

}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if(annotation == mapView.userLocation)
    {
        return nil;
    }

    MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"Centaur Don Bora"];
    if(annotationView == nil)
    {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Centaur Don Bora"];
    }else{
        annotationView.annotation = annotation;
    }
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    BusStopAnnotation *busAnnotation = annotation;
    
    if (![annotation isKindOfClass:[BusStopAnnotation class]])
    {
        annotationView.image = [UIImage imageNamed:@"mobilemakers"];
        return annotationView;
    }
    
    if([busAnnotation.CTABus[@"inter_modal"] isEqualToString:@"Metra"])
    {
        annotationView.image = [UIImage imageNamed:@"metra"];
    }else if ([busAnnotation.CTABus[@"inter_modal"] isEqualToString:@"Pace"])
    {
        annotationView.image = [UIImage imageNamed:@"pace"];
    }else{
        annotationView.image = [UIImage imageNamed:@"cta"];
    }
    
    return annotationView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"CTABusInfoSegueID" sender:view];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(MKAnnotationView *)sender
{
    DetailViewController* dvc = segue.destinationViewController;
    
    BusStopAnnotation *annotation = sender.annotation;
    
    dvc.title = annotation.CTABus[@"cta_stop_name"];
    dvc.CTABus = annotation.CTABus;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
