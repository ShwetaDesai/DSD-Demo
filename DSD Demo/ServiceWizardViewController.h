//
//  ServiceWizardViewController.h
//  DSD Demo
//
//  Created by Shweta on 02/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignCaptureViewController.h"
#import "ReturnsDatabaseViewController.h"

@interface ServiceWizardViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate, ReturnsDatabaseViewControllerDelegate>
{
    NSArray *arr_NoServiceItems;
    NSMutableArray *arr_SalesOrders;
    UITableView *tbvNoService;
    UITableView *tbvSummary, *tbvSales, *tbvReturns;
    NSIndexPath *selectedRow;
    SignCaptureViewController *signatureViewController;
//    int yPos;
    int selectedSegmentBarID;
    NSString *customerID;
    UIPopoverController *_popOverController;
    ReturnsDatabaseViewController *_returnsDatabaseVC;
//    int IDlastSelectedTab;
//    NSMutableArray *visibilityTruth;
}
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedBar;
@property (nonatomic,strong)   NSString *customerID;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;

@end
