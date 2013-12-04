//
//  ServiceWizardViewController.m
//  DSD Demo
//
//  Created by Shweta on 02/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "ServiceWizardViewController.h"
#import "AppDelegate.h"
#import "Customer.h"
#import "Order.h"
#import "SODCustomTableCell.h"
#define COUNT_RETURNS_ITEMS_     4

@interface ServiceWizardViewController ()

@end

@implementation ServiceWizardViewController
@synthesize segmentedBar, customerID;
//NSString *arrReturnItems1[4] = {@"Expired Crate", @"Empty bottle Crate", @"Broken Bottles", @"Incorrect Crate"};

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isSummary = 0;
        arr_NoServiceItems = [NSArray arrayWithObjects:@"Late delivery",@"Delivery refusal by customer",@"Quality problem",@"Wrong load",@"Product not ordered",@"Others", nil];
        
        arr_SalesOrders = [[NSMutableArray alloc] init];
        selectedRow = nil;
        
        _returnsDatabaseVC = [[ReturnsDatabaseViewController alloc] initWithStyle:UITableViewStylePlain];
        _returnsDatabaseVC.parentDelegate = self;
        _popOverController = [[UIPopoverController alloc] initWithContentViewController:_returnsDatabaseVC];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_CELL_BACKGROUND;

    for (int i=0; i<10; i++) {
        arrMaterials[i] = [[NSMutableArray alloc] init];
        rowsPerSectionSales[i] = 0;
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSoldQuantity:) name:nSoldQtyUpdate object:nil];

    customerID =  ((AppDelegate*)[[UIApplication sharedApplication] delegate]).customerToServicID;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:19], NSFontAttributeName,nil];
    segmentedBar.backgroundColor = [UIColor clearColor];
//    [segmentedBar addTarget:self
//                         action:@selector(segmentedBarClicked:)
//               forControlEvents:UIControlEventValueChanged];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    //dont set as 0, 1
//    sales = 2
//    returns = 3
    // nosale = 4
    // summary = 5
//    visibilityTruth = [[NSMutableArray alloc] initWithObjects:@"NO",@"NO",@"NO",@"NO", nil];
    
//      IDlastSelectedTab = -2000000000;
            segmentedBar.selectedSegmentIndex = 0;
    [self onClickSalesTab];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)segmentedBarClicked:(UISegmentedControl*)control{
//    selectedSegmentBarID = control.selectedSegmentIndex;
//    if(control.selectedSegmentIndex == 2){
//        [self onClickNoSaleTab];
//    }else if (control.selectedSegmentIndex == 3){
//        [self onClickSummaryTab];
//    }else if (control.selectedSegmentIndex == 0){
//        [self onClickSalesTab];
//    }
//}

-(void) onClickNoSaleTab {
    
    for (int i=0; i < 2; i++) {
        for (int j=0; j<4; j++) {
            NSLog(@"returnsValues :: %d", returnsValues[i][j]);
        }
    }
    [[self.view viewWithTag:6666] removeFromSuperview];
//    [[self.view viewWithTag:2222] removeFromSup];
        tbvNoService = [[UITableView alloc] initWithFrame:CGRectMake(5, 55, tableWidth - 10, [arr_NoServiceItems count] *row_Height_TodayTableView) style:UITableViewStylePlain];
        tbvNoService.dataSource = self;
        tbvNoService.delegate = self;
        tbvNoService.tag = 3333;
        [self.view addSubview:tbvNoService];
}

-(void) onClickSalesTab {
    [self prepareDataForSalesTable];
        tbvSales = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, tableWidth, 350) style:UITableViewStyleGrouped];
    tbvSales.backgroundView = nil;
    tbvSales.backgroundColor = COLOR_CELL_BACKGROUND;
        tbvSales.dataSource = self;
        tbvSales.delegate = self;
    tbvSales.tag = 1111;
//    tbvSales.tableHeaderView = [self salesFooter];
    [self.view addSubview:tbvSales];
}

