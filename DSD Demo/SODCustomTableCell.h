//
//  SODCustomTableCell.h
//  NewProject
//
//  Created by ITIM Quinnox on 30/10/13.
//  Copyright (c) 2013 q-systems@quinnox.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface SODCustomTableCell : UITableViewCell <UITextFieldDelegate> {
    UILabel *_lblMatID, *_lblMatDesc, *_lblMatPlannedQty;
    UITextField *_txtFieldActualCount;
    UIButton *_btnAccept;
    UIImageView *_imgViewDiscFlag;
    int _index, _returnsIndex;
    EnumViewType _enumViewType;
    NSDictionary *_dictSalesObj;
}

@property (nonatomic, strong) UITextField *txtFieldActualCount;
@property (nonatomic)EnumViewType enumViewType;
@property (nonatomic, strong) NSDictionary *dictSalesObj;

- (void)setData:(int)index :(int)colorIndex :(BOOL)isChecked;
- (void)setDataReturns:(NSDictionary*)dict :(int)index;
- (void)setDataForRow:(int)indexID forOrder:(Order*)orderItem;
- (void)setData:(NSDictionary*)dictionaryObject;
//@property (nonatomic, strong)NSMutableDictionary *dictionaryObject;
@end
