//
//  Place.h
//  GoogleMapDemo
//
//  Created by Gasol Wu on 10/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject
{
    NSString *placeId;
    NSArray *types;
    NSString *icon;
    NSString *name;
    NSString *vicinity;
    NSString *reference;
    double latitude;
    double longitude;
}

@property (retain, nonatomic) NSString *placeId;
@property (retain, nonatomic) NSArray *types;
@property (retain, nonatomic) NSString *icon;
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *vicinity;
@property (retain, nonatomic) NSString *reference;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
