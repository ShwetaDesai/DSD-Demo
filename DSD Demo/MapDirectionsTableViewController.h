//
//  MapDirectionsTableViewController.h
//  DSD Demo
//
//  Created by Shweta on 03/12/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface MapDirectionsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>{

}
@property (strong, nonatomic) MKRoute *route;
@end