-(void)prepareDataForSalesTable{
    AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    Customer *cust = (Customer*)[appObject.customersToService objectAtIndex:appObject.rowCustomerListSelected];
    NSLog(@"cust.palleteIDs :: %@", cust.palleteIDs);
    
    for (int i=0; i<[arrOrders count]; i++) {
        NSDictionary *dict = [arrOrders objectAtIndex:i];
        
        for (int j=0; j<[cust.palleteIDs count]; j++) {
            if ([[dict valueForKey:JSONTAG_PALLET_NO] isEqualToString:[cust.palleteIDs objectAtIndex:j]]) {
                [arr_SalesOrders addObject:dict];
                rowsPerSectionSales[j]++;
//                [arrMaterials[j] addObject:dict];
            }
        }
    }
    [tbvSales reloadData];
//    NSArray *tarr = [NSArray arrayWithArray:appObject.ordersPlaced];
//    
//    for (int i = 0; i <[tarr count]; i++) {
//        Order *temp = (Order*)[tarr objectAtIndex:i];
//        if ([customerID isEqualToString:temp.customerNo]) {
//            [arr_SalesOrders addObject:[tarr objectAtIndex:i]];
//        }
//    }
}

-(void) onClickSummaryTab {

    [[self.view viewWithTag:6666] removeFromSuperview];//3333
//    UIScrollView *scv = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 55, tableWidth, 500)];
//    scv.scrollEnabled = YES;
//    scv.indicatorStyle = UIScrollViewIndicatorStyleBlack;
//    scv.showsVerticalScrollIndicator = YES;
//    scv.contentSize = CGSizeMake(tableWidth, 900);
    
//    yPos = [arr_SalesOrders count]*50;
//    tbvSummary = [[UITableView alloc] initWithFrame:CGRectMake(5, 55, tableWidth - 20, (2+[arr_SalesOrders count])*50) style:UITableViewStyleGrouped];
//
//    tbvSummary.dataSource = self;
//    tbvSummary.delegate = self;
//    tbvSummary.tag = 4444;
//    [scv addSubview:tbvSummary];
//    [self.view addSubview:tbvSummary];
//    [self showSignCaptureTool];
//    [self.view  addSubview:signatureViewController.view];
//        [scv addSubview:signatureViewController.view];
//    
//    UIButton  *acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    acceptButton.titleLabel.text = @"Accept and Print Invoice";
//    acceptButton.titleLabel.textColor = [UIColor redColor];
//    
//    [acceptButton setFrame:CGRectMake(75,yPos, 200, 30)];
//    [scv addSubview:acceptButton];
    isSummary = 1;
    [self.view addSubview:tbvSales];
    [tbvSales reloadData];
//        [self.view  addSubview:acceptButton];
}


