//
//  ViewController.h
//  DSD Demo
//
//  Created by Shweta on 26/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayInfoViewController.h"
#import "CustomerListViewController.h"
#import "SODViewControllerViewController.h"

#import "ServiceWizardViewController.h"
#import "CustomerDetailsViewController.h"
#import "AppDelegate.h"
//#import "EODViewControllerViewController.h"
#import "EODModifiedViewController.h"
#import "SODPaletteViewController.h"

@interface ViewController : UIViewController
{
    int tagNoButtonSelected;
    TodayInfoViewController *todayTableViewController;
    CustomerListViewController *customerViewC;
    SODPaletteViewController *sodpaletteViewController;
    ServiceWizardViewController *wizardVC;
    CustomerDetailsViewController *customerDetailVC;
    //EODViewControllerViewController *eodViewController;
    EODModifiedViewController *eodModifiedViewController;

}
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIButton *btn_Today;
@property (strong, nonatomic) IBOutlet UIButton *btn_SOD;
@property (strong, nonatomic) IBOutlet UIButton *btn_ServiceOutlet;
@property (strong, nonatomic) IBOutlet UIButton *btn_EOD;

@end
