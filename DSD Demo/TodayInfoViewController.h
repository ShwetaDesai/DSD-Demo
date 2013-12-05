//
//  TodayInfoViewController.h
//  DSD Demo
//
//  Created by Shweta on 31/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownOptionsViewController.h"
#define COUNT_TODAY_SECTION_2   9


@interface TodayInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, DropDownOptionsViewControllerDelegate, NSURLConnectionDelegate>
{
    UITableView *todayInfoTableView;
    NSArray *titleItemsArray , *valueArray;
    UITextField *_dataTextFields[COUNT_TODAY_SECTION_2];
    UIPopoverController *_popOverController;
    DropDownOptionsViewController *_dropDownOptionsVC;
    NSMutableData *_responseData, *_responseDataWeather;
    NSArray *arrResponse;
    NSString *strTemperature;
    NSURLConnection *conn, *connWeather;
    BOOL _hasNetworkCallFailed;
}
@end
