//
//  SODViewControllerViewController.h
//  NewProject
//
//  Created by ITIM Quinnox on 30/10/13.
//  Copyright (c) 2013 q-systems@quinnox.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialsViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SODViewControllerViewController : UITableViewController <UITextFieldDelegate, MaterialsViewControllerDelegate, AVCaptureMetadataOutputObjectsDelegate> {
    BOOL _confirmFlag, _isEditable;
    UIPopoverController *_popOverController;
    MaterialsViewController *_materialsViewController;
    UITextField *txtFieldMatID;
    
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;
}

@end
