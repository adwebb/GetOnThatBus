//
//  BusStopAnnotation.h
//  GetOnThatBus
//
//  Created by Andrew Webb on 1/21/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BusStopAnnotation : NSObject <MKAnnotation>
@property  NSDictionary* CTABus;
@property (nonatomic, copy)NSString* title;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)NSString* subtitle;
@end
