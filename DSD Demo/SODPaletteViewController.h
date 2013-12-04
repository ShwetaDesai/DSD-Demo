//
//  SODPaletteViewController.h
//  DSD Demo
//
//  Created by Radhika Bhangaonkar on 28/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SODViewControllerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZBarSDK.h"

@interface SODPaletteViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,AVCaptureMetadataOutputObjectsDelegate>{
    
    SODViewControllerViewController *sodViewController;
    UITextField *txtFieldPaletteID;
    BOOL _isEditable, _confirmFlag;
    
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;
}

@end
