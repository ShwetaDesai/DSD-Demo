//
//  ReturnsDatabaseViewController.h
//  DSD Demo
//
//  Created by Shahil Shah on 05/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReturnsDatabaseViewController : UITableViewController {
    id _parentDelegate;
}

@property (nonatomic, strong)id parentDelegate;
@end

@protocol ReturnsDatabaseViewControllerDelegate <NSObject>

- (void)returnsItemSelected:(NSString*)strReturnsName;

@end
