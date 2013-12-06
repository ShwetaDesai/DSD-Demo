//
//  AppDelegate.h
//  DSD Demo
//
//  Created by Shweta on 26/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    NSMutableArray *customersToService, *ordersPlaced;
    NSString *customerToServicID;
    int rowCustomerListSelected;
    CLLocationManager *locationManager;
    
}
@property (nonatomic, retain) NSString *strCurrentLat,*strCurrentLng;
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) NSMutableArray *customersToService;
@property (strong,nonatomic) NSMutableArray *ordersPlaced;
@property (strong,nonatomic) NSString *customerToServicID;
@property (assign) int rowCustomerListSelected;

@property (nonatomic,assign) CLLocation *updatedLocation;
@property (nonatomic,retain) CLLocation *updatedLastLocation;
@property (nonatomic,retain)  CLLocationManager *locationManager;
@property (nonatomic,assign) BOOL isFirstTime;

-(void)setImageForPallet:(NSMutableArray*)array;
-(NSMutableArray*)getImageForPallet;

@end
