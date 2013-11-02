//
//  ViewController.m
//  DSD Demo
//
//  Created by Shweta on 26/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "ViewController.h"
#import "CustomerDetailsViewController.h"
//#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize btn_Today,btn_SOD,btn_ServiceOutlet,btn_transactionSummary,btn_EOD, contentView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initControllers];
    [btn_Today setSelected:YES];
 
    [btn_Today setBackgroundImage:[UIImage imageNamed:@"ccReverse.png"] forState:UIControlStateSelected];
    [btn_SOD setBackgroundImage:[UIImage imageNamed:@"ccReverse.png"] forState:UIControlStateSelected];
    [btn_ServiceOutlet setBackgroundImage:[UIImage imageNamed:@"ccReverse.png"] forState:UIControlStateSelected];
    [btn_transactionSummary setBackgroundImage:[UIImage imageNamed:@"ccReverse.png"] forState:UIControlStateSelected];
    [btn_EOD setBackgroundImage:[UIImage imageNamed:@"ccReverse.png"] forState:UIControlStateSelected];
    
    btn_Today.tag = 1;
    btn_SOD.tag = 2;
    btn_ServiceOutlet.tag = 3;
    btn_transactionSummary.tag = 4;
    btn_EOD.tag = 5;
    
    [btn_Today addTarget:self action:@selector(onClickMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_EOD addTarget:self action:@selector(onClickMenuButton:) forControlEvents:UIControlEventTouchUpInside];

    [btn_SOD addTarget:self action:@selector(onClickMenuButton:) forControlEvents:UIControlEventTouchUpInside];

    [btn_ServiceOutlet addTarget:self action:@selector(onClickMenuButton:) forControlEvents:UIControlEventTouchUpInside];

    [btn_transactionSummary addTarget:self action:@selector(onClickMenuButton:) forControlEvents:UIControlEventTouchUpInside];

    [btn_Today setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn_SOD setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn_ServiceOutlet setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn_transactionSummary setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn_EOD setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
   
    contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ccbg1.png"]];
    
    [self showTodaysView];
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
            [view removeFromSuperview];
        }
        
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
    
    customerViewC.view.frame = CGRectMake(x_Pos, y_Pos, tableWidth, 650);
//    [self containerAddChildViewController:customerViewC];
    [contentView addSubview:customerViewC.view];
    
    tagNoButtonSelected = 3;
}

- (void)initControllers {
    todayTableViewController = [[TodayInfoViewController alloc] init];
    customerViewC = [[CustomerListViewController alloc] init];
    sodViewController = [[SODViewControllerViewController alloc]initWithStyle:UITableViewStylePlain];
}

- (void)containerAddChildViewController:(UIViewController *)childViewController {
    
    [self addChildViewController:childViewController];
    [self.view addSubview:childViewController.view];
    [childViewController didMoveToParentViewController:self];
    
}
@end
