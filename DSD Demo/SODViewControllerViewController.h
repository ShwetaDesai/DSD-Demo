//
//  SODViewControllerViewController.h
//  NewProject
//
//  Created by ITIM Quinnox on 30/10/13.
//  Copyright (c) 2013 q-systems@quinnox.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialsViewController.h"

@interface SODViewControllerViewController : UITableViewController <UITextFieldDelegate, MaterialsViewControllerDelegate> {
    BOOL _confirmFlag, _isEditable;
    UIPopoverController *_popOverController;
    MaterialsViewController *_materialsViewController;
}

@end
