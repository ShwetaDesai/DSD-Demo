//
//  CustomerDetailsViewController.m
//  DSD Demo
//
//  Created by Shweta on 31/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "CustomerDetailsViewController.h"
#import "AppDelegate.h"
#import "AppSingleton.h"

@implementation CustomerDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    
    customerSelected = [appObject.customersToService objectAtIndex:appObject.rowCustomerListSelected];
    
    lbl_CustomerID.text = customerSelected.ID;
    customerName.text = customerSelected.name;
    lbl_street.text = customerSelected.street;
    lbl_city.text = customerSelected.city;
    lbl_phoneNumber.text = customerSelected.phoneNo;
 
    [btn_Simulate addTarget:self action:@selector(onClickSimulate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Simulate];

    [btn_Service addTarget:self action:@selector(onClickServiceOutlet) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_directions addTarget:self action:@selector(onClickGetDirections) forControlEvents:UIControlEventTouchUpInside];
    
    if(customerSelected.isServiced)
        [btn_Service setHidden:YES];
    
    [self.view addSubview:btn_Service];
    
    // MAP KIT METHODS -----
    float latC = [customerSelected.latitudeC floatValue];
    float longC = [customerSelected.longitudeC floatValue];
    
  // stop 2
    destinationCoord.latitude = latC;
    destinationCoord.longitude= longC;
    
    //set ETA time
    NSDateFormatter *etaFormat = [[NSDateFormatter alloc] init];
    [etaFormat setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    
    etaDate = [[NSDate alloc] init];
    etaDate = [etaFormat dateFromString:customerSelected.ETA];
    [etaFormat setDateFormat:@"HH:mm:ss a"];
    time_eta.text = [etaFormat stringFromDate:etaDate];
    
    //set now time
    nowFormat = [[NSDateFormatter alloc] init];
    [nowFormat setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    nowDate = [[NSDate alloc] init];

    if (CLLocationCoordinate2DIsValid([[AppSingleton getSingleton] curntLoc].coordinate)) {
        NSLog(@"got a location !!!");
        sourceCoord.latitude = [[AppSingleton getSingleton] curntLoc].coordinate.latitude;
        sourceCoord.longitude = [[AppSingleton getSingleton] curntLoc].coordinate.longitude;
    }else{
        // set the previous stop co-ordinates
        if (appObject.rowCustomerListSelected == 0) {
            sourceCoord.latitude = 33.678158;
            sourceCoord.longitude= -117.854505;
            
        }else{
            sourceCoord.latitude = [prevCustomer.latitudeC floatValue];
            sourceCoord.longitude= [prevCustomer.longitudeC floatValue];
        }
    }
    
     if (appObject.rowCustomerListSelected != 0)
         prevCustomer = [appObject.customersToService objectAtIndex:appObject.rowCustomerListSelected-1];
    
    if (appObject.rowCustomerListSelected == 0) {
        nowDate = [nowFormat dateFromString:@"10-12-2013 8:12:00"];
        [nowFormat setDateFormat:@"HH:mm:ss a"];
        time_curr.text = [nowFormat stringFromDate:nowDate];
    }else{
//        NSLog(@"prev customer:%@",prevCustomer);
        
        nowDate = [nowFormat dateFromString:prevCustomer.ETA];
        nowDate = [nowDate dateByAddingTimeInterval:10*60];
        [nowFormat setDateFormat:@"HH:mm:ss a"];
        time_curr.text = [nowFormat stringFromDate:nowDate];
    }
    
    
    intrval = [etaDate timeIntervalSinceDate:nowDate];
//    NSLog(@"time interval **********:%f",intrval);
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(destinationCoord, 0.7*METERS_PER_MILE, 0.7*METERS_PER_MILE);
    
    // 3
    mMapView = [[MKMapView alloc] initWithFrame:CGRectMake(15, 65, self.view.frame.size.width - 5, 570)];
    [mMapView setRegion:viewRegion animated:YES];
    mMapView.delegate = self;
    [self.view addSubview:mMapView];
    
    //4 destination annotation
    DestinationAnnotation = [[MyAnnotation alloc] initWithName:customerSelected.name
            address:customerSelected.street
        coordinate:destinationCoord];

    NSString *sourceString, *addString;
    sourceString = @"Current location";
//    if (appObject.rowCustomerListSelected == 0) {
//        addString = @"18301 Von Karman Ave";
//    }else{
//        addString = prevCustomer.street;
//    }

    MyAnnotation *sourceAnnotation = [[MyAnnotation alloc] initWithName:sourceString
            address:addString
        coordinate:sourceCoord];

    [mMapView showAnnotations:[NSArray arrayWithObjects:sourceAnnotation,DestinationAnnotation, nil] animated:YES];
    mMapView.showsUserLocation = YES;
  
}

-(void)viewDidAppear:(BOOL)animated{
    // Make a directions request
    MKDirectionsRequest *directionsRequest = [MKDirectionsRequest new];
    
    MKPlacemark *sourcePlacemark = [[MKPlacemark alloc] initWithCoordinate:sourceCoord addressDictionary:nil];
    MKMapItem *source = [[MKMapItem alloc] initWithPlacemark:sourcePlacemark];
    
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:destinationCoord addressDictionary:nil];
    MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
    
    [directionsRequest setSource:source];
    [directionsRequest setDestination:destination];
    [directionsRequest setTransportType:MKDirectionsTransportTypeAutomobile];
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        // Now handle the result
        if (error) {
            NSLog(@"There was an error getting your directions");
            return;
        }
        _currentRoute = [response.routes firstObject];
//        NSLog(@"expected 8888888time:%f and distance:%f",_currentRoute.expectedTravelTime,_currentRoute.distance);
     
        [self plotRouteOnMap:_currentRoute];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) onClickServiceOutlet{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:lbl_CustomerID.text forKey:@"customerToServiceID"];
//    NSLog(@"cust ID chosen:%@",lbl_CustomerID.text);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:nServiceOutletButtonClicked object:nil userInfo:dict];
}

