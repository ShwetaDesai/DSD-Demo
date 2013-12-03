//
//  SODPaletteCustomTableCell.h
//  DSD Demo
//
//  Created by Radhika Bhangaonkar on 28/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SODPaletteCustomTableCell : UITableViewCell{
    
    UIImageView *_imgViewCheckbox;
    
}
-(void)setPalletID:(int)index;


@property (nonatomic,strong) UILabel *lblPaletteId;
@property (nonatomic,strong) UILabel *lblPalette;
@property (nonatomic,strong)UIImageView *imgViewCheckbox;

@end
