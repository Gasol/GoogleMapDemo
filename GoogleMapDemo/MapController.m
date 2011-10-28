//
//  MapController.m
//  GoogleMapDemo
//
//  Created by Gasol Wu on 10/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MapController.h"

@implementation MapController
@synthesize mapView;
@synthesize place;

- (id)initWithPlace: (Place*) aPlace
{
    if (self = [super init]) {
        self.place = aPlace;
    }
    return self;

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = self.place.name;
    
    MKCoordinateRegion region;
    region.center.latitude = self.place.latitude;
    region.center.longitude = self.place.longitude;
    
    MKCoordinateSpan span;
    span.latitudeDelta  = .002;
    span.longitudeDelta = .002;
    region.span = span;
    [self.mapView setRegion:region animated:YES];
    [self.mapView selectAnnotation:self.place animated:YES];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setPlace:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [mapView release];
    [place release];
    [super dealloc];
}
@end
