//
//  CustomerListViewController.m
//  DSD Demo
//
//  Created by Shweta on 30/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "CustomerListViewController.h"
#import "Customer.h"
#import "AppDelegate.h"

@interface CustomerListViewController ()

@end

@implementation CustomerListViewController

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
    [self getCustomerDetails];
    
    navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableWidth, 30)];
    navigationView.backgroundColor = [UIColor clearColor];
    navigationView.tag = 1;
    
    NSString *title = @"Customer List";
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake((tableWidth - 140)/2,0, 140, 25 )];
    lbltitle.text = title;
    lbltitle.textColor = [UIColor whiteColor];
    lbltitle.font = [UIFont boldSystemFontOfSize:font_TodayTableView+2];
    lbltitle.tag = 2;
    [navigationView addSubview:lbltitle];
    [self.view addSubview:navigationView];
//
    customerListTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 30 , tableWidth, [customersArray count]*row_Height_TodayTableView + 30) style:UITableViewStylePlain];
    customerListTableView.dataSource = self;
    customerListTableView.delegate = self;
    customerListTableView.tag = 3;
    customerListTableView.layer.cornerRadius = 10.0;
    
    [self.view addSubview:customerListTableView];
//    NSLog(@"tableView obj inin view did load:%@",customerListTableView);
//    
//    NSLog(@"class obj inin view did load:%@",self);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getCustomerDetails {

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CustomerInfo" ofType:@"json"];
    
    NSError *fileReadError;
    NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&fileReadError];
    NSLog(@"File read error:%@",fileReadError);
    
    NSError *JSONreadError;
    //customerDictionary
    customerDictionary = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&JSONreadError];
    
    NSLog(@"JSON read error:%@",JSONreadError);
//    NSLog(@"dicto values:%@",customerDictionary);
    customersArray = [customerDictionary objectForKey:@"CUST_REC"];
    
//    NSLog(@"count:%d",[customersArray count]);
    
    for (int i = 0; i < [customersArray count]; i++) {
        Customer *customerObject = [[Customer alloc] init];
       
        customerObject.name = [[customersArray objectAtIndex:i] objectForKey:@"NAME"];

        customerObject.street = [[customersArray objectAtIndex:i] objectForKey:@"STREET"];

        customerObject.pinCode = [[customersArray objectAtIndex:i] objectForKey:@"PCODE"];
        
        customerObject.city = [[customersArray objectAtIndex:i] objectForKey:@"CITY"];
        
        customerObject.ID = [[customersArray objectAtIndex:i] objectForKey:@"CUST_NO"];
 
        customerObject.phoneNo = [[customersArray objectAtIndex:i] objectForKey:@"PHONE"];
        
//        NSLog(@"name:%@ address:%@",customerObject.name, customerObject.street);
        
        AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
        [appObject.customersToService addObject:customerObject];
    }
}

#pragma mark table View methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyCellIdentifier = @"CustomerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    // Configure the cell...
    
    cell.textLabel.text = [[customersArray objectAtIndex:indexPath.row] objectForKey:@"NAME"];
    cell.textLabel.font = [UIFont systemFontOfSize:font_TodayTableView];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  30;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [customersArray count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
    
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Pending Customers";
    }
    return @"Completed";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return row_Height_TodayTableView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"row selected");
    
    // get and pass the customer object from the App delegate array
    
//    AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);

        [self showBackButton];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:indexPath.row] forKey:@"index"];
    
      [[NSNotificationCenter defaultCenter] postNotificationName:nShowCustomerDetailsView object:self  userInfo:dict];
    
//    [appObject.customersToService objectAtIndex:indexPath.row]
    //
//    CustomerDetailsViewController *customerDetailVC = [[CustomerDetailsViewController alloc] init];
//    
//    customerDetailVCObject.customerSelected = [appObject.customersToService objectAtIndex:indexPath.row];
//
//    customerDetailVCObject.view.frame = CGRectMake(0, 30, tableWidth, 350);
//    customerDetailVCObject.view.layer.cornerRadius = 10.0;
//

//    [self.view addSubview:customerDetailVCObject.view];
   
}

-(void)showBackButton {
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backButton.tag = 4;
    [backButton setFrame:CGRectMake(0, 0, 70, 23)];
    [backButton addTarget:self action:@selector(onclickBackButton) forControlEvents:UIControlEventTouchUpInside];
    
    [[self.view viewWithTag:1] addSubview:backButton];
    
}
-(void)onclickBackButton{
 
    [backButton removeFromSuperview];
    //remove the customer Details View
    [[NSNotificationCenter defaultCenter] postNotificationName:nShowCustomerListView object:nil];
}
@end
