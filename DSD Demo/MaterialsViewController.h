//
//  MaterialsViewController.h
//  DSD Demo
//
//  Created by Shahil Shah on 04/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaterialsViewController : UITableViewController {
    id _parentDelegate;
}

@property (nonatomic, strong)id parentDelegate;
@end

@protocol MaterialsViewControllerDelegate <NSObject>

- (void)materialSelected:(NSString*)strMaterialID;

@end