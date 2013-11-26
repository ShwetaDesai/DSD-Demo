//
//  TodayInfoViewController.m
//  DSD Demo
//
//  Created by Shweta on 31/10/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "TodayInfoViewController.h"

@interface TodayInfoViewController ()

@end

@implementation TodayInfoViewController
NSString *sectionTwoTitles[COUNT_TODAY_SECTION_2] = {@"Odomter Reading", @"Fluid Level", @"Light Indicators", @"Alarms", @"Temperature : Fluid (C)", @"Temperature : Chilled (C)", @"Truck Damage"};
NSString *dropDownValues[3] = {@"Select", @"Select", @"Select"};

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        for (int i=0; i<COUNT_TODAY_SECTION_2; i++) {
            _dataTextFields[i] = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight)];
            _dataTextFields[i].autocapitalizationType = UITextAutocapitalizationTypeNone;
            _dataTextFields[i].autocorrectionType = UITextAutocorrectionTypeNo;
            _dataTextFields[i].borderStyle = UITextBorderStyleBezel;
            _dataTextFields[i].font = [UIFont boldSystemFontOfSize:15.0];
            _dataTextFields[i].minimumFontSize = 12;
            _dataTextFields[i].adjustsFontSizeToFitWidth = YES;
            _dataTextFields[i].backgroundColor = [UIColor clearColor];
            _dataTextFields[i].delegate = self;
            _dataTextFields[i].clearButtonMode = UITextFieldViewModeWhileEditing;
            _dataTextFields[i].text = @"";
            _dataTextFields[i].tag = i;
        }
        
        titleItemsArray = [[NSArray alloc] initWithObjects:@"Today's Date",@"Vehicle Number",@"Driver Number",@"Shipment Number",@"Customer count",@"Pallet count", nil];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"dd MMM, yyyy"];
        
        NSDate *now = [[NSDate alloc] init];
        
        valueArray = [[NSArray alloc] initWithObjects:[format stringFromDate:now],@"FN5032",@"0010171018",@"S0001480807",@"2",@"5", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _dropDownOptionsVC = [[DropDownOptionsViewController alloc] initWithStyle:UITableViewStylePlain];
    _dropDownOptionsVC.parentDelegate =self;
    _popOverController = [[UIPopoverController alloc] initWithContentViewController:_dropDownOptionsVC];
    
    todayInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, tableWidth, COUNT_TODAY_SECTION_2*row_Height_TodayTableView + [valueArray count]*row_Height_TodayTableView) style:UITableViewStyleGrouped];
    
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
    if (section == 1) {
        return COUNT_TODAY_SECTION_2;
    }
    return [titleItemsArray count];;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return @"Vehicle Pre-departure Inspection";
    }
    return @"Vehicle Details";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyCellIdentifier = @"MyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.accessoryView = nil;
    if (indexPath.section == 0) {
        cell.textLabel.text = [titleItemsArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [valueArray objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:font_TodayTableView];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:font_TodayTableView];
    }
    else {
        cell.textLabel.text = sectionTwoTitles[indexPath.row];
        
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            cell.detailTextLabel.text = dropDownValues[indexPath.row-1];
        }
        else if(indexPath.row == 6) {
            cell.detailTextLabel.text = @"Take Picture";
        }
        else {
            cell.accessoryView = _dataTextFields[indexPath.row];
        }
    }
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return row_Height_TodayTableView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3)) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        CGRect rectP = cell.frame;
        rectP.origin.x += 200;
        _dropDownOptionsVC.index = indexPath.row;
        _popOverController.popoverContentSize = CGSizeMake(200, 100);
        [_popOverController presentPopoverFromRect:rectP inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }
}

- (void)optionSelected:(NSString *)strValue  textFieldTag:(int)tag{
    [_popOverController dismissPopoverAnimated:YES];
    dropDownValues[tag-1] = strValue;
    [todayInfoTableView reloadData];
}

#pragma mark - Keyboard Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	CGPoint point = [todayInfoTableView convertPoint:CGPointZero fromView:textField];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
    todayInfoTableView.contentOffset = CGPointMake(0, point.y - 190);
	[UIView commitAnimations];
	
	return YES;
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	CGRect frame = todayInfoTableView.frame;
	todayInfoTableView.frame = CGRectMake(0.0f,
                                  0.0f,
                                  frame.size.width,
                                  frame.size.height);
	
	[UIView commitAnimations];
	return YES;
	
}

@end
