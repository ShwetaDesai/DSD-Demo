//
//  SODCustomTableCell.m
//  NewProject
//
//  Created by ITIM Quinnox on 30/10/13.
//  Copyright (c) 2013 q-systems@quinnox.com. All rights reserved.
//

#import "SODCustomTableCell.h"
#import "AppDelegate.h"

#define OFFSET_FIELDS       7.5
#define WIDTH_FLAG          20
#define HEIGHT_FLAG         20
#define HEIGHT_FIELDS       22
#define HEIGHT_TXT_FIELD    34
#define WIDTH_COUNT_FIELDS  100
#define WIDTH_ACCEPT_BUTTON 100
#define HEIGHT_ACCEPT_BUTTON 34

@implementation SODCustomTableCell
@synthesize txtFieldActualCount = _txtFieldActualCount, enumViewType = _enumViewType, dictSalesObj = _dictSalesObj;
NSString *arrReturnItems[4] = {@"Expired Crate", @"Empty bottle Crate", @"Broken Bottles", @"Incorrect Crate"};


//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
- (id)initWithFrame:(CGRect)frame
{
    //    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self = [super initWithFrame:frame];
    UIColor *colorBG = [UIColor clearColor];
    if (self) {
        
        // Initialization code
        _lblMatID = [[UILabel alloc] initWithFrame:CGRectMake(2*OFFSET_FIELDS, OFFSET_FIELDS, 200, HEIGHT_FIELDS)];
        _lblMatID.font = [UIFont boldSystemFontOfSize:18.0];
        _lblMatID.backgroundColor = colorBG;
        [_lblMatID setTextColor:[UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:228.0/255.0]];
        
        _lblMatDesc = [[UILabel alloc] initWithFrame:CGRectMake(2*OFFSET_FIELDS, _lblMatID.frame.origin.y + _lblMatID.frame.size.height, 300, HEIGHT_FIELDS)];
        _lblMatDesc.font = [UIFont systemFontOfSize:14.0];
        _lblMatDesc.textColor = [UIColor grayColor];
        _lblMatDesc.backgroundColor = colorBG;
        [_lblMatDesc setTextColor:[UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:228.0/255.0]];
        
        //        _imgViewDiscFlag = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - OFFSET_FIELDS - WIDTH_FLAG, frame.size.height/2 - HEIGHT_FLAG/2, WIDTH_FLAG, HEIGHT_FLAG)];
        //        _imgViewDiscFlag.backgroundColor = colorBG;
        //
        _lblMatPlannedQty = [[UILabel alloc] initWithFrame:CGRectMake(600, frame.size.height/2 - HEIGHT_FLAG/2, WIDTH_COUNT_FIELDS, HEIGHT_FIELDS)];
        _lblMatPlannedQty.backgroundColor = colorBG;
        [_txtFieldActualCount setTextAlignment:NSTextAlignmentLeft];
        [_lblMatPlannedQty setTextColor:[UIColor colorWithRed:244.0/255.0 green:215.0/255.0 blue:160.0/255.0 alpha:1.0]];
        
        _txtFieldActualCount = [[UITextField alloc] initWithFrame:CGRectMake(300, frame.size.height/2 - HEIGHT_TXT_FIELD/2, WIDTH_COUNT_FIELDS, HEIGHT_TXT_FIELD)];
        _txtFieldActualCount.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_txtFieldActualCount setTextAlignment:NSTextAlignmentCenter];
        [_txtFieldActualCount setTextColor:[UIColor colorWithRed:244.0/255.0 green:215.0/255.0 blue:160.0/255.0 alpha:1.0]];
        _txtFieldActualCount.layer.borderWidth= 0.8f;
        _txtFieldActualCount.keyboardType = UIKeyboardTypeNumberPad;
        _txtFieldActualCount.delegate = self;
        [_txtFieldActualCount addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        
        _btnAccept = [[UIButton alloc] initWithFrame:CGRectMake(_txtFieldActualCount.frame.origin.x - WIDTH_ACCEPT_BUTTON - OFFSET_FIELDS, _txtFieldActualCount.frame.size.height/2 - HEIGHT_ACCEPT_BUTTON/2, WIDTH_ACCEPT_BUTTON, HEIGHT_ACCEPT_BUTTON)];
        [_btnAccept setTitle:@"Accept" forState:UIControlStateNormal];
        [_btnAccept addTarget:self action:@selector(acceptButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _btnAccept.backgroundColor = colorBG;
        [_btnAccept setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _btnAccept.hidden = YES;
        
        [self addSubview:_lblMatID];
        [self addSubview:_lblMatDesc];
        [self addSubview:_txtFieldActualCount];
        [self addSubview:_lblMatPlannedQty];
        [self addSubview:_btnAccept];
        [self addSubview:_imgViewDiscFlag];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setDataForRow:(int)indexID forOrder:(Order*)orderItem{
    _index = indexID;
    _lblMatID.text = orderItem.matNo;
    _lblMatDesc.text = orderItem.matDesc;
    _lblMatPlannedQty.text = [NSString stringWithFormat:@"%d",orderItem.reqrdQty];
    _txtFieldActualCount.text = @""; //[NSString stringWithFormat:@"%d", enteredValues[_index]];
    self.backgroundColor = [UIColor whiteColor];
    
}

- (void)setDataReturns:(NSDictionary*)dict :(int)indexID {
    _lblMatID.text = [dict valueForKey:@"item"];
    _lblMatDesc.text = [dict valueForKey:@"desc"];
    _txtFieldActualCount.text = [dict valueForKey:@"value"];
    _index = indexID;
}

- (void)setData:(NSDictionary*)dictionaryObject {
    _dictSalesObj = dictionaryObject;
    self.backgroundColor = COLOR_CELL_BACKGROUND;
    _lblMatID.text = [dictionaryObject valueForKey:JSONTAG_MAT_NO];
    _lblMatDesc.text = [dictionaryObject valueForKey:JSONTAG_MAT_DESC];
    _lblMatPlannedQty.text = [dictionaryObject valueForKey:JSONTAG_MAT_ACTUAL_COUNT];
    _txtFieldActualCount.text = [dictionaryObject valueForKey:JSONTAG_CUSTOMER_ENTERED];
}

- (void)setData:(int)indexID :(int)colorIndex :(BOOL)isChecked{
    if (_enumViewType == RETURNS) {
        _lblMatID.text = arrReturnItems[indexID];
        _returnsIndex = colorIndex;
        _index = indexID;
        return;
    }
    _index = indexID;
    NSDictionary *dictionaryObject = [arrOrders objectAtIndex:_index];
    _lblMatID.text = [dictionaryObject valueForKey:JSONTAG_MAT_NO];
    _lblMatDesc.text = [dictionaryObject valueForKey:JSONTAG_MAT_DESC];
    _lblMatPlannedQty.text = [dictionaryObject valueForKey:JSONTAG_MAT_ACTUAL_COUNT];
    
    switch (_enumViewType) {
            
        case SOD: {
//            if (isChecked) {
//                _txtFieldActualCount.text = _lblMatPlannedQty.text;
//            }
//            else {
                NSDictionary *dict = [arrOrders objectAtIndex:_index];
//                _txtFieldActualCount.text = [NSString stringWithFormat:@"%d", enteredValues[_index]];
                _txtFieldActualCount.text = [NSString stringWithFormat:@"%@", [dict valueForKey:JSONTAG_USER_ENTERED]];
//            }
            break;
        }
            
        case EOD: {
            AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
            NSLog(@"appObject.rowCustomerListSelected :: %d", appObject.rowCustomerListSelected);
            _txtFieldActualCount.text = [NSString stringWithFormat:@"%d", deliveredValues[appObject.rowCustomerListSelected][_index]];
            break;
        }
        default:
            _txtFieldActualCount.text = @"";
            break;
    }
    
    
    
    switch (colorIndex) {
        case 0: {
            self.backgroundColor = COLOR_CELL_BACKGROUND;
            break;
        }
        case 1: {
            self.backgroundColor = COLOR_ERROR;
            if (acceptedValues[_index] != 1) {
                _btnAccept.hidden = NO;
            }
            break;
        }
        case 2: {
            self.backgroundColor = [UIColor lightGrayColor];
            break;
        }
    }
}

- (void)textFieldDidChange {
    if (_enumViewType == SOD) {
        NSMutableDictionary *dict = [[arrOrders objectAtIndex:_index] mutableCopy];
        [dict setValue:_txtFieldActualCount.text forKey:JSONTAG_USER_ENTERED];
        [arrOrders replaceObjectAtIndex:_index withObject:dict];
    }

    if (_enumViewType == RETURNS) {
        returnsValues[_returnsIndex][_index] = [_txtFieldActualCount.text intValue];
        NSLog(@"%d -- %d", _returnsIndex, _index);
    }
    
    if (_enumViewType == SALES) {
        for (int i=0; i<[arrOrders count]; i++) {
            NSMutableDictionary *dict = [[arrOrders objectAtIndex:i] mutableCopy];
            if ([[dict valueForKey:JSONTAG_PALLET_NO] isEqualToString:[_dictSalesObj valueForKey:JSONTAG_PALLET_NO]]) {
                if ([[dict valueForKey:JSONTAG_MAT_NO] isEqualToString:[_dictSalesObj valueForKey:JSONTAG_MAT_NO]]) {
                    [dict setObject:_txtFieldActualCount.text forKey:JSONTAG_CUSTOMER_ENTERED];
                    [arrOrders replaceObjectAtIndex:i withObject:dict];
                    break;
                }
            }
        }
    }
}

//-(void)textFieldDidEndEditing:(UITextField *)textField{
////    int indexValue = _index;
////    
////    NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:_txtFieldActualCount.text,[NSString stringWithFormat:@"%d",indexValue], nil]
////                                                     forKeys:[NSArray arrayWithObjects:@"placedQty",@"indexPath", nil]];
////    
////    [[NSNotificationCenter defaultCenter] postNotificationName:nSoldQtyUpdate object:nil  userInfo:dict];
//}

- (void)acceptButtonClicked {
    acceptedValues[_index] = 1;
    self.backgroundColor = [UIColor lightGrayColor];
    _btnAccept.hidden = YES;
}
@end
