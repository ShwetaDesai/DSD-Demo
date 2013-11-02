//
//  SignCaptureViewController.h
//  Insurance POC
//
//  Created by Shweta on 21/09/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

//Taken from http://www.mysamplecode.com/2013/05/ios-smooth-signature-capture-example.html
//http://www.ifans.com/forums/threads/tutorial-drawing-to-the-screen.132024/

#import <UIKit/UIKit.h>

@interface SignCaptureViewController : UIViewController

@property (nonatomic, strong) UIImageView *mySignatureImage;
@property (nonatomic, assign) CGPoint lastContactPoint1, lastContactPoint2, currentPoint;
@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, assign) BOOL fingerMoved;
@property (nonatomic, assign) float navbarHeight;

@end
