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
    customerID =  ((AppDelegate*)[[UIApplication sharedApplication] delegate]).customerToServicID;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:19], NSFontAttributeName,nil];
    
    [segmentedBar addTarget:self
                         action:@selector(segmentedBarClicked:)
               forControlEvents:UIControlEventValueChanged];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    //dont set as 0, 1
//    sales = 2
//    returns = 3
    // nosale = 4
    // summary = 5
    visibilityTruth = [[NSMutableArray alloc] initWithObjects:@"NO",@"NO",@"NO",@"NO", nil];
    
        IDlastSelectedTab = -2000000000;
    [self onClickSalesTab];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)segmentedBarClicked:(UISegmentedControl*)control{
    selectedSegmentBarID = control.selectedSegmentIndex;
    
    if(control.selectedSegmentIndex == 2){
        [self onClickNoSaleTab];
    }else if (control.selectedSegmentIndex == 3){
        [self onClickSummaryTab];
    }else if (control.selectedSegmentIndex == 0){
        [self onClickSalesTab];
    }
}

-(void) onClickNoSaleTab {
//    NSLog(@"ENTER NO SALE selectedSegmentBarID:%d",selectedSegmentBarID);
    NSLog(@"total viewS:%d",[[self.view subviews] count]);
   
    [[self.view viewWithTag:IDlastSelectedTab] setHidden:YES];
    if ([[visibilityTruth objectAtIndex:2] isEqual: @"NO"]) {
//        
//    }
//    if ([self.view viewWithTag:selectedSegmentBarID+2] != nil &&[self.view viewWithTag:selectedSegmentBarID+2].hidden) {
//        [[self.view viewWithTag:selectedSegmentBarID+2] setHidden:NO];
//    }else{
//        [[self.view viewWithTag:IDlastSelectedTab] setHidden:YES];
        
        
        tbvNoService = [[UITableView alloc] initWithFrame:CGRectMake(5, 55, tableWidth - 10, [arr_NoServiceItems count] *row_Height_TodayTableView) style:UITableViewStylePlain];
        tbvNoService.dataSource = self;
        tbvNoService.delegate = self;
        tbvNoService.tag = 333;
        IDlastSelectedTab = 333;
        [self.view addSubview:tbvNoService];
        [visibilityTruth replaceObjectAtIndex:2 withObject:@"YES"];
    }else{
        //already created so only unhide it using its tag
        [[self.view viewWithTag:333] setHidden:NO];
    }
}

-(void) onClickSalesTab {
//    NSLog(@"total SALES TAB viewS:%d",[[self.view subviews] count]);
//    
//    if ([self.view viewWithTag:selectedSegmentBarID+2] != nil &&[self.view viewWithTag:selectedSegmentBarID+2].hidden) {
//        [[self.view viewWithTag:selectedSegmentBarID+2] setHidden:NO];
//    }else{
//        [[self.view viewWithTag:IDlastSelectedTab] setHidden:YES];
//    IDlastSelectedTab = 2;
    [[self.view viewWithTag:IDlastSelectedTab] setHidden:YES];
     if ([[visibilityTruth objectAtIndex:0] isEqual: @"NO"]) {

    [self prepareDataForSalesTable];
        tbvSales = [[UITableView alloc] initWithFrame:CGRectMake(5, 55, tableWidth - 80, [arr_SalesOrders count ]*row_Height_TodayTableView) style:UITableViewStylePlain];
        tbvSales.dataSource = self;
        tbvSales.delegate = self;
    tbvSales.tag = 1111;
         IDlastSelectedTab = 1111;
    [self.view addSubview:tbvSales];
         [visibilityTruth replaceObjectAtIndex:0 withObject:@"YES"];
     }else{
         //already created so only unhide it using its tag
         [[self.view viewWithTag:1111] setHidden:NO];
     }
    
}
-(void)prepareDataForSalesTable{
    AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    
//    NSLog(@"sales cust ID:%@",customerID);
//    NSLog(@"appObject.ordersPlaced:%d",[appObject.ordersPlaced count]);
    
    NSArray *tarr = [NSArray arrayWithArray:appObject.ordersPlaced];
    
    for (int i = 0; i <[tarr count]; i++) {
            Order *temp = (Order*)[tarr objectAtIndex:i];
//        NSLog(@"temp.customerNo:%@",temp.customerNo);
        if ([customerID isEqualToString:temp.customerNo]) {
            [arr_SalesOrders addObject:[tarr objectAtIndex:i]];
        }
    }
//    NSLog(@"count of orders for this customer:%d",[arr_SalesOrders count]);
}

-(void) onClickSummaryTab {
    
//    NSLog(@"ENTER SUMMARy selectedSegmentBarID:%d",selectedSegmentBarID);
    
//    if ([self.view viewWithTag:selectedSegmentBarID+2] != nil &&[self.view viewWithTag:selectedSegmentBarID+2].hidden) {
//        [[self.view viewWithTag:selectedSegmentBarID+2] setHidden:NO];
//    }else{
    [[self.view viewWithTag:IDlastSelectedTab] setHidden:YES];
    
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(5,55,tableWidth - 10,400)];
//    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(5,55,tableWidth - 10,600)];
//    scrollV.scrollEnabled = YES;
//    scrollV.showsVerticalScrollIndicator = YES;
//    scrollV.tag = 4;
      
        
//        yPos = 55 + 2*row_Height_TodayTableView;
    tbvSummary = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, tableWidth - 80, 2*50) style:UITableViewStylePlain];
    tbvSummary.dataSource = self;
    tbvSummary.delegate = self;
        [contentView addSubview:tbvSummary];
        
//
//    [scrollV addSubview:tbvSummary];
    [self showSignCaptureTool];
        [contentView addSubview:signatureViewController.view];
        
//    [scrollV addSubview:signatureViewController.view];
    
    UIButton  *acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
    acceptButton.titleLabel.text = @"Accept and Print Invoice";
    acceptButton.titleLabel.textColor = [UIColor redColor];
    
    [acceptButton setFrame:CGRectMake(75,150, 150, 30)];
        [contentView addSubview:acceptButton];
//    [scrollV addSubview:acceptButton];
        IDlastSelectedTab = 5;
    [self.view addSubview:contentView];
//}
}

//-(void)addAcceptbutton{
//    UIButton  *acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
////    [acceptButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
////    backButton.tag = 4;
//    acceptButton.titleLabel.text = @"Accept and Print Invoice";
//    acceptButton.titleLabel.textColor = [UIColor redColor];
//    
//    [acceptButton setFrame:CGRectMake((tableWidth-150)/2, yPos + 20, 150, 23)];
////    [backButton addTarget:self action:@selector(onclickBackButton) forControlEvents:UIControlEventTouchUpInside];
//    
//
//}

-(void)showSignCaptureTool {
    signatureViewController = [[SignCaptureViewController alloc] init];
    [signatureViewController.view setFrame:CGRectMake(0, 100+ 30, tableWidth - 60 , 150)];
//    yPos+=20+200;
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
    
    static NSString *MyCellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    // Configure the cell...
    if (tableView == tbvNoService) {
        if([selectedRow isEqual:indexPath])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        cell.textLabel.text = [arr_NoServiceItems objectAtIndex:indexPath.row] ;
        cell.textLabel.font = [UIFont systemFontOfSize:font_TodayTableView];

    }
    
    if (tableView == tbvSales) {
        Order *o = (Order*)[arr_SalesOrders objectAtIndex:indexPath.row];
        cell.textLabel.text = o.matNo;
        cell.textLabel.font = [UIFont systemFontOfSize:font_TodayTableView];
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
        [tableView reloadData];
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

@end