-(void)showSignCaptureTool {
        [[self.view viewWithTag:1111] removeFromSuperview]; //4444
    signatureViewControllerManager = [[SignCaptureViewController alloc] init];
    [signatureViewControllerManager.view setFrame:CGRectMake(5, 55 , tableWidth/2 - 10 , 200)];
    signatureViewControllerManager.view.backgroundColor = [UIColor colorWithRed:58.0/255.0
                                                                   green:134.0/255.0
                                                                    blue:206.0/255.0
                                                                   alpha:0.39];
//    yPos+=30+150+20;
    signatureViewControllerManager.view.layer.borderWidth = 1.0;
    signatureViewControllerManager.view.layer.borderColor = [[UIColor blueColor] CGColor];
    signatureViewControllerManager.view.layer.cornerRadius = 5.0;
    signatureViewControllerManager.view.layer.masksToBounds = YES;
    signatureViewControllerManager.view.tag = 5555;
    
    UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(5, 200-44, tableWidth/2-10, 44)];
    lblText.backgroundColor = [UIColor clearColor];
    lblText.textAlignment = NSTextAlignmentCenter;
    lblText.text = @"Store Manager's Signature";
    [signatureViewControllerManager.view addSubview:lblText];
    
    [self.view addSubview:signatureViewControllerManager.view];
    
    
    signatureViewControllerDriver = [[SignCaptureViewController alloc] init];
    [signatureViewControllerDriver.view setFrame:CGRectMake(tableWidth/2+5, 55 , tableWidth/2 - 10 , 200)];
    signatureViewControllerDriver.view.backgroundColor = [UIColor colorWithRed:58.0/255.0
                                                                          green:134.0/255.0
                                                                           blue:206.0/255.0
                                                                          alpha:0.39];
    //    yPos+=30+150+20;
    signatureViewControllerDriver.view.layer.borderWidth = 1.0;
    signatureViewControllerDriver.view.layer.borderColor = [[UIColor blueColor] CGColor];
    signatureViewControllerDriver.view.layer.cornerRadius = 5.0;
    signatureViewControllerDriver.view.layer.masksToBounds = YES;
    signatureViewControllerDriver.view.tag = 55551;
    
    UILabel *lblText1 = [[UILabel alloc] initWithFrame:CGRectMake(tableWidth/2+5, 200-44, tableWidth/2-10, 44)];
    lblText1.backgroundColor = [UIColor clearColor];
    lblText1.textAlignment = NSTextAlignmentCenter;
    lblText1.text = @"Driver's Signature";
    [signatureViewControllerDriver.view addSubview:lblText1];
    
    [self.view addSubview:signatureViewControllerDriver.view];

}
#pragma mark table View methods

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == tbvSales && isSummary == 1) {
        return 44;
    }
    if (tableView == tbvReturns) {
        return 54;
    }
    if (tableView == tbvSales) {
        if (section == 0) {
            return 118;
        }
        return 64;
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == tbvSales && isSummary == 1) {
        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(10, 0, tableWidth-20, 44)];
        viewContent.backgroundColor = [UIColor clearColor];
        
        UILabel *lblMat = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 100, 34)];
        lblMat.backgroundColor = [UIColor clearColor];
        lblMat.textColor = COLOR_CELL_TEXT;
        if (section != (tbvSales.numberOfSections -1)) {
            lblMat.text = @"Material ID";

            UILabel *lblPlaced = [[UILabel alloc] initWithFrame:CGRectMake(200, 5, 100, 34)];
            lblPlaced.textColor = COLOR_CELL_TEXT;
            lblPlaced.backgroundColor = [UIColor clearColor];
            lblPlaced.text = @"Delivered";
            [viewContent addSubview:lblPlaced];
            
            UILabel *lblRequired = [[UILabel alloc] initWithFrame:CGRectMake(500, 5, 100, 34)];
            lblRequired.textColor = COLOR_CELL_TEXT;
            lblRequired.backgroundColor = [UIColor clearColor];
            lblRequired.text = @"Expected";
            [viewContent addSubview:lblRequired];
        }
        else {
            lblMat.text = @"Returns";
        }
        
        [viewContent addSubview:lblMat];
        
        return viewContent;
    }
    if (tableView == tbvReturns) {
        UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, 54)];
        viewFooter.backgroundColor = [UIColor colorWithRed:86.0/255.0 green:86.0/255.0 blue:86.0/255.0 alpha:1.0];
        
        txtFieldMatID = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, 200, 44)];
        txtFieldMatID.placeholder = @" Enter Material ID";
        txtFieldMatID.backgroundColor = [UIColor whiteColor];
        txtFieldMatID.layer.borderColor = [UIColor lightGrayColor].CGColor;
        txtFieldMatID.layer.borderWidth = 1.0;
        txtFieldMatID.delegate = self;
        txtFieldMatID.tag = 10001;
        [viewFooter addSubview:txtFieldMatID];
        
        UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnAdd.frame = CGRectMake(txtFieldMatID.frame.origin.x + txtFieldMatID.frame.size.width + 5, 5, 75, 44);
        [btnAdd addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [btnAdd setBackgroundColor:[UIColor whiteColor]];
        btnAdd.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btnAdd.layer.borderWidth = 1.0;
        [btnAdd setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btnAdd setTitle:@"ADD" forState:UIControlStateNormal];
        [viewFooter addSubview:btnAdd];
        
        return viewFooter;
    }
    if (tableView == tbvSales) {
            /*UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(10, 5, self.view.frame.size.width - 20, 98)];
            viewFooter.backgroundColor = [UIColor clearColor];
            
            txtFieldMatID = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, 200, 44)];
            txtFieldMatID.placeholder = @" Enter Material ID";
            txtFieldMatID.backgroundColor = [UIColor whiteColor];
            txtFieldMatID.layer.borderColor = [UIColor lightGrayColor].CGColor;
            txtFieldMatID.layer.borderWidth = 1.0;
            txtFieldMatID.enabled = NO;
            txtFieldMatID.tag = 10001;
            [viewFooter addSubview:txtFieldMatID];
            
            UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btnAdd.frame = CGRectMake(txtFieldMatID.frame.origin.x + txtFieldMatID.frame.size.width + 5, 5, 75, 44);
            [btnAdd setBackgroundColor:[UIColor whiteColor]];
            [btnAdd setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [btnAdd setTitle:@"ADD" forState:UIControlStateNormal];
            btnAdd.layer.borderColor = [UIColor lightGrayColor].CGColor;
            btnAdd.layer.borderWidth = 1.0;
            [viewFooter addSubview:btnAdd];
            
            UIButton *btnBarCode = [[UIButton alloc] initWithFrame:CGRectMake(btnAdd.frame.origin.x + btnAdd.frame.size.width + 5, 5, 162, 44)];
            [btnBarCode setBackgroundImage:[UIImage imageNamed:@"barcode.png"] forState:UIControlStateNormal];
            [btnBarCode addTarget:self action:@selector(btnBarCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [viewFooter addSubview:btnBarCode];
            
            return viewFooter;*/
        
        return [self salesFooter:section];
    }
    return nil;
}

