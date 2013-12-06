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

#define nServiceOutletButtonClicked @"nServiceOutletButtonClicked"

#define nShowCustomerDetailsView @"nShowCustomerDetailsView"
#define nShowCustomerListView @"nShowCustomerListView"
#define nSoldQtyUpdate @"nSoldQtyUpdate"
#define nCustomerServiceComplete @"nCustomerServiceComplete"
#define nPalleteDetailScreenCalled @"nPalleteDetailScreenCalled"
#define nPassingPalletID @"nPassingPalletID"
#define nBackButtonPressed @"nBackButtonPressed"
#define nMaterialScanCompleted @"nMaterialScanCompleted"
#define nNavigateBackToPalletScreen @"nNavigateBackToPalletScreen"

typedef enum viewType {
    SOD, EOD, CUSTOMER, RETURNS, SALES
} EnumViewType;

NSMutableArray *arrOrders, *arrReturns[2], *palletIDs, *palletImageCheck;
int enteredValues[30], acceptedValues[30], deliveredValues[2][30];
int returnsValues[2][4];


#define TEXT_TEMPERATURE            @"%@  F                   AAT %@ F                   Set %@ F                  Source %@ F"
#define TEXT_TEMPERATURE_CHILLED    @"%@  F                   AAT %@ F            Set %@ F                  Source        %@"

#define COLOR_THEME                 [UIColor colorWithRed:0.8706 green:0.0980 blue:0.0980 alpha:1.0]
#define COLOR_ERROR                 [UIColor colorWithRed:0.9059 green:0.4549 blue:0.4431 alpha:1.0]
#define COLOR_CELL_BACKGROUND       [UIColor colorWithRed:0.2745 green:0.2745 blue:0.2745 alpha:1.0]
#define COLOR_CELL_TEXT             [UIColor colorWithRed:0.8941 green:0.8941 blue:0.8941 alpha:1.0]
#define COLOR_CELL_SUBTITLE         [UIColor colorWithRed:0.9569 green:0.8431 blue:0.6275 alpha:1.0]
#define COLOR_CELL_HEADER           [UIColor colorWithRed:0.3922 green:0.3922 blue:0.3922 alpha:1.0]

#define kLeftMargin                             10.0
#define kTopMargin                              10.0
#define kTextFieldWidth                         100.0
#define kTextFieldHeight                        25.0


#define JSONTAG_MAT_NO              @"MAT_NO"
#define JSONTAG_MAT_DESC            @"MAT_DESC1"
#define JSONTAG_MAT_ACTUAL_COUNT    @"EXTFLD4"
#define JSONTAG_MAT_PLANNED_COUNT   @"mat_planned_count"
#define JSONTAG_MAT_DISC_ACCEPT     @"mat_disc_accept"
#define JSONTAG_EXTFLD4_EXPECTED    @"EXTFLD4_EXPECTED"
#define JSONTAG_EXTFLD4_COUNT       @"EXTFLD4_COUNT"
#define JSONTAG_PALLET_NO           @"PAT_NO"
#define JSONTAG_USER_ENTERED        @"USER_ENTERED"
#define JSONTAG_CUSTOMER_ENTERED    @"CUSTOMER_ENTERED"
#endif
