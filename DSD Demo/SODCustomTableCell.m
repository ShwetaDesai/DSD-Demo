//
//  SODCustomTableCell.m
//  NewProject
//
//  Created by ITIM Quinnox on 30/10/13.
//  Copyright (c) 2013 q-systems@quinnox.com. All rights reserved.
//

#import "SODCustomTableCell.h"
#define OFFSET_FIELDS       5
#define WIDTH_FLAG          20
#define HEIGHT_FLAG         20
#define HEIGHT_FIELDS       22
#define HEIGHT_TXT_FIELD    44
#define WIDTH_COUNT_FIELDS  100
#define WIDTH_ACCEPT_BUTTON 100
#define HEIGHT_ACCEPT_BUTTON 34

@implementation SODCustomTableCell
//@synthesize dictionaryObject;
    
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
        
        _lblMatDesc = [[UILabel alloc] initWithFrame:CGRectMake(2*OFFSET_FIELDS, _lblMatID.frame.origin.y + _lblMatID.frame.size.height, 300, HEIGHT_FIELDS)];
        _lblMatDesc.font = [UIFont systemFontOfSize:14.0];
        _lblMatDesc.textColor = [UIColor grayColor];
        _lblMatDesc.backgroundColor = colorBG;
        
//        _imgViewDiscFlag = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - OFFSET_FIELDS - WIDTH_FLAG, frame.size.height/2 - HEIGHT_FLAG/2, WIDTH_FLAG, HEIGHT_FLAG)];
//        _imgViewDiscFlag.backgroundColor = colorBG;
//        
        _lblMatPlannedQty = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - WIDTH_COUNT_FIELDS - 2*OFFSET_FIELDS, frame.size.height/2 - HEIGHT_FLAG/2, WIDTH_COUNT_FIELDS, HEIGHT_FIELDS)];
        _lblMatPlannedQty.textAlignment = NSTextAlignmentRight;
        _lblMatPlannedQty.backgroundColor = colorBG;
        
        _txtFieldActualCount = [[UITextField alloc] initWithFrame:CGRectMake(_lblMatPlannedQty.frame.origin.x - WIDTH_COUNT_FIELDS - OFFSET_FIELDS, frame.size.height/2 - HEIGHT_TXT_FIELD/2, WIDTH_COUNT_FIELDS, HEIGHT_TXT_FIELD)];
        _txtFieldActualCount.borderStyle = UITextBorderStyleLine;
        _txtFieldActualCount.backgroundColor = colorBG;
        _txtFieldActualCount.keyboardType = UIKeyboardTypeNumberPad;
        [_txtFieldActualCount addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        
        _btnAccept = [[UIButton alloc] initWithFrame:CGRectMake(_txtFieldActualCount.frame.origin.x - WIDTH_ACCEPT_BUTTON - OFFSET_FIELDS, _txtFieldActualCount.frame.size.height/2 - HEIGHT_ACCEPT_BUTTON/2, WIDTH_ACCEPT_BUTTON, HEIGHT_ACCEPT_BUTTON)];
        [_btnAccept setTitle:@"Accept" forState:UIControlStateNormal];
        [_btnAccept addTarget:self action:@selector(acceptButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _btnAccept.backgroundColor = colorBG;
        _btnAccept.hidden = YES;
        
        [self addSubview:_lblMatID];
        [self addSubview:_lblMatDesc];
        [self addSubview:_txtFieldActualCount];
        [self addSubview:_lblMatPlannedQty];
        [self addSubview:_btnAccept];
//        [self addSubview:_imgViewDiscFlag];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(int)indexID :(int)colorIndex {
    _index = indexID;
    NSDictionary *dictionaryObject = [arrOrders objectAtIndex:_index];
    _lblMatID.text = [dictionaryObject valueForKey:JSONTAG_MAT_NO];
    _lblMatDesc.text = [dictionaryObject valueForKey:JSONTAG_MAT_DESC];
    _lblMatPlannedQty.text = [dictionaryObject valueForKey:JSONTAG_MAT_ACTUAL_COUNT];
    _txtFieldActualCount.text = [NSString stringWithFormat:@"%d", enteredValues[_index]]; //[dictionaryObject valueForKey:JSONTAG_EXTFLD4_EXPECTED];
    
    switch (colorIndex) {
        case 0: {
            self.backgroundColor = [UIColor whiteColor];
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
    NSLog(@"_txtFieldActualCount.text :: %@", _txtFieldActualCount.text);
    
    enteredValues[_index] = [_txtFieldActualCount.text intValue];
}

- (void)acceptButtonClicked {
    acceptedValues[_index] = 1;
    self.backgroundColor = [UIColor lightGrayColor];
    _btnAccept.hidden = YES;
}
@end
