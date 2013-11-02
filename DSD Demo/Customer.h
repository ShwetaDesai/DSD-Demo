//
//  Customer.h
//  DSD Demo
//
//  Created by Shweta on 31/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject
{
    NSString *name, *phoneNo, *ID, *street, *pinCode, *city;
    BOOL isServiced;
}
@property (nonatomic,retain) NSString* name;
@property (nonatomic,retain) NSString* street;
@property (nonatomic,retain) NSString* phoneNo;
@property (nonatomic,retain) NSString* ID;
@property (nonatomic,retain) NSString* pinCode;
@property (nonatomic,retain) NSString* city;
@property (assign) BOOL isServiced;

@end
