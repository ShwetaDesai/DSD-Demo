//
//  AppSingleton.m
//  FTDM Mobile
//
//  Created by ITITM Quinnox on 21/02/13.
//  Copyright (c) 2013 Quinnox Consultancy Services Pvt Ltd. All rights reserved.
//

#import "AppSingleton.h"

@implementation AppSingleton
@synthesize curntLoc,delegate,dicDeliveryState;

static AppSingleton *sharedAppSingleton = nil;
dispatch_queue_t backGroundQueue;

#pragma mark Singleton Methods
+ (id)getSingleton
{
    @synchronized(self)
    {
        if(sharedAppSingleton == nil)
            sharedAppSingleton = [[super allocWithZone:NULL] init];
    }
    return sharedAppSingleton;
}


-(void)gotLocationUpdate
{
    [self.delegate locationChanged];
}

//+ (id)allocWithZone:(NSZone *)zone
//{
//    return [[self getSingleton] retain];
//}
//
//- (id)copyWithZone:(NSZone *)zone
//{
//    return self;
//}

//- (id)retain
//{
//    return self;
//}
//
//- (unsigned)retainCount
//{
//    return UINT_MAX; //denotes an object that cannot be released
//}

//- (oneway void)release
//{
//    // never release
//}
//
//- (id)autorelease
//{
//    return self;
//}

//- (id)init
//{
//    if (self = [super init])
//    {
//        
//        
//    }
//    return self;
//}
//- (void)dealloc
//{
//    [super dealloc];
//}

@end
