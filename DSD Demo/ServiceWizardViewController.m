//
//  ServiceWizardViewController.m
//  DSD Demo
//
//  Created by Shweta on 02/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "ServiceWizardViewController.h"
#import "AppDelegate.h"
#import "Order.h"
#import "SODCustomTableCell.h"

@interface ServiceWizardViewController ()

@end

@implementation ServiceWizardViewController
@synthesize segmentedBar, customerID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        arr_NoServiceItems = [NSArray arrayWithObjects:@"Late delivery",@"Delivery refusal by customer",@"Quality problem",@"Wrong load",@"Product not ordered",@"Others", nil];
        
        arr_SalesOrders = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSoldQuantity:) name:nSoldQtyUpdate object:nil];

    customerID =  ((AppDelegate*)[[UIApplication sharedApplication] delegate]).customerToServicID;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:19], NSFontAttributeName,nil];
    
//    [segmentedBar addTarget:self
//                         action:@selector(segmentedBarClicked:)
//               forControlEvents:UIControlEventValueChanged];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    //dont set as 0, 1
//    sales = 2
//    returns = 3
    // nosale = 4
    // summary = 5
    visibilityTruth = [[NSMutableArray alloc] initWithObjects:@"NO",@"NO",@"NO",@"NO", nil];
    
        IDlastSelectedTab = -2000000000;
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
    
//    [[self.view viewWithTag:2222] removeFromSup];
        tbvNoService = [[UITableView alloc] initWithFrame:CGRectMake(5, 55, tableWidth - 10, [arr_NoServiceItems count] *row_Height_TodayTableView) style:UITableViewStylePlain];
        tbvNoService.dataSource = self;
        tbvNoService.delegate = self;
        tbvNoService.tag = 3333;
        [self.view addSubview:tbvNoService];
}

-(void) onClickSalesTab {
    [self prepareDataForSalesTable];
        tbvSales = [[UITableView alloc] initWithFrame:CGRectMake(5, 55, tableWidth - 40, [arr_SalesOrders count ]*row_Height_TodayTableView) style:UITableViewStylePlain];
        tbvSales.dataSource = self;
        tbvSales.delegate = self;
    tbvSales.tag = 1111;
    [self.view addSubview:tbvSales];
}

-(void)prepareDataForSalesTable{
    AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    
    NSArray *tarr = [NSArray arrayWithArray:appObject.ordersPlaced];
    
    for (int i = 0; i <[tarr count]; i++) {
            Order *temp = (Order*)[tarr objectAtIndex:i];
        if ([customerID isEqualToString:temp.customerNo]) {
            [arr_SalesOrders addObject:[tarr objectAtIndex:i]];
        }
    }
}

-(void) onClickSummaryTab {

[[self.view viewWithTag:3333] removeFromSuperview];
    
    tbvSummary = [[UITableView alloc] initWithFrame:CGRectMake(5, 55, tableWidth - 80, 2*50) style:UITableViewStylePlain];
    tbvSummary.dataSource = self;
    tbvSummary.delegate = self;
    [self.view addSubview:tbvSummary];
    [self showSignCaptureTool];
        [self.view  addSubview:signatureViewController.view];
    
    UIButton  *acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
    acceptButton.titleLabel.text = @"Accept and Print Invoice";
    acceptButton.titleLabel.textColor = [UIColor redColor];
    
    [acceptButton setFrame:CGRectMake(75,120, 100, 30)];
        [self.view  addSubview:acceptButton];
}


