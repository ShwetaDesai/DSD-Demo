//
//  MyAnnotation.m
//  DSD Demo
//
//  Created by Shweta on 03/12/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "MyAnnotation.h"

@interface MyAnnotation ()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
@end

@implementation MyAnnotation
- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
            self.name = name;
        self.address = address;
        self.theCoordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}

- (CLLocationCoordinate2D)coordinate {
    return _theCoordinate;
}
@end
