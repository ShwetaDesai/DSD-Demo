//
//  SODPaletteCustomTableCell.m
//  DSD Demo
//
//  Created by Radhika Bhangaonkar on 28/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "SODPaletteCustomTableCell.h"


@implementation SODPaletteCustomTableCell

@synthesize lblPalette=_lblPalette;
@synthesize lblPaletteId=_lblPaletteId;
@synthesize imgViewCheckbox=_imgViewCheckbox;

- (id)initWithFrame:(CGRect)frame
{
    //    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self = [super initWithFrame:frame];
    UIColor *colorBG = [UIColor clearColor];
    
    
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
        
        _lblPalette = [[UILabel alloc] initWithFrame:CGRectMake(30, (self.frame.size.height)/2, 250, 20)];
        _lblPalette.font = [UIFont boldSystemFontOfSize:18.0];
        [_lblPalette setTextColor:[UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:228.0/255.0]];
        _lblPalette.backgroundColor = colorBG;

        
        _lblPaletteId = [[UILabel alloc] initWithFrame:CGRectMake(125, (self.frame.size.height)/2, 250, 20)];
        _lblPaletteId.font = [UIFont boldSystemFontOfSize:18.0];
        [_lblPaletteId setTextColor:[UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:228.0/255.0]];
        _lblPaletteId.backgroundColor = colorBG;
        _lblPaletteId.tag=100;

        _imgViewCheckbox = [[UIImageView alloc]initWithFrame:CGRectMake(600, (self.frame.size.height)/2, 20, 20)];
        _imgViewCheckbox.image = [UIImage imageNamed:@"uncheck.png"];
        
        
        [self addSubview:_lblPaletteId];
        [self addSubview:_imgViewCheckbox];
        [self addSubview:_lblPalette];
        
    }
    
    return self;
}
-(void)setPalletID:(int)index{
    
    _lblPaletteId.text = [palletIDs objectAtIndex:index];
    _lblPalette.text = [NSString stringWithFormat:@"%d",index+1];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
