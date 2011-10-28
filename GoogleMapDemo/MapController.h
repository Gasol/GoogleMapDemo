//
//  MapController.h
//  GoogleMapDemo
//
//  Created by Gasol Wu on 10/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Place.h"

@interface MapController : UIViewController

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) Place *place;

- (id)initWithPlace: (Place*) place;

@end
