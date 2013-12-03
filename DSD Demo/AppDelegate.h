//
//  AppDelegate.h
//  DSD Demo
//
//  Created by Shweta on 26/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableArray *customersToService, *ordersPlaced;
    NSString *customerToServicID;
    int rowCustomerListSelected;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) NSMutableArray *customersToService;
@property (strong,nonatomic) NSMutableArray *ordersPlaced;
@property (strong,nonatomic) NSString *customerToServicID;
@property (assign) int rowCustomerListSelected;

-(void)setImageForPallet:(NSMutableArray*)array;
-(NSMutableArray*)getImageForPallet;

@end
