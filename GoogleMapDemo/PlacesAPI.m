//
//  PlacesAPI.m
//  GoogleMapDemo
//
//  Created by Gasol Wu on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlacesAPI.h"
#import "Place.h"
#import "CJSONDeserializer.h"
#import "NSDictionary_JSONExtensions.h"

@implementation PlacesAPI

@synthesize apiKey;
@synthesize sensor;

- (id)initWithApiKey:(NSString*)anApiKey sensor:(BOOL)aSensor
{
    if (self = [super init]) {
        PlacesAPI *api = (PlacesAPI*) self;
        api.apiKey = anApiKey;
        api.sensor = aSensor;
    }
    return self;
}

- (NSArray*)placeWithName:(NSString*)name AtLocation:(NSString*)location InRadius:(int)radius
{
    NSMutableArray *params = [[NSMutableArray alloc] initWithObjects:@"language=zh-TW", nil];
    [params addObject:[NSString stringWithFormat:@"key=%@", self.apiKey]];
    [params addObject:[NSString stringWithFormat:@"sensor=%@", self.sensor ? @"true": @"false"]];
    [params addObject:[NSString stringWithFormat:@"location=%@", location]];
    [params addObject:[NSString stringWithFormat:@"radius=%d", radius]];
    if (name != nil) {
        [params addObject:[NSString stringWithFormat:@"name=%@", [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    
    NSString *queryString = [params componentsJoinedByString:@"&"];
    [params release];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", BASE_URL, queryString]];
    NSLog(@"url: %@", url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    [request release];
    
    NSError *error = [[NSError alloc] init];
    NSDictionary *json = [NSDictionary dictionaryWithJSONData: data error:&error];
    [error release];
    
    NSString *status = [json objectForKey:@"status"];
    if ([status isEqualToString:@"OK"]) {
        NSMutableArray *places = [[NSMutableArray alloc] init];
        NSArray *results = [json objectForKey: @"results"];
        for (NSDictionary *item in results) {
            Place *place = [[[Place alloc] initWithNSDictionary:item] autorelease];          
            [places addObject:place];
        }
        
        NSArray *retArray = [NSArray arrayWithArray:places];
        [places release];
        return retArray;
    }
    
    return nil;
}

- (void)dealloc {
    [super dealloc];
}
@end