- (UIView*)salesFooter:(int)section {
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 118)];
    viewFooter.backgroundColor = [UIColor colorWithRed:86.0/255.0 green:86.0/255.0 blue:86.0/255.0 alpha:1.0];
    int yOffset = 0;
    if (section == 0) {
        yOffset = 44;
        txtFieldMatID = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, 225, 44)];
        txtFieldMatID.layer.borderColor = [UIColor lightGrayColor].CGColor;
        txtFieldMatID.layer.borderWidth= 1.0f;
        [txtFieldMatID setTextAlignment:NSTextAlignmentCenter];
        txtFieldMatID.placeholder = @" Enter/Scan Pallet Number";
        [txtFieldMatID setValue:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [txtFieldMatID setTextColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0]];
        txtFieldMatID.backgroundColor = [UIColor clearColor];
        txtFieldMatID.delegate = self;
        txtFieldMatID.tag = 10001;
        [viewFooter addSubview:txtFieldMatID];
        
        UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnAdd.frame = CGRectMake(txtFieldMatID.frame.origin.x + txtFieldMatID.frame.size.width + 10, 5, 75, 44);
        [btnAdd addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [btnAdd setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:155.0/255.0 blue:1.0/255.0 alpha:1.0]];
        [btnAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnAdd setTitle:@"ADD" forState:UIControlStateNormal];
        btnAdd.font = [UIFont boldSystemFontOfSize:14.0];
        [viewFooter addSubview:btnAdd];
        
        UIButton *btnBarCode = [[UIButton alloc] initWithFrame:CGRectMake(btnAdd.frame.origin.x + btnAdd.frame.size.width + 10, 5, 64, 44)];
        [btnBarCode setBackgroundImage:[UIImage imageNamed:@"barcode.png"] forState:UIControlStateNormal];
        [btnBarCode addTarget:self action:@selector(btnBarCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [viewFooter addSubview:btnBarCode];
        
        UIButton *btnSubmit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnSubmit.frame = CGRectMake(viewFooter.frame.size.width - 145, 5, 150, 44);
        [btnSubmit addTarget:self action:@selector(submitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [btnSubmit setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:155.0/255.0 blue:1.0/255.0 alpha:1.0]];
        [btnSubmit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnSubmit setTitle:@"CONFIRM" forState:UIControlStateNormal];
        btnSubmit.font = [UIFont boldSystemFontOfSize:14.0];
    }
    else {
        viewFooter.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
    }
    
    UILabel *lblPalette = [[UILabel alloc] initWithFrame:CGRectMake(30,10 + yOffset,100, 20)];
    [lblPalette setTextColor:[UIColor colorWithRed:236.0/255.0 green:179.0/255.0 blue:93.0/255.0 alpha:1.0]];
    lblPalette.backgroundColor = [UIColor clearColor];
    [viewFooter addSubview:lblPalette];
    
    AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    Customer *cust = (Customer*)[appObject.customersToService objectAtIndex:appObject.rowCustomerListSelected];
    
    UILabel *lblPaletteID = [[UILabel alloc] initWithFrame:CGRectMake(125,10 + yOffset,200, 20)];
    [lblPaletteID setTextColor:[UIColor colorWithRed:236.0/255.0 green:179.0/255.0 blue:93.0/255.0 alpha:1.0]];
    lblPaletteID.backgroundColor = [UIColor clearColor];
    [viewFooter addSubview:lblPaletteID];
    [lblPalette setText:@"Pallet"];
    [lblPaletteID setText:[NSString stringWithFormat:@"%@", [cust.palleteIDs objectAtIndex:section]]];

    UILabel *lblMat = [[UILabel alloc] initWithFrame:CGRectMake(10, 35 + yOffset, 100, 20)];
    lblMat.backgroundColor = [UIColor clearColor];
    lblMat.textColor = COLOR_CELL_TEXT;
    lblMat.text = @"Material ID";
    [viewFooter addSubview:lblMat];
    
    UILabel *lblPlaced = [[UILabel alloc] initWithFrame:CGRectMake(300, 35 + yOffset, 100, 20)];
    lblPlaced.textColor = COLOR_CELL_TEXT;
    lblPlaced.backgroundColor = [UIColor clearColor];
    lblPlaced.text = @"Delivered";
    [viewFooter addSubview:lblPlaced];
    
    UILabel *lblRequired = [[UILabel alloc] initWithFrame:CGRectMake(650, 35 + yOffset, 100, 20)];
    lblRequired.textColor = COLOR_CELL_TEXT;
    lblRequired.backgroundColor = [UIColor clearColor];
    lblRequired.text = @"Expected";
    [viewFooter addSubview:lblRequired];
    lblMat.text = @"Returns";
    
    return viewFooter;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyCellIdentifier;
    UITableViewCell *cell;
    SODCustomTableCell *cellSOD;
    
     if (tableView == tbvSales) {
         if (isSummary ==1 && indexPath.section == (tbvSales.numberOfSections-1)) {
             MyCellIdentifier = @"Summary";
             cell = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
             if (cell == nil) {
                 cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                 cell.backgroundColor = COLOR_CELL_BACKGROUND;
             }
         }
         else {
             MyCellIdentifier = @"Sales";
             cellSOD = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
             if (!cellSOD) {
                 cellSOD = [[SODCustomTableCell alloc] initWithFrame:CGRectMake(0, 0,tableWidth - 40, 50)];
                 cellSOD.selectionStyle = UITableViewCellSelectionStyleNone;
             }
         }
     }else  if (tableView == tbvNoService) {
       MyCellIdentifier = @"NoServiceCell";
         cell = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
         if (cell == nil) {
             cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
         }

     } else  if (tableView == tbvSummary) {
         MyCellIdentifier = @"Summary";
         cell = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
         if (cell == nil) {
             cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
         }
     } else  if (tableView == tbvReturns) {
         MyCellIdentifier = @"Returns";
         cellSOD = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
         if (!cellSOD) {
             cellSOD = [[SODCustomTableCell alloc] initWithFrame:CGRectMake(0, 0,tableWidth - 40, 50)];
             cellSOD.selectionStyle = UITableViewCellSelectionStyleNone;
             cellSOD.backgroundColor = COLOR_CELL_BACKGROUND;
         }
//         cell = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
//         if (cell == nil) {
//             cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
//         }
     }
    
    // Configure the cell...
    if (tableView == tbvNoService) {
        if([selectedRow isEqual:indexPath])
            cell.accessoryType = UITableViewCellAccessoryCheckmark;      else
                cell.accessoryType = UITableViewCellAccessoryNone;
    
        cell.textLabel.text = [arr_NoServiceItems objectAtIndex:indexPath.row] ;
        cell.textLabel.font = [UIFont systemFontOfSize:font_TodayTableView];
    }
    
    if (tableView == tbvReturns) {
        AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
        NSDictionary *dict = [arrReturns[appObject.rowCustomerListSelected] objectAtIndex:indexPath.row];
        [cellSOD setDataReturns:dict :indexPath.row];
        cellSOD.enumViewType = RETURNS;
        return cellSOD;
    }
    if (tableView == tbvSales) {
        if (indexPath.section == (tbvSales.numberOfSections-1) && isSummary == 1) {
            AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
            NSDictionary *dict = [arrReturns[appObject.rowCustomerListSelected] objectAtIndex:indexPath.row];
            
            UILabel *PlacedQty = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 200, 10 ,160 ,30 )];
            PlacedQty.textColor = COLOR_CELL_TEXT;
            PlacedQty.text = [dict valueForKey:@"desc"];
            UILabel *reqQty = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 500, 10 ,200 ,30 )];
            reqQty.textColor = COLOR_CELL_TEXT;
            reqQty.text = [dict valueForKey:@"value"];
            [cell addSubview:PlacedQty];
            [cell addSubview:reqQty];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
            
            cell.textLabel.text = [dict valueForKey:@"item"];
            cell.textLabel.textColor = COLOR_CELL_TEXT;
            return cell;
        }
        int index = indexPath.row;
        for (int i=0; i<indexPath.section; i++) {
            index += rowsPerSectionSales[i];
        }
        NSDictionary *dict =  [arr_SalesOrders objectAtIndex:index];//[arrMaterials[indexPath.section] objectAtIndex:indexPath.row];
        [cellSOD setData:dict];
