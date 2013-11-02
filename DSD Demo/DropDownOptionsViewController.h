//
//  DropDownOptionsViewController.h
//  DSD Demo
//
//  Created by Shahil Shah on 02/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownOptionsViewController : UITableViewController {
    id _parentDelegate;
    int _index;
}

@property (nonatomic, strong)id parentDelegate;
@property (nonatomic)int index;
@end

@protocol DropDownOptionsViewControllerDelegate <NSObject>
@required
- (void)optionSelected:(NSString*)strValue textFieldTag:(int)tag;
@end