#pragma mark - Utility Methods
- (void)plotRouteOnMap:(MKRoute *)route
{
    if(_routeOverlay) {
        [mMapView removeOverlay:_routeOverlay];
    }
    
    // Update the ivar
    _routeOverlay = route.polyline;
    
    // Add it to the map
        isStepOverlay = NO;
    [mMapView addOverlay:_routeOverlay];
    
}

-(void) onClickGetDirections {
    mapTVC = [[MapDirectionsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    mapTVC.route = _currentRoute;
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:mapTVC];
    
    navC.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navC animated:YES completion:nil];
}

-(void)onClickSimulate{
    currentPointNumber = 0;
    btn_Simulate.enabled = NO;
    if(_stepOverlay) {
        [mMapView removeOverlay:_stepOverlay];
    }
    aTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(aTime) userInfo:nil repeats:YES];
}

-(void)aTime {
    
    MKRouteStep *routeStep = [_currentRoute.steps objectAtIndex:currentPointNumber];
        _stepOverlay = routeStep.polyline;
        
        MyAnnotation *stepAnnotation = [[MyAnnotation alloc] initWithName:nil
            address:nil
            coordinate:CLLocationCoordinate2DMake(_stepOverlay.coordinate.latitude,_stepOverlay.coordinate.longitude)];
        ++currentPointNumber;
        [mMapView addAnnotation:stepAnnotation];
    //update timer
//    NSLog(@"expected and distance:%f",routeStep.distance);
   
    float val = (routeStep.distance/(50 * METERS_PER_MILE))*60*60;
    
//    NSLog(@"interval division:%f",val);
    
    nowDate = [nowDate dateByAddingTimeInterval:val];     time_curr.text = [nowFormat stringFromDate:nowDate];
    
        [mMapView addOverlay:_stepOverlay];
        if(currentPointNumber == [_currentRoute.steps count])
        {
            [aTimer invalidate];
            aTimer = nil;
            btn_Simulate.enabled = YES;
        }
    }

#pragma mark - MKMapViewDelegate methods
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
//    NSLog(@"Type of overlay object:%@",overlay);
    
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];

    if(overlay == _stepOverlay){
        renderer.strokeColor = [UIColor cyanColor];
        renderer.lineWidth = 4.0;
    }else{
        renderer.strokeColor = [UIColor redColor];
        renderer.lineWidth = 4.0;
    }
        return  renderer;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView* pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    
    if (annotation == DestinationAnnotation) {
        pinView.image = [UIImage imageNamed:@"race-flag20.png"];
    }
    pinView.canShowCallout=YES;
    return pinView;
    
}

@end
