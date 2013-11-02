//
//  Order.h
//  DSD Demo
//
//  Created by Shweta on 02/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject
{
    NSString *matNo, *customerNo, *matDesc;
    int reqrdQty, placedQty;
}

@property (nonatomic,retain) NSString* matNo;
@property (nonatomic,retain) NSString* customerNo;
@property (nonatomic,retain) NSString* matDesc;
@property (assign) int reqrdQty;
@property (assign) int placedQty;

@end
