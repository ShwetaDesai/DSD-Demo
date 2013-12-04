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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePalleteDetailScreen) name:nPalleteDetailScreenCalled object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backButtonPressed) name:nBackButtonPressed object:nil];
    
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
    
    todayTableViewController.view.frame = CGRectMake(x_Pos, y_Pos, tableWidth, 450);

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
            [self showSODPalleteView];
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
    }else if (buttonClicked.selected == YES && buttonClicked.tag == 3){
        // show stop list screen
        [self showServiceOutletView];
    }
}

-(void) showSODView {
    for (int i=0; i < 6; i++) {
        acceptedValues[i] = enteredValues[i] = 0;
    }
    SODViewControllerViewController *sodViewController;
    sodViewController = [[SODViewControllerViewController alloc] initWithStyle:UITableViewStylePlain];
    sodViewController.view.frame = CGRectMake(x_Pos, y_Pos, tableWidth, 650);
    
    [contentView addSubview:sodViewController.view];

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
    sodpaletteViewController = [[SODPaletteViewController alloc]init];
    customerDetailVC = [[CustomerDetailsViewController alloc] init];
    wizardVC = [[ServiceWizardViewController alloc] init];
}

-(void) showServiceWizardView:(NSNotification*)notification{
//    NSLog(@"ENTER  showServiceWizardView");
//    NSLog(@"cust ID chosen:%@",[[notification userInfo] valueForKey:@"customerToServiceID"]);
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).customerToServicID = [[notification userInfo] valueForKey:@"customerToServiceID"];
    
    for (UIView* view in [contentView subviews])
        [view removeFromSuperview];
    
    wizardVC = nil;
    wizardVC = [[ServiceWizardViewController alloc] init];
    wizardVC.view.frame = CGRectMake(x_Pos, y_Pos, tableWidth, 450);
//    wizardVC.customerID = [[notification userInfo] valueForKey:@"customerToServiceID"];
//    wizardVC.view.layer.cornerRadius = 10.0;
    [contentView addSubview:wizardVC.view];
    
}

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
 

    customerDetailVC = nil;
    customerDetailVC = [[CustomerDetailsViewController alloc] init];
    customerDetailVC.view.frame = CGRectMake(x_Pos,y_Pos, tableWidth, 700);
    customerDetailVC.view.layer.cornerRadius = 10.0;

    [contentView addSubview:customerDetailVC.view];
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

-(void)handlePalleteDetailScreen{
    [self showSODView];
    
}

-(void)backButtonPressed
{
    [self showSODPalleteView];
    
}

-(void)showSODPalleteView{
    sodpaletteViewController = [[SODPaletteViewController alloc]initWithStyle:UITableViewStylePlain];
    sodpaletteViewController.view.frame = CGRectMake(x_Pos, y_Pos, tableWidth, 650);
    
    [contentView addSubview:sodpaletteViewController.view];
    tagNoButtonSelected = 2;
}

@end
