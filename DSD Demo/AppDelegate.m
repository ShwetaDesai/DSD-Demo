//
//  AppDelegate.m
//  DSD Demo
//
//  Created by Shweta on 26/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "AppDelegate.h"
#import "Order.h"
#import "Customer.h"
#import "AppSingleton.h"

@implementation AppDelegate
@synthesize customersToService,ordersPlaced,customerToServicID,rowCustomerListSelected,locationManager;
@synthesize strCurrentLat,strCurrentLng;
@synthesize isFirstTime,updatedLastLocation,updatedLocation;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    locationManager = [[CLLocationManager alloc] init];     locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    [locationManager startUpdatingLocation];
    [locationManager startMonitoringSignificantLocationChanges];
    
    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorized)
    {
        // NSLog(@"We are OK with GPS");
    }
    
    customersToService = [[NSMutableArray alloc] init];
    ordersPlaced = [[NSMutableArray alloc] init];
    palletIDs = [[NSMutableArray alloc]init];
    palletImageCheck = [[NSMutableArray alloc]init];
    
    [self getPalletIDs];
    [self loadDataObjects];
    [self parseOrderInfoData];
    [self getCustomerDetails];
    
    // Override point for customization after application launch.
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - Custom Methods
- (void)loadDataObjects {
    deliveredValues[0][0] = 20;
    deliveredValues[0][1] = 10;
    deliveredValues[0][2] = 112;
    deliveredValues[0][3] = 120;
    deliveredValues[0][4] = 50;

    deliveredValues[0][0] = 13;
    deliveredValues[0][1] = 10;
    deliveredValues[0][2] = 10;
    deliveredValues[0][3] = 12;
    deliveredValues[0][4] = 25;

    for (int i=0; i < 6; i++) {
        acceptedValues[i] = enteredValues[i] = 0;
    }
    
    arrReturns[0] = [[NSMutableArray alloc] init];
    arrReturns[1] = [[NSMutableArray alloc] init];
    arrOrders = [[NSMutableArray alloc] init];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *myFile = [mainBundle pathForResource: @"materials" ofType: @"json"];
    
    NSError *e;
    NSArray *arrObjects = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:myFile] options:kNilOptions error:&e];
    [arrOrders addObjectsFromArray:arrObjects];
}

-(void)parseOrderInfoData{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"OrderInfo" ofType:@"json"];
    
    NSError *fileReadError;
    NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&fileReadError];
    NSLog(@"File read error:%@",fileReadError);
    
    NSError *JSONreadError;

    NSDictionary *temp = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&JSONreadError];
    
    NSLog(@"JSON read error:%@",JSONreadError);
//    NSLog(@"count ordersPlaced:%d",[temp count]);
    NSArray *tArr = [temp objectForKey:@"ORDER"];
    for (int i = 0; i < [tArr count]; i++) {
        Order *obj1 = [[Order alloc] init];
        
        obj1.matNo = [[tArr objectAtIndex:i] objectForKey:@"MAT_NO"];
        obj1.customerNo = [[tArr objectAtIndex:i] objectForKey:@"CUST_NO"];

        obj1.reqrdQty = [[[tArr objectAtIndex:i] objectForKey:@"DPLN_QTY"] integerValue];
        
        obj1.matDesc = [[tArr objectAtIndex:i] objectForKey:@"MAT_DESC1"];
        
        [ordersPlaced addObject:obj1];
        NSLog(@"obj matno:%@",obj1.matNo);
    }
    NSLog(@"appObject.ordersPlaced EXIT:%d",[ordersPlaced count]);
}

