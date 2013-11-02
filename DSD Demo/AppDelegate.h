//
//  AppDelegate.h
//  DSD Demo
//
//  Created by Shweta on 26/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableArray *customersToService, *ordersPlaced;
    NSString *customerToServicID;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) NSMutableArray *customersToService;
@property (strong,nonatomic) NSMutableArray *ordersPlaced;
@property (strong,nonatomic) NSString *customerToServicID;
@end
