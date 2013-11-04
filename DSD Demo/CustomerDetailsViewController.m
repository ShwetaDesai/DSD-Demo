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
    [btn setFrame:CGRectMake(305, 283, 159, 51)];
    [btn addTarget:self action:@selector(onClickServiceOutlet) forControlEvents:UIControlEventTouchUpInside];
    
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
@end