-(void) getCustomerDetails {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CustomerInfo" ofType:@"json"];
    
    NSError *fileReadError;
    NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&fileReadError];
    NSLog(@"File read error:%@",fileReadError);
    
    NSError *JSONreadError;
    //customerDictionary
    NSDictionary *customerDictionary = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&JSONreadError];
    
    NSLog(@"JSON read error:%@",JSONreadError);
    //    NSLog(@"dicto values:%@",customerDictionary);
    NSArray *customersArray = [customerDictionary objectForKey:@"CUST_REC"];
    
    //    NSLog(@"count:%d",[customersArray count]);
    
    for (int i = 0; i < [customersArray count]; i++) {
        Customer *customerObject = [[Customer alloc] init];
        
        customerObject.name = [[customersArray objectAtIndex:i] objectForKey:@"NAME"];
        
        customerObject.street = [[customersArray objectAtIndex:i] objectForKey:@"STREET"];
        
        customerObject.latitudeC = [[customersArray objectAtIndex:i] objectForKey:@"LAT"];

        customerObject.longitudeC = [[customersArray objectAtIndex:i] objectForKey:@"LON"];

        customerObject.city = [[customersArray objectAtIndex:i] objectForKey:@"CITY"];
        
        customerObject.ID = [[customersArray objectAtIndex:i] objectForKey:@"CUST_NO"];
        
        customerObject.ETA = [[customersArray objectAtIndex:i] objectForKey:@"ETA"];

        customerObject.phoneNo = [[customersArray objectAtIndex:i] objectForKey:@"PHONE"];
        
        customerObject.palleteIDs = [[customersArray objectAtIndex:i] objectForKey:@"PALLETE"];
        //        NSLog(@"name:%@ address:%@",customerObject.name, customerObject.street);
        [customersToService addObject:customerObject];
       
    }
}

-(void)getPalletIDs
{
    palletIDs = [NSMutableArray arrayWithObjects:@"1456789023456950019",@"1456789023456940067",@"1456789023456930031",@"1456789023456920029",@"1456789023456970087",@"1456789023456990086",@"1456789023456980056",@"1456789023456960078", nil];
    
    [self setImageForPallet:[NSMutableArray arrayWithObjects:[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO], nil]];
    
}

-(void)setImageForPallet:(NSMutableArray*)array
{
    palletImageCheck = array ;
}
-(NSMutableArray*)getImageForPallet
{
    return palletImageCheck;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status==kCLAuthorizationStatusAuthorized)
    {
        // NSLog(@"We are Good to Go");
    }
    if(status==kCLAuthorizationStatusNotDetermined)
    {
        // NSLog(@"kCLAuthorizationStatusNotDetermined");
    }
    
    if(status==kCLAuthorizationStatusRestricted)
    {
        // NSLog(@"kCLAuthorizationStatusRestricted");
    }
    if(status==kCLAuthorizationStatusDenied)
    {
        // NSLog(@"kCLAuthorizationStatusDenied");
        //        UIAlertView *errorAlert = [[UIAlertView alloc]
        //                                   initWithTitle:@"Access Denied"
        //                                   message:@"System Failed to Get Your Location"
        //                                   delegate:nil
        //                                   cancelButtonTitle:@"OK"
        //                                   otherButtonTitles:nil];
        //        [errorAlert show];
    }
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    // NSLog(@"didFailWithError: %@", error);
    
    //     UIAlertView *errorAlert = [[UIAlertView alloc]
    //     initWithTitle:@"Error" message:@"Failed to Get Your Location"
    //     delegate:nil
    //     cancelButtonTitle:@"OK"
    //     otherButtonTitles:nil];
    //     [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{    NSLog(@"I have called Again locationManager DID UPDATE LOCATION");
    
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil ) {
        strCurrentLat=[NSString stringWithFormat:@"%.8f", updatedLocation.coordinate.latitude];
        strCurrentLng=[NSString stringWithFormat:@"%.8f", updatedLocation.coordinate.longitude];
        // // NSLog(@"Marker Point -- %@,%@",[NSString stringWithFormat:@"%.8f", updatedLocation.coordinate.latitude],[NSString stringWithFormat:@"%.8f", updatedLocation.coordinate.longitude]);
        
        AppSingleton *objSingleton = [AppSingleton getSingleton];
        
        [objSingleton setCurntLoc:currentLocation];         
        [objSingleton gotLocationUpdate];
    }
}

@end
