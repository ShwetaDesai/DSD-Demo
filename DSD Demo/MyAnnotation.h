//
//  MyAnnotation.h
//  DSD Demo
//
//  Created by Shweta on 03/12/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation>
- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;
//- (MKMapItem*)mapItem;
@end
