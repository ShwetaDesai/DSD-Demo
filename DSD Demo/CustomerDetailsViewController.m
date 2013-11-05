//
//  CustomerDetailsViewController.m
//  DSD Demo
//
//  Created by Shweta on 31/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "CustomerDetailsViewController.h"
#import "AppDelegate.h"

@interface CustomerDetailsViewController ()

@end

@implementation CustomerDetailsViewController

//@synthesize customerSelected;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
//    NSLog(@"customer selected:%d",appObject.rowCustomerListSelected);
    
    customerSelected = [appObject.customersToService objectAtIndex:appObject.rowCustomerListSelected];
    
    lbl_CustomerID.text = customerSelected.ID;
    customerName.text = customerSelected.name;
    lbl_street.text = customerSelected.street;
    lbl_zip.text = customerSelected.pinCode;
    lbl_city.text = customerSelected.city;
    //    NSLog(@"customerSelected.phoneNo:%@",customerSelected.phoneNo);
    
    lbl_phoneNumber.text = customerSelected.phoneNo;
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:@"Service Outlet" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(200, 283, 159, 51)];
    [btn addTarget:self action:@selector(onClickServiceOutlet) forControlEvents:UIControlEventTouchUpInside];

    btnMap = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btnMap setTitle:@"Check Location" forState:UIControlStateNormal];
    [btnMap setBackgroundColor:[UIColor redColor]];
    [btnMap setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnMap setFrame:CGRectMake(360, 283, 159, 51)];
    [btnMap addTarget:self action:@selector(btnMapClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMap];
    
    if(customerSelected.isServiced)
        [btn setHidden:YES];
    
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) onClickServiceOutlet{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:lbl_CustomerID.text forKey:@"customerToServiceID"];
//    NSLog(@"cust ID chosen:%@",lbl_CustomerID.text);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:nServiceOutletButtonClicked object:nil userInfo:dict];
}

- (void)btnMapClicked {
    viewContent = [[UIView alloc] initWithFrame:CGRectMake(10, 10, tableWidth - 20, 600)];
    viewContent.backgroundColor = [UIColor whiteColor];
    viewContent.layer.cornerRadius = 5.0;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, tableWidth-20, 550)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://maps.google.com/maps?saddr=Mid+City,+Los+Angeles,+CA,+United+States&daddr=mcdonalds&hl=en&ll=34.043557,-118.377342&spn=0.183775,0.41851&sll=34.085649,-118.303185&sspn=0.183684,0.41851&geocode=FQpvBwIdq3Ly-Ckr5nvJ-bjCgDEqDTbs-DbhDQ%3BFTqpBwIdVfbw-CF9WN5AqPackSlR9N0Wj7vCgDF9WN5AqPackQ&oq=Mid+C&mra=ls&t=m&z=12"]]];
    [viewContent addSubview:webView];
    
    btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btnClose setTitle:@"Close" forState:UIControlStateNormal];
    [btnClose setBackgroundColor:[UIColor redColor]];
    [btnClose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnClose setFrame:CGRectMake(360, 5, 159, 51)];
    [btnClose addTarget:self action:@selector(removeMapView) forControlEvents:UIControlEventTouchUpInside];
    [viewContent addSubview:btnClose];
    
    [self.view addSubview:viewContent];
}

- (void)removeMapView {
    [btnClose removeFromSuperview];
    [viewContent removeFromSuperview];
}
@end
