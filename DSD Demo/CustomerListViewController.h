//
//  CustomerListViewController.h
//  DSD Demo
//
//  Created by Shweta on 30/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerDetailsViewController.h"

@interface CustomerListViewController : UIViewController
    <UITableViewDataSource,UITableViewDelegate>
{        
    UITableView *customerListTableView;
//    NSDictionary *customerDictionary;
    NSArray *customersArray;
    UIButton *backButton;
//    UIView *navigationView;
//    CustomerDetailsViewController *customerDetailVCObject;
}

//@property (nonatomic,retain) CustomerDetailsViewController *customerDetailVCObject;

@end
