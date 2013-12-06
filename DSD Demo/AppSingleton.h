//
//  AppSingleton.h
//
//  Created by ITITM Quinnox on 21/02/13.
//  Copyright (c) 2013 Quinnox Consultancy Services Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol AppSingletonDelegate <NSObject>
@optional
-(void)locationChanged;
@end

@interface AppSingleton : NSObject
{
    CLLocation *curntLoc;
//    id<AppSingletonDelegate> delegate;
}
@property(atomic,retain) CLLocation *curntLoc;
@property (nonatomic,assign) id<AppSingletonDelegate> delegate;
@property (nonatomic,retain) NSMutableDictionary *dicDeliveryState;

-(void)gotLocationUpdate;
+ (id)getSingleton;

@end