//        Order *o = (Order*)[arr_SalesOrders objectAtIndex:indexPath.row];
//        [cellSOD setDataForRow:indexPath.row forOrder:o];
        return cellSOD;
    }
    if (tableView == tbvSummary) {
        if (indexPath.section == 0) {
            Order *o = (Order*)[arr_SalesOrders objectAtIndex:indexPath.row];
            
            if(o.placedQty != o.reqrdQty)
                cell.backgroundColor = [UIColor yellowColor];
            
            UILabel *PlacedQty = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 200, 10 ,160 ,30 )];
            PlacedQty.text = [NSString stringWithFormat:@"%d",o.placedQty];
            UILabel *reqQty = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 500, 10 ,200 ,30 )];
            reqQty.text = [NSString stringWithFormat:@"%d",o.reqrdQty];
            [cell addSubview:PlacedQty];
            [cell addSubview:reqQty];
            
            cell.textLabel.text = o.matNo;
            cell.textLabel.font = [UIFont systemFontOfSize:font_TodayTableView];
        }
        else {
            AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
            NSDictionary *dict = [arrReturns[appObject.rowCustomerListSelected] objectAtIndex:indexPath.row];
            
            UILabel *PlacedQty = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 200, 10 ,160 ,30 )];
            PlacedQty.text = [dict valueForKey:@"desc"];
            UILabel *reqQty = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 500, 10 ,200 ,30 )];
            reqQty.text = [dict valueForKey:@"value"];
            [cell addSubview:PlacedQty];
            [cell addSubview:reqQty];
            
            cell.textLabel.text = [dict valueForKey:@"item"];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tbvNoService) {
        selectedRow = indexPath;
        [tbvNoService reloadData];
    }
