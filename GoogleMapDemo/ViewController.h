//
//  ViewController.h
//  GoogleMapDemo
//
//  Created by Gasol Wu on 10/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PlacesAPI.h"
#import "Place.h"

@interface ViewController : UIViewController<UISearchBarDelegate, UITableViewDataSource, CLLocationManagerDelegate>
{
    UISearchBar *searchBar;
    UITableView *tableView;
    NSMutableArray *tableData;
    PlacesAPI *api;
    CLLocationManager *locationManager;
    UILabel *locationView;
    CLLocation *currentLocation;
}

@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *tableData;
@property (retain, nonatomic) PlacesAPI *api;
@property (retain, nonatomic) CLLocationManager *locationManager;
@property (retain, nonatomic) IBOutlet UILabel *locationView;
@property (retain, nonatomic) CLLocation *currentLocation;

@end
