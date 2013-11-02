//
//  ServiceWizardViewController.h
//  DSD Demo
//
//  Created by Shweta on 02/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignCaptureViewController.h"

@interface ServiceWizardViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *arr_NoServiceItems;
    UITableView *tbvNoService;
    UITableView *tbvSummary, *tbvSales, *tbvReturns;
    NSIndexPath *selectedRow;
    SignCaptureViewController *signatureViewController;
    int yPos;
    int IDlastSelectedTab,selectedSegmentBarID;
}
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedBar;

@end
