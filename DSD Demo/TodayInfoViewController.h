//
//  TodayInfoViewController.h
//  DSD Demo
//
//  Created by Shweta on 31/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *todayInfoTableView;
    NSArray *titleItemsArray , *valueArray;
}
@end
