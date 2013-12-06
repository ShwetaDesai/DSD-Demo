//
//  CustomerDetailsViewController.h
//  DSD Demo
//
//  Created by Shweta on 31/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer.h"
#import <MapKit/MapKit.h>
#define METERS_PER_MILE 1609.344
#import "MyAnnotation.h"
#import "MapDirectionsTableViewController.h"

@interface CustomerDetailsViewController : UIViewController <MKMapViewDelegate, UIPopoverControllerDelegate>
{
    IBOutlet UILabel *lbl_CustomerID;
    IBOutlet UILabel *customerName;
    IBOutlet UILabel *lbl_street;
    IBOutlet UILabel *lbl_city;
    IBOutlet UILabel *lbl_phoneNumber;
    Customer *customerSelected;

    IBOutlet UIButton *btn_Simulate;
    IBOutlet UIButton *btn_directions;
    IBOutlet UIButton *btn_Service;
    IBOutlet UILabel *time_curr;
    
    IBOutlet UILabel *time_eta;
    MKMapView *mMapView;
    MKPolyline *_routeOverlay, *_stepOverlay;
    MKRoute *_currentRoute;
    CLLocationCoordinate2D destinationCoord;
    CLLocationCoordinate2D sourceCoord;
    MapDirectionsTableViewController *mapTVC;
//    UIPopoverController *directionsPopover;
    BOOL isStepOverlay;
//    CLLocationManager *locationManager;
    NSTimer *aTimer;
    int currentPointNumber;
    Customer *prevCustomer;
    MyAnnotation *DestinationAnnotation;
    NSDate *nowDate;
    NSDateFormatter *nowFormat;
    NSDate *etaDate;
    NSTimeInterval intrval;
}

@end