//    if (tableView == tbvReturns && indexPath.row == 0) {
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        _popOverController.popoverContentSize = CGSizeMake(200, 200);
//        [_popOverController presentPopoverFromRect:cell.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//        [tbvReturns reloadData];
//    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == tbvNoService) {
            return [arr_NoServiceItems count];
    }else if (tableView == tbvSales) {
        if (isSummary && (section == (tableView.numberOfSections-1))) {
            AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
            return [arrReturns[appObject.rowCustomerListSelected] count];
        }
        return rowsPerSectionSales[section]; //[arrMaterials[section] count];
//        return [arr_SalesOrders count];
    }else  if (tableView == tbvSummary) {
        if (section == 0) {
            return [arr_SalesOrders count];
        }
        else {
            AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
            return [arrReturns[appObject.rowCustomerListSelected] count];
        }
    } else if (tableView == tbvReturns) {
        AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
//        NSLog(@"appObject.rowCustomerListSelected  :: %d", appObject.rowCustomerListSelected);
        return [arrReturns[appObject.rowCustomerListSelected] count];
    }
    return 0;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == tbvSummary) {
        return 2;
    }
    if (tableView == tbvSales) {
        AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
        Customer *cust = (Customer*)[appObject.customersToService objectAtIndex:appObject.rowCustomerListSelected];
        NSLog(@"cust.palleteIDs.count :: %d", cust.palleteIDs.count);
        return cust.palleteIDs.count + isSummary;
    }
    return 1;
}

