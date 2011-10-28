//
//  Place.m
//  GoogleMapDemo
//
//  Created by Gasol Wu on 10/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Place.h"

@implementation Place

@synthesize placeId;
@synthesize types;
@synthesize icon;
@synthesize name;
@synthesize vicinity;
@synthesize reference;
@synthesize latitude;
@synthesize longitude;

- (id)initWithNSDictionary:(NSDictionary*) dictionary
{
    if (self = [super init]) {
        Place *place = (Place*) self;
        place.placeId = [dictionary objectForKey:@"id"];
        place.name = [dictionary objectForKey:@"name"];
        place.icon = [dictionary objectForKey:@"icon"];
        place.reference = [dictionary objectForKey:@"reference"];
        place.vicinity = [dictionary objectForKey:@"vicinity"];
        NSDictionary *geometry = [dictionary objectForKey:@"geometry"];
        NSDictionary *location = [geometry objectForKey:@"location"];
        id lat = [location objectForKey:@"lat"];
        id lng = [location objectForKey:@"lng"];
        place.latitude = [lat doubleValue];
        place.longitude = [lng doubleValue];
    }
    return self;
}

- (NSString*)title
{
    return self.name;
}

- (NSString*)subtitle
{
    return self.vicinity;
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate = {self.latitude, self.longitude};
    return coordinate;
}

- (void)dealloc {
    [placeId release];
    [name release];
    [icon release];
    [reference release];
    [vicinity release];
    [super dealloc];
}

@end
