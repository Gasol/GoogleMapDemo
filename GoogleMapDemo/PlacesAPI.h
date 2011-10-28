//
//  PlacesAPI.h
//  GoogleMapDemo
//
//  Created by Gasol Wu on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CLLocation.h"

#define API_KEY @"your key"
#define BASE_URL @"https://maps.googleapis.com/maps/api/place/search/json"

@interface PlacesAPI : NSObject
{
    NSString *apiKey;
    BOOL sensor;
}

@property (copy) NSString *apiKey;
@property BOOL sensor;

- (id)initWithApiKey:(NSString*)apiKey sensor:(BOOL) sensor;
- (NSArray*)placeWithName:(NSString*)name AtLocation:(NSString*)location InRadius:(int)radius;

@end
