//
//  SODPaletteCustomTableCell.m
//  DSD Demo
//
//  Created by Radhika Bhangaonkar on 28/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "SODPaletteCustomTableCell.h"


@implementation SODPaletteCustomTableCell

- (id)initWithFrame:(CGRect)frame
{
    //    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self = [super initWithFrame:frame];
    UIColor *colorBG = [UIColor clearColor];
    if (self) {
        
        _lblPaletteId = [[UILabel alloc] initWithFrame:CGRectMake(50, (self.frame.size.height)/2, 250, 20)];
        _lblPaletteId.font = [UIFont boldSystemFontOfSize:18.0];
        _lblPaletteId.backgroundColor = colorBG;
        [_lblPaletteId setText:@"1234567891234567"];
        
        
        _imgViewCheckbox = [[UIImageView alloc]initWithFrame:CGRectMake(400, (self.frame.size.height)/2, 20, 20)];
        _imgViewCheckbox.backgroundColor = [UIColor redColor];
        
        [self addSubview:_lblPaletteId];
        [self addSubview:_imgViewCheckbox];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