//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (tableView == tbvSummary) {
//        if (section == 0) {
//            return @"Orders";
//        }
//        else {
//            return @"Returns";
//        }
//    }
//    return @"";
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return row_Height_TodayTableView;
}

- (IBAction)onClickconfirmButton:(id)sender {
    
    if (segmentedBar.selectedSegmentIndex == 2) {
        [segmentedBar setEnabled:YES forSegmentAtIndex:3];
        [self showSignCaptureTool];
        segmentedBar.selectedSegmentIndex = 3;
        [segmentedBar setEnabled:NO forSegmentAtIndex:2];
        return;
    }
    
    if (segmentedBar.selectedSegmentIndex == 3) {
        if(signatureViewControllerManager.mySignatureImage.image == nil) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""                                                                    message:@"Store Manager's Signature cannot be blank." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }

        if(signatureViewControllerDriver.mySignatureImage.image == nil) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""                                                                    message:@"Driver's Signature cannot be blank." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
    }
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""                                                                    message:@"Once confirmed you cannot modify the values. Click OK only if you want to proceed further. To stay on the same screen click Cancel."                                                                  delegate:nil
        cancelButtonTitle:@"Cancel"
        otherButtonTitles:@"OK", nil];
    
    alertView.delegate = self;
    [alertView show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 5656){
        
//        NSDictionary *dict = [NSDictionary dictionaryWithObject: forKey:@"customerServicedID"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:nCustomerServiceComplete object:nil];
    }else{
    if (buttonIndex == 1)// OK
    {   if (segmentedBar.selectedSegmentIndex == 0) {
            [segmentedBar setEnabled:YES forSegmentAtIndex:1];
            [self showReturnsView];
            segmentedBar.selectedSegmentIndex = 1;
            [segmentedBar setEnabled:NO forSegmentAtIndex:0];
        }else
//        if (segmentedBar.selectedSegmentIndex == 1) {
//            [segmentedBar setEnabled:YES forSegmentAtIndex:2];
//            [self onClickNoSaleTab];
//            segmentedBar.selectedSegmentIndex = 2;
//            [segmentedBar setEnabled:NO forSegmentAtIndex:1];
//        }else
            if (segmentedBar.selectedSegmentIndex == 1) {
                    [segmentedBar setEnabled:YES forSegmentAtIndex:2];
                    [self onClickSummaryTab];
                    segmentedBar.selectedSegmentIndex = 2;
                    [segmentedBar setEnabled:NO forSegmentAtIndex:1];
            }else if (segmentedBar.selectedSegmentIndex == 2){
                [segmentedBar setEnabled:YES forSegmentAtIndex:3];
                [self showSignCaptureTool];
                segmentedBar.selectedSegmentIndex = 3;
                [segmentedBar setEnabled:NO forSegmentAtIndex:2];
            }else if(segmentedBar.selectedSegmentIndex == 3){
                [self showFinalAlert];
            }
    }
    }
}

