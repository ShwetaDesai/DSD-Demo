//
//  CustomerDetailsViewController.h
//  DSD Demo
//
//  Created by Shweta on 31/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer.h"
#import <GoogleMaps/GoogleMaps.h>

@interface CustomerDetailsViewController : UIViewController {
    IBOutlet UILabel *lbl_CustomerID;
    IBOutlet UILabel *customerName;
    IBOutlet UILabel *lbl_street;
    IBOutlet UILabel *lbl_city;
    UIButton *btn_Service;
    IBOutlet UILabel *lbl_phoneNumber;
    Customer *customerSelected;
    GMSMapView *mapView_;
    UIButton *btn_Simulate, *btn_directions;
}
- (IBAction)serviceBtnClicked:(id)sender;

@end
