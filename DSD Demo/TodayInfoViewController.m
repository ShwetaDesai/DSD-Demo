//
//  TodayInfoViewController.m
//  DSD Demo
//
//  Created by Shweta on 31/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "TodayInfoViewController.h"
#import "Constants.h"
@interface TodayInfoViewController ()

@end

@implementation TodayInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        titleItemsArray = [[NSArray alloc] initWithObjects:@"Today's Date",@"Vehicle Number",@"Driver Number",@"Shipment Number",@"Customer count",@"Pallet count", nil];
        
        valueArray = [[NSArray alloc] initWithObjects:[[NSDate date] description],@"FN5032",@"0010171018",@"S0001480807",@"2",@"5", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    todayInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, tableWidth, [valueArray count]*row_Height_TodayTableView) style:UITableViewStylePlain];
    
    todayInfoTableView.dataSource = self;
    todayInfoTableView.delegate = self;
    todayInfoTableView.layer.cornerRadius = 10.0;
    [self.view addSubview:todayInfoTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [titleItemsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyCellIdentifier = @"MyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    
    cell.textLabel.text = [titleItemsArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [valueArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:font_TodayTableView];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:font_TodayTableView];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return row_Height_TodayTableView;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"row selected");
//}

@end