-(void)showFinalAlert{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""                                                                    message:@"Printing the Delivery Note on hand-held printer"                                                                  delegate:nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
    
    alertView.delegate = self;
    alertView.tag = 5656;
    [alertView show];
}

-(void)showAlertBox{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""                                                                    message:@"Please select any one option from the list !"                                                                  delegate:nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
    
//    alertView.delegate = self;
    [alertView show];
}
-(void)showReturnsView{
    [[self.view viewWithTag:1111] removeFromSuperview];
//create ui - pending
    
    tbvReturns = [[UITableView alloc] initWithFrame:CGRectMake(5, 55, tableWidth - 20, 6*50) style:UITableViewStylePlain];
    tbvReturns.dataSource = self;
    tbvReturns.delegate = self;
    tbvReturns.tag = 6666;
    tbvReturns.backgroundColor = COLOR_CELL_BACKGROUND;
    [self.view addSubview:tbvReturns];
}

-(void)updateSoldQuantity:(NSNotification*)notif{
    
    AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);

//    NSLog(@"recvd values index:%@ plcdV:%d",[[notif userInfo] valueForKey:@"indexPath"],[[[notif userInfo] valueForKey:@"placedQty"] integerValue]);
    
    int index = [[[notif userInfo] valueForKey:@"indexPath"] intValue] ;
    int placedQty = [[[notif userInfo] valueForKey:@"placedQty"] integerValue];
    
    Order *currentArr = (Order*)[arr_SalesOrders objectAtIndex:index];
   
    for (int i = 0; i <[appObject.ordersPlaced count]; i++) {
        
        Order *temp = (Order*)[appObject.ordersPlaced objectAtIndex:i];
        if ([customerID isEqualToString:temp.customerNo]) {

            if ([temp.matNo isEqualToString:currentArr.matNo] ) {
                temp.placedQty = placedQty;
            }
//            [arr_SalesOrders addObject:[tarr objectAtIndex:i]];
        }
    }
}

- (void)returnsItemSelected:(NSString *)strReturnsName {
    [_popOverController dismissPopoverAnimated:YES];
    AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    
    NSMutableDictionary *dict = [arrReturns[appObject.rowCustomerListSelected] objectAtIndex:0];
    [dict setValue:strReturnsName forKey:@"desc"];
    
    [tbvReturns reloadData];
}

- (void)addButtonClicked {
    if([txtFieldMatID.text isEqualToString:@""]) return;
    
    AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    for (int i = 0; i < [arrReturns[appObject.rowCustomerListSelected] count]; i++) {
        NSMutableDictionary *dict = [arrReturns[appObject.rowCustomerListSelected] objectAtIndex:i];
        if ([[dict valueForKey:@"item"] isEqualToString:txtFieldMatID.text]) {
            int count = [[dict valueForKey:@"value"] intValue];
            count++;
            [dict setValue:[NSString stringWithFormat:@"%d", count] forKey:@"value"];
            [tbvReturns reloadData];
            return;
        }
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:txtFieldMatID.text forKey:@"item"];
    [dict setValue:@"1" forKey:@"value"];
    [dict setValue:@"" forKey:@"desc"];
    [arrReturns[appObject.rowCustomerListSelected] insertObject:dict atIndex:0];
    [tbvReturns reloadData];
    
    UITableViewCell *cell = [tbvReturns cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGRect rectP = cell.frame;
    rectP.origin.x = 0;
    rectP.origin.y += row_Height_TodayTableView;
    _popOverController.popoverContentSize = CGSizeMake(200, 200);
    [_popOverController presentPopoverFromRect:rectP inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)btnBarCodeBtnClicked {
    
}
@end
