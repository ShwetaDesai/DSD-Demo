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
    
//    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [backButton setFrame:CGRectMake(0, 0, 70, 23)];
//    [backButton addTarget:self action:@selector(onclickBackButton) forControlEvents:UIControlEventTouchUpInside];
//    [backButton setHidden:YES];
//
//    [self.view addSubview:backButton];
    
//    NSString *title = @"STOPS";
//    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake((tableWidth - 200)/2,0, 200, 25 )];
//    lbltitle.text = title;
//    lbltitle.textColor = [UIColor whiteColor];
//    lbltitle.font = [UIFont boldSystemFontOfSize:font_TodayTableView+2];
//    [self.view addSubview:lbltitle];

    customersArray = [NSArray arrayWithArray:((AppDelegate*)[[UIApplication sharedApplication] delegate]).customersToService];
    
    customerListTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0 , tableWidth, [customersArray count]*row_Height_TodayTableView + 50) style:UITableViewStylePlain];
    customerListTableView.dataSource = self;
    customerListTableView.delegate = self;
    customerListTableView.layer.cornerRadius = 10.0;
    
    [self.view addSubview:customerListTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table View methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyCellIdentifier = @"CustomerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    Customer *temp = (Customer*)[customersArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",temp.street,temp.city];
    cell.textLabel.text = temp.name;
   
    cell.textLabel.font = [UIFont systemFontOfSize:font_TodayTableView+2];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:font_TodayTableView-2];
    
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.origin.x + 400, cell.frame.origin.y + 10, 300 , 21)];
    time.font = [UIFont systemFontOfSize:font_TodayTableView+2];
    time.text = [NSString stringWithFormat:@"ETA: %@",temp.ETA];
    [cell addSubview:time];
    
//    if (temp.isServiced == NO && indexPath.row !=0 ) {
//        cell.backgroundColor = [UIColor grayColor];
//    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [customersArray count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return row_Height_TodayTableView + 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
//    [backButton setHidden:NO];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:indexPath.row] forKey:@"index"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:nShowCustomerDetailsView object:self  userInfo:dict];
    
}

//-(void)onclickBackButton{
// 
//    [backButton setHidden:YES];
// 
//    [[NSNotificationCenter defaultCenter] postNotificationName:nShowCustomerListView object:nil];
//}
@end
