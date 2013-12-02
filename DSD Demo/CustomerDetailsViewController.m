//
//  CustomerDetailsViewController.m
//  DSD Demo
//
//  Created by Shweta on 31/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "CustomerDetailsViewController.h"
#import "AppDelegate.h"

@implementation CustomerDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
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
    
    btn_Simulate = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_Simulate setTitle:@"Simulate Journey" forState:UIControlStateNormal];
    [btn_Simulate setBackgroundColor:[UIColor redColor]];
    [btn_Simulate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_Simulate setFrame:CGRectMake((self.view.frame.size.width - 160 - 170 - 180)/2, 405, 159, 51)];
//    [btnsimulateMotion addTarget:self action:@selector(onClickServiceOutlet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Simulate];
    
    btn_Service = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_Service setTitle:@"Service Outlet" forState:UIControlStateNormal];
    [btn_Service setBackgroundColor:[UIColor redColor]];
    [btn_Service setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_Service setFrame:CGRectMake((self.view.frame.size.width - 160 - 170)/2, 405, 159, 51)];
    [btn_Service addTarget:self action:@selector(onClickServiceOutlet) forControlEvents:UIControlEventTouchUpInside];
    
    if(customerSelected.isServiced)
        [btn_Service setHidden:YES];
    
    [self.view addSubview:btn_Service];
    
    // Create a GMSCameraPosition that tells the map to display
    
    float latC = [customerSelected.latitudeC floatValue];
    float longC = [customerSelected.longitudeC floatValue];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latC
        longitude:longC
        zoom:17];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(15, 65, self.view.frame.size.width - 5, 570) camera:camera];
    mapView_.myLocationEnabled = YES;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latC, longC);
    marker.title = customerSelected.name;
    marker.snippet = customerSelected.street;
    marker.map = mapView_;
    
    [self.view addSubview:mapView_];
}

-(void)viewDidAppear:(BOOL)animated{
   
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

-(void) onClickGetDirections {
    
//    [[GMDirectionService sharedInstance] getDirectionsFrom:origin to:destination        succeeded:^(GMDirection *directionResponse) {
//        if ([directionResponse statusOK]){
//            NSLog(@"Duration : %@", [directionResponse durationHumanized]);
//            NSLog(@"Distance : %@", [directionResponse distanceHumanized]);
//            NSArray *routes = [[directionResponse directionResponse] objectForKey:@"routes"];
//            // NSLog(@"Route : %@", [[directionResponse directionResponse] objectForKey:@"routes"]);
//            
//        }
//    } failed:^(NSError *error) {
//        NSLog(@"Can't reach the server")
//    }];
    
}
@end
