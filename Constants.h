//
//  Constants.h
//  DSD Demo
//
//  Created by Shweta on 31/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#ifndef DSD_Demo_Constants_h
#define DSD_Demo_Constants_h

#define x_Pos 25
#define y_Pos 25
#define tableWidth 790
#define row_Height_TodayTableView 50
#define font_TodayTableView 19
//#define height_CustomerTableSectionHeader 19
NSMutableArray *arrOrders;
int enteredValues[6], acceptedValues[6];

#define COLOR_THEME [UIColor colorWithRed:0.8706 green:0.0980 blue:0.0980 alpha:1.0]
#define COLOR_ERROR [UIColor colorWithRed:0.9059 green:0.4549 blue:0.4431 alpha:1.0]


#define JSONTAG_MAT_NO              @"MAT_NO"
#define JSONTAG_MAT_DESC            @"MAT_DESC1"
#define JSONTAG_MAT_ACTUAL_COUNT    @"EXTFLD4"
#define JSONTAG_MAT_PLANNED_COUNT   @"mat_planned_count"
#define JSONTAG_MAT_DISC_ACCEPT     @"mat_disc_accept"
#define JSONTAG_EXTFLD4_EXPECTED    @"EXTFLD4_EXPECTED"
#define JSONTAG_EXTFLD4_COUNT       @"EXTFLD4_COUNT"
#endif
