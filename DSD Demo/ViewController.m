//
//  ViewController.m
//  DSD Demo
//
//  Created by Shweta on 26/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize btn_Today,btn_SOD,btn_ServiceOutlet,btn_EOD, contentView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initControllers];
    [self initButtons];
    contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ccbg1.png"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showServiceWizardView:) name:nServiceOutletButtonClicked object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCustomerDetailsView:) name:nShowCustomerDetailsView object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showServiceOutletView) name:nShowCustomerListView object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCustomerServiceCompleted) name:nCustomerServiceComplete object:nil];
    
    [self showTodaysView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showTodaysView {
    
    todayTableViewController.view.frame = CGRectMake(x_Pos, y_Pos, tableWidth, 650);

    [contentView addSubview:todayTableViewController.view];
    tagNoButtonSelected = 1;
}
    
-(void)onClickMenuButton:(id)sender{
    UIButton *buttonClicked = (UIButton*)sender;
 
    if (buttonClicked.selected == NO) {
        buttonClicked.selected = YES;
        
        [(UIButton*)[self.view viewWithTag:tagNoButtonSelected] setSelected:NO];
    
        // remove any of teh subview of the last button selection
        for (UIView *view in contentView.subviews) {
//             NSLog(@"view in Arr for removal MENU BUTTON CLICK:%@",view);
            [view removeFromSuperview];
        }
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).customerToServicID = nil;
        
        if (buttonClicked.tag == 1) {
            //show the Today view
            [self showTodaysView];
        }
        else if (buttonClicked.tag == 2) {
            //show the SOD view
            [self showSODView];
        }
        else if (buttonClicked.tag == 3) {
            //show the Service Outlet view
            [self showServiceOutletView];
            
        }else if (buttonClicked.tag == 4){
            //show the transaction Summary view
        }else if (buttonClicked.tag == 5){
            //show the EOD view
            [self showEODView];
        }
        tagNoButtonSelected = buttonClicked.tag;
    }
}

-(void) showSODView {
    sodViewController = [[SODViewControllerViewController alloc] initWithStyle:UITableViewStylePlain];
    sodViewController.view.frame = CGRectMake(x_Pos, y_Pos, tableWidth, 650);
    
    [contentView addSubview:sodViewController.view];
    
    tagNoButtonSelected = 2;
    
}

-(void) showEODView {
    eodViewController = [[EODViewControllerViewController alloc] initWithStyle:UITableViewStylePlain];
    eodViewController.view.frame = CGRectMake(x_Pos, y_Pos, tableWidth, 650);
    
    [contentView addSubview:eodViewController.view];
    
    tagNoButtonSelected = 5;
    
}

-(void) showServiceOutletView {
    for (UIView *view in contentView.subviews) {
//        NSLog(@"view in Arr for removal:%@",view);
        [view removeFromSuperview];
    }
    
    customerViewC.view.frame = CGRectMake(x_Pos, y_Pos, tableWidth, 650);
    [contentView addSubview:customerViewC.view];
    
    tagNoButtonSelected = 3;
}

- (void)initControllers {
    todayTableViewController = [[TodayInfoViewController alloc] init];
    customerViewC = [[CustomerListViewController alloc] init];
    sodViewController = [[SODViewControllerViewController alloc]initWithStyle:UITableViewStylePlain];
    customerDetailVC = [[CustomerDetailsViewController alloc] init];
    wizardVC = [[ServiceWizardViewController alloc] init];
}

-(void) showServiceWizardView:(NSNotification*)notification{
    NSLog(@"ENTER  showServiceWizardView");
    NSLog(@"cust ID chosen:%@",[[notification userInfo] valueForKey:@"customerToServiceID"]);
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).customerToServicID = [[notification userInfo] valueForKey:@"customerToServiceID"];
    
    for (UIView* view in [contentView subviews])
        [view removeFromSuperview];
    
    wizardVC = nil;
    wizardVC = [[ServiceWizardViewController alloc] init];
    wizardVC.view.frame = CGRectMake(x_Pos, y_Pos, tableWidth, 490);
//    wizardVC.customerID = [[notification userInfo] valueForKey:@"customerToServiceID"];
    wizardVC.view.layer.cornerRadius = 10.0;
    [contentView addSubview:wizardVC.view];
    
}
//- (void)containerAddChildViewController:(UIViewController *)childViewController {
//    
//    [self addChildViewController:childViewController];
//    [self.view addSubview:childViewController.view];
//    [childViewController didMoveToParentViewController:self];
//    
//}

-(void)initButtons {
    [btn_Today setSelected:YES];
    
    [btn_Today setBackgroundImage:[UIImage imageNamed:@"ccReverse.png"] forState:UIControlStateSelected];
    [btn_SOD setBackgroundImage:[UIImage imageNamed:@"ccReverse.png"] forState:UIControlStateSelected];
    [btn_ServiceOutlet setBackgroundImage:[UIImage imageNamed:@"ccReverse.png"] forState:UIControlStateSelected];
    [btn_EOD setBackgroundImage:[UIImage imageNamed:@"ccReverse.png"] forState:UIControlStateSelected];
    
    btn_Today.tag = 1;
    btn_SOD.tag = 2;
    btn_ServiceOutlet.tag = 3;
    btn_EOD.tag = 5;
    
    [btn_Today addTarget:self action:@selector(onClickMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_EOD addTarget:self action:@selector(onClickMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_SOD addTarget:self action:@selector(onClickMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_ServiceOutlet addTarget:self action:@selector(onClickMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_Today setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn_SOD setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn_ServiceOutlet setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn_EOD setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}

-(void)showCustomerDetailsView:(NSNotification*)notification{

    int index = [[[notification userInfo] valueForKey:@"index"] intValue];
//    NSLog(@"ENTER  showCustomerDetailsView index:%d",index);
    
    AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    appObject.rowCustomerListSelected = index;
    
//    customerDetailVC.customerSelected = [appObject.customersToService objectAtIndex:index];

    customerDetailVC.view.frame = CGRectMake(x_Pos,y_Pos+30, tableWidth, 350);
    customerDetailVC.view.layer.cornerRadius = 10.0;

    [contentView addSubview:customerDetailVC.view];
//    [customerViewC.view setNeedsLayout];
//    [customerViewC.view setNeedsDisplay];
    
//    [contentView setNeedsLayout];
    
}

-(void)handleCustomerServiceCompleted{
    
    AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    for(int j=0;j<[appObject.customersToService count];j++){
        Customer *obj = (Customer*)[appObject.customersToService objectAtIndex:j];
        if([obj.ID isEqualToString:appObject.customerToServicID]){
            obj.isServiced = YES;
            appObject.customerToServicID = nil;
        }
    }
    [self showServiceOutletView];
}
@end
