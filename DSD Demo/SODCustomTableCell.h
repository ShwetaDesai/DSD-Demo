//
//  SODCustomTableCell.h
//  NewProject
//
//  Created by ITIM Quinnox on 30/10/13.
//  Copyright (c) 2013 q-systems@quinnox.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SODCustomTableCell : UITableViewCell {
    UILabel *_lblMatID, *_lblMatDesc, *_lblMatPlannedQty;
    UITextField *_txtFieldActualCount;
    UIButton *_btnAccept;
    UIImageView *_imgViewDiscFlag;
    int _index;
}

- (void)setData:(int)index :(int)colorIndex;
    
//@property (nonatomic, strong)NSMutableDictionary *dictionaryObject;
@end
