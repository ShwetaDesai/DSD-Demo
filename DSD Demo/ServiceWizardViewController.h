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
<UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate, ReturnsDatabaseViewControllerDelegate, UITextFieldDelegate>
{
    NSArray *arr_NoServiceItems;
    NSMutableArray *arr_SalesOrders;
    UITableView *tbvNoService;
    UITableView *tbvSummary, *tbvSales, *tbvReturns;
    NSIndexPath *selectedRow;
    SignCaptureViewController *signatureViewControllerManager, *signatureViewControllerDriver;
//    int yPos;
    int selectedSegmentBarID;
    NSString *customerID, *selectedPallete;
    UIPopoverController *_popOverController;
    UITextField *txtFieldMatID;
    ReturnsDatabaseViewController *_returnsDatabaseVC;
//    int IDlastSelectedTab;
//    NSMutableArray *visibilityTruth;
    NSMutableArray *arrMaterials[10];
    int rowsPerSectionSales[10];
    int isSummary;
}
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedBar;
@property (nonatomic,strong)  NSString *customerID;
@property (nonatomic,strong)  NSString *selectedPallete;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;

@end