-(void)showSignCaptureTool {
    signatureViewController = [[SignCaptureViewController alloc] init];
    [signatureViewController.view setFrame:CGRectMake(0, 100+ 30, tableWidth - 60 , 150)];
    signatureViewController.view.backgroundColor = [UIColor colorWithRed:58.0/255.0
                                                                   green:134.0/255.0
                                                                    blue:206.0/255.0
                                                                   alpha:0.39];
    signatureViewController.view.layer.borderWidth = 1.0;
    signatureViewController.view.layer.borderColor = [[UIColor blueColor] CGColor];
    signatureViewController.view.layer.cornerRadius = 5.0;
    signatureViewController.view.layer.masksToBounds = YES;
    
}
#pragma mark table View methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyCellIdentifier;
    UITableViewCell *cell;
    SODCustomTableCell *cellSOD;
    
     if (tableView == tbvSales) {
         MyCellIdentifier = @"Sales";
         cellSOD = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
         if (!cellSOD) {
             cellSOD = [[SODCustomTableCell alloc] initWithFrame:CGRectMake(0, 0,tableWidth - 40, 50)];
             cellSOD.selectionStyle = UITableViewCellSelectionStyleNone;
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
             cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
         }
     }
    
    // Configure the cell...
    if (tableView == tbvNoService) {
        if([selectedRow isEqual:indexPath])
            cell.accessoryType = UITableViewCellAccessoryCheckmark;      else
                cell.accessoryType = UITableViewCellAccessoryNone;
    
        cell.textLabel.text = [arr_NoServiceItems objectAtIndex:indexPath.row] ;
        cell.textLabel.font = [UIFont systemFontOfSize:font_TodayTableView];
    }
    
    if (tableView == tbvSales) {

        Order *o = (Order*)[arr_SalesOrders objectAtIndex:indexPath.row];
                [cellSOD setDataForRow:indexPath.row forOrder:o];
        return cellSOD;
    }
    if (tableView == tbvSummary) {
        cell.textLabel.text = @"Testing";
        cell.textLabel.font = [UIFont systemFontOfSize:font_TodayTableView];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tbvNoService) {
        selectedRow = indexPath;
        [tbvNoService reloadData];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == tbvNoService) {
            return [arr_NoServiceItems count];
    }else if (tableView == tbvSales) {
        return [arr_SalesOrders count];
    }else  if (tableView == tbvSummary)
        return 2;
    return 0;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return row_Height_TodayTableView;
}

- (IBAction)onClickconfirmButton:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""                                                                    message:@"Once confirmed cannot re-Enter the values. Click OK only if you want to proceed further. To stay on the same screen click Cancel."                                                                  delegate:nil
        cancelButtonTitle:@"Cancel"
        otherButtonTitles:@"OK", nil];
    
    alertView.delegate = self;
    [alertView show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) { // Cancel

    }else{ // OK
        if (segmentedBar.selectedSegmentIndex == 0) {
            [segmentedBar setEnabled:YES forSegmentAtIndex:1];
            [self showReturnsView];
            segmentedBar.selectedSegmentIndex = 1;
            [segmentedBar setEnabled:NO forSegmentAtIndex:0];
        }else
        if (segmentedBar.selectedSegmentIndex == 1) {
            [segmentedBar setEnabled:YES forSegmentAtIndex:2];
            [self onClickNoSaleTab];
            segmentedBar.selectedSegmentIndex = 2;
            [segmentedBar setEnabled:NO forSegmentAtIndex:1];
        }else
            if (segmentedBar.selectedSegmentIndex == 2) {
                [segmentedBar setEnabled:YES forSegmentAtIndex:3];
                [self onClickSummaryTab];
                segmentedBar.selectedSegmentIndex = 3;
                [segmentedBar setEnabled:NO forSegmentAtIndex:2];
            }
    }
}
-(void)showReturnsView{
    [[self.view viewWithTag:1111] removeFromSuperview];
//create ui - pending
}

-(void)updateSoldQuantity:(NSNotification*)notif{
    
    AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);

    int index = (int)[[notif userInfo] valueForKey:@"indexPath"];
    int placedQty = [[[notif userInfo] valueForKey:@"placedQty"] integerValue];
    
    NSLog(@"recvd values index:%d plcdV:%d",index,placedQty);
  
   ;
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
@end
