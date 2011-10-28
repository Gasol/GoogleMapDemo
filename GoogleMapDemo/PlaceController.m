//
//  ViewController.m
//  GoogleMapDemo
//
//  Created by Gasol Wu on 10/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlaceController.h"

@interface PlaceController()
- (void)startStandardUpdates;
@end

@implementation PlaceController
@synthesize searchBar;
@synthesize tableView;
@synthesize tableData;
@synthesize api;
@synthesize locationManager;
@synthesize locationView;
@synthesize currentLocation;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"Nearby Place";
    self.tableData = [[NSMutableArray alloc] init];
    self.api = [[PlacesAPI alloc] initWithApiKey:API_KEY sensor:YES];
    [self startStandardUpdates];
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [self setTableView:nil];
    [self setTableData:nil];
    [self setApi:nil];
    [self setLocationManager:nil];
    [self setLocationView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)clearDataWithReload:(BOOL)reload
{
    [self.tableData removeAllObjects];
    if (reload) {
        [self.tableView reloadData];
    }
}

- (void)searchBar:(UISearchBar *)aSearchBar activate:(BOOL)active
{
    self.tableView.allowsSelection = !active;
    self.tableView.scrollEnabled = !active;
    [aSearchBar setShowsCancelButton:active animated:YES];
    if (!active) {
        [aSearchBar resignFirstResponder];
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)aSearchBar
{
    [self searchBar: aSearchBar activate:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar
{
    NSLog(@"search text: %@", aSearchBar.text);
    if (self.currentLocation != nil) {
        NSString *location = [NSString stringWithFormat:@"%g,%g", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude];
        NSLog(@"location: %@", location);
//        NSString *location = @"24.99168,121.23096";
        NSArray *result = [self.api placeWithName:aSearchBar.text AtLocation:location InRadius:500];
        [self clearDataWithReload:NO];
        [self.tableData addObjectsFromArray:result];
        [self.tableView reloadData];
        [self searchBar: aSearchBar activate:NO];
    }
}

- (void)searchBar:(UISearchBar *)aSearchBar textDidChange:(NSString *)searchText
{
    NSLog(@"textDidChange: %@", searchText);
    if ([searchText length] == 0) {
        [self clearDataWithReload:YES];
        [aSearchBar resignFirstResponder];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) aSearchBar
{
    [self searchBar: aSearchBar activate:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SearchResult";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    
    Place *place = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = place.name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = [self.tableData count];
    return count;
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        locationView.text = [NSString stringWithFormat:@"latitude %+.6f, longitude %+.6f",
                                                       newLocation.coordinate.latitude,
                                                       newLocation.coordinate.longitude];
        
        self.currentLocation = newLocation;
    }
}

- (CLLocationManager*)locationManager
{
    if (locationManager == nil) {
        locationManager = [[CLLocationManager alloc] init];
    }
    return locationManager;
}

- (void)startStandardUpdates
{  
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 500;
    [self.locationManager startUpdatingLocation];
}

- (void)dealloc
{
    [searchBar release];
    [tableView release];
    [tableData release];
    [api release];
    [locationManager release];
    [locationView release];
    [currentLocation release];
    [super dealloc];
}
@end
