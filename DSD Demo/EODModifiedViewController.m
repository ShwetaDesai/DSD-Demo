//
//  EODModifiedViewController.m
//  DSD Demo
//
//  Created by Radhika Bhangaonkar on 06/12/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "EODModifiedViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface EODModifiedViewController (){
    
    float odometerReading;
}

@end

@implementation EODModifiedViewController

NSString *sectionTwoTitles1[COUNT_TODAY_SECTION_2] = {@"Odometer Reading", @"Fluid Level", @"Light Indicators", @"Alarms", @"COMPARTMENT TEMPERATURE", @"            Frozen", @"            Chilled", @"Weather Conditions", @"Truck Damage"};
NSString *dropDownValues1[3] = {@"Select", @"Select", @"Select"};

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _hasNetworkCallFailed = NO;
        for (int i=0; i<COUNT_TODAY_SECTION_2; i++) {
            _dataTextFields[i] = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight)];
            _dataTextFields[i].autocapitalizationType = UITextAutocapitalizationTypeNone;
            _dataTextFields[i].autocorrectionType = UITextAutocorrectionTypeNo;
            _dataTextFields[i].borderStyle = UITextBorderStyleBezel;
            _dataTextFields[i].font = [UIFont boldSystemFontOfSize:15.0];
            _dataTextFields[i].minimumFontSize = 12;
            _dataTextFields[i].adjustsFontSizeToFitWidth = YES;
            _dataTextFields[i].backgroundColor = [UIColor clearColor];
            _dataTextFields[i].textColor = COLOR_CELL_SUBTITLE;
            _dataTextFields[i].delegate = self;
            _dataTextFields[i].clearButtonMode = UITextFieldViewModeWhileEditing;
            _dataTextFields[i].text = @"";
            _dataTextFields[i].tag = i;
        }
        
        titleItemsArray = [[NSArray alloc] initWithObjects:@"Today's Date",@"Vehicle Number",@"Driver Number",@"Customer count",@"Pallet count", nil];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"dd MMM, yyyy"];
        
        NSDate *now = [[NSDate alloc] init];
        
        valueArray = [[NSArray alloc] initWithObjects:[format stringFromDate:now],@"KLV8465",@"GSFCA002",@"6",@"6", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //    arrResponse = [[NSMutableArray alloc] init];
    strTemperature = [[NSString alloc] init];
    
    [self callIBrightAPI];
    
    _dropDownOptionsVC = [[DropDownOptionsViewController alloc] initWithStyle:UITableViewStylePlain];
    _dropDownOptionsVC.parentDelegate =self;
    _popOverController = [[UIPopoverController alloc] initWithContentViewController:_dropDownOptionsVC];
    
    eodInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, tableWidth, 450) style:UITableViewStylePlain];
    
    eodInfoTableView.dataSource = self;
    eodInfoTableView.delegate = self;
    //    todayInfoTableView.layer.cornerRadius = 10.0;
    [self.view addSubview:eodInfoTableView];
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

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 54;
    }
    return 44;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSLog(@"Header for section 0");
        
        UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width - 20, 54)];
        viewHeader.backgroundColor = [UIColor colorWithRed:86.0/255.0 green:86.0/255.0 blue:86.0/255.0 alpha:1.0];

        
        UIButton *btnSettlement = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnSettlement.frame = CGRectMake(10, 5, 125, 44);
        [btnSettlement addTarget:self action:@selector(settlementButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [btnSettlement setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:155.0/255.0 blue:1.0/255.0 alpha:1.0]];
        [btnSettlement setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnSettlement setTitle:@"SETTLEMENT" forState:UIControlStateNormal];
        [viewHeader addSubview:btnSettlement];
        
        
        UIButton *btnCheck = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnCheck.frame = CGRectMake(150, 5, 175, 44);
        [btnCheck addTarget:self action:@selector(checkButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [btnCheck setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:155.0/255.0 blue:1.0/255.0 alpha:1.0]];
        [btnCheck setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnCheck setTitle:@"INVENTORY CHECK" forState:UIControlStateNormal];
        [viewHeader addSubview:btnCheck];
        
        btnGPS = [UIButton buttonWithType:UIButtonTypeCustom];
        btnGPS.frame = CGRectMake(700, 15, 31, 30);
        [btnGPS setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [btnGPS setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
        [btnGPS addTarget:self action:@selector(checkButtonGPSToggle) forControlEvents:UIControlEventTouchUpInside];
        AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
        btnGPS.selected = appObject.isGPSUseSet;
        
        [viewHeader addSubview:btnGPS];
        
        return viewHeader;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, eodInfoTableView.frame.size.width, 44)];
    view.backgroundColor = COLOR_CELL_HEADER;
    
    UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.frame.size.width-20, 44)];
    lblText.backgroundColor = [UIColor clearColor];
    lblText.text = @"VEHICLE PRE-DEPARTURE INSPECTION";
    lblText.font = [UIFont systemFontOfSize:20];
    lblText.textColor = [UIColor whiteColor];
    
    [view addSubview:lblText];
    
    return view;
}

-(void)checkButtonGPSToggle{
AppDelegate *appObject = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    
    if (btnGPS.selected) {
        btnGPS.selected = NO;
        appObject.isGPSUseSet = NO;
    }else{
        btnGPS.selected = YES;
        appObject.isGPSUseSet = YES;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyCellIdentifier = @"MyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = COLOR_CELL_BACKGROUND;
        cell.textLabel.textColor = COLOR_CELL_TEXT;
        cell.detailTextLabel.textColor = COLOR_CELL_SUBTITLE;
    }
    
    cell.accessoryView = nil;
    if (indexPath.section == 0) {
        cell.textLabel.text = [titleItemsArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [valueArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:font_TodayTableView];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:font_TodayTableView];
    }
    else {
        cell.textLabel.text = sectionTwoTitles1[indexPath.row];
        
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            cell.detailTextLabel.text = dropDownValues1[indexPath.row-1];
        }
        else if(indexPath.row == 8) {
            cell.detailTextLabel.text = @"Take Picture";
        }
        else if(indexPath.row == 5) {
            NSDictionary *dict1 = [[arrResponse objectAtIndex:5] valueForKey:@"Data"];
            
            if ([[dict1 valueForKey:@"name"] isEqualToString:@"temperature2"]) {
                dict1 = [[arrResponse objectAtIndex:6] valueForKey:@"Data"];
            }
            cell.detailTextLabel.text = [NSString stringWithFormat:TEXT_TEMPERATURE, [self convertDegreeC_To_F:[dict1 valueForKey:@"temp"]], [self convertDegreeC_To_F:[dict1 valueForKey:@"aat"]], [self convertDegreeC_To_F:[dict1 valueForKey:@"set"]], [self convertDegreeC_To_F:[dict1 valueForKey:@"sat"]]];
            if (_hasNetworkCallFailed) cell.detailTextLabel.textColor = COLOR_THEME;
        }
        else if(indexPath.row == 6) {
            NSDictionary *dict1 = [[arrResponse objectAtIndex:6] valueForKey:@"Data"];
            if ([[dict1 valueForKey:@"name"] isEqualToString:@"temperature1"]) {
                dict1 = [[arrResponse objectAtIndex:5] valueForKey:@"Data"];
            }
            
            cell.detailTextLabel.text = [NSString stringWithFormat:TEXT_TEMPERATURE_CHILLED, [self convertDegreeC_To_F:[dict1 valueForKey:@"temp"]], [self convertDegreeC_To_F:[dict1 valueForKey:@"aat"]], [self convertDegreeC_To_F:[dict1 valueForKey:@"set"]], @"NIL"];
            
            if (_hasNetworkCallFailed) cell.detailTextLabel.textColor = COLOR_THEME;
        }
        else if(indexPath.row == 7) {
            if (_hasNetworkCallFailed) {
                cell.detailTextLabel.textColor = COLOR_THEME;
            }
            cell.detailTextLabel.text = strTemperature;
            if (_hasNetworkCallFailed) cell.detailTextLabel.textColor = COLOR_THEME;
        }
        else if(indexPath.row == 0) {
            if (_hasNetworkCallFailed) _dataTextFields[indexPath.row].textColor = COLOR_THEME;
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
    dropDownValues1[tag-1] = strValue;
    [eodInfoTableView reloadData];
}

#pragma mark - Keyboard Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	CGPoint point = [eodInfoTableView convertPoint:CGPointZero fromView:textField];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
    eodInfoTableView.contentOffset = CGPointMake(0, point.y - 190);
	[UIView commitAnimations];
	
	return YES;
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	CGRect frame = eodInfoTableView.frame;
	eodInfoTableView.frame = CGRectMake(0.0f,
                                          0.0f,
                                          frame.size.width,
                                          frame.size.height);
	
	[UIView commitAnimations];
	return YES;
	
}

- (NSString*)convertDegreeC_To_F:(NSString*)strDegreeC {
    float degreeC = [strDegreeC floatValue];
    NSLog(@"degreeC :: %f", degreeC);
    return [NSString stringWithFormat:@"%.2f", (degreeC*(9/5)+32)];
}

- (void)callIBrightAPI {
    _hasNetworkCallFailed = NO;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.ibright.info/v2/rawdata/latest?AssetIDFilter=16277&orderby=WhenOccurred%20desc&LogNameFilter=position%2Ctemperature2%2Ctemperature1%2CreeferFuelLevel%2CpositionTimer%2CmotionStart%2CmotionStop&apikey=df4d2438-9d90-4b03-b025-98412018e3ad"]];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // Create url connection and fire request
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    // Create the request.
    NSMutableURLRequest *requestWeatherAPI = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?lat=33.678158&lon=-117.854505"]];
    // Create url connection and fire request
    connWeather = [[NSURLConnection alloc] initWithRequest:requestWeatherAPI delegate:self];
    
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    if (connection == conn) {
        _responseData = [[NSMutableData alloc] init];
    }
    else {
        _responseDataWeather = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    if (connection == conn) {
        [_responseData appendData:data];
    }
    else {
        [_responseDataWeather appendData:data];
    }
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (connection == conn) {
        NSString *strResponse = [NSString stringWithUTF8String:[_responseData bytes]];
        arrResponse = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:nil];
        NSDictionary *dict = [[arrResponse objectAtIndex:0] valueForKey:@"Data"];
        
        odometerReading = ([[dict valueForKey:@"odometer"] floatValue]/1.609344);
        //NSLog(@"Odometer Value %2f",odometerReading);
        
        _dataTextFields[0].text = [NSString stringWithFormat:@"%.2f", odometerReading];
        
        [eodInfoTableView reloadData];
        NSLog(@"iBright API Finished %@", strResponse);
    }
    else {
        NSString *strResponse = [NSString stringWithUTF8String:[_responseDataWeather bytes]];
        NSDictionary *dict = [[NSJSONSerialization JSONObjectWithData:_responseDataWeather options:kNilOptions error:nil] valueForKey:@"main"];
        
        //NSLog(@"Temperature Reading %.2f F", [[dict valueForKey:@"temp"] floatValue]*(9/5)+32);
        
        strTemperature = [NSString stringWithFormat:@"%.2f F", (([[dict valueForKey:@"temp"] floatValue]- 273.15)*(9/5)+32)];
        NSLog(@"openweathermap API Finished %@", strResponse);
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _hasNetworkCallFailed = YES;
    strTemperature = @"41.76";
    
    NSString *response = @"[{\"ID\":8251002788,\"AssetID\":16277,\"AssetName\":\"K4801 RT 12\",\"EdiIdentifier\":\"801\",\"EnterpriseCode\":\"GSF23\",\"AccountCode\":\"GSF23\",\"WhenOccurred\":\"2013-12-05T03:56:11\",\"Data\":{\"name\":\"motionStart\",\"latitude\":\"47.608050\",\"longitude\":\"-122.336160\",\"odometer\":\"20566.210\",\"distance\":{\"gps\":\"20566210\"},\"stationary\":{\"elapsed\":\"1399.042\",\"distance\":\"0.000\"},\"geofence\":{\"inside.names\":\"1057150,1057054,1058172,1058187,1057176\"},\"motion\":{\"acid\":\"4941\"},\"total\":{\"actualMovingElapsed\":\"2921639.35629783291\"},\"idling\":{\"totalElapsed\":\"\"}}},{\"ID\":8251103937,\"AssetID\":16277,\"AssetName\":\"K4801 RT 12\",\"EdiIdentifier\":\"801\",\"EnterpriseCode\":\"GSF23\",\"AccountCode\":\"GSF23\",\"WhenOccurred\":\"2013-12-05T04:01:21\",\"Data\":{\"name\":\"motionStop\",\"moving\":{\"actualElapsed\":\"307.98080428457\",\"elapsed\":\"310.017\",\"distance\":\"0.495\",\"idleElapsed\":\"\",\"maxSpeed\":\"22.4\"},\"latitude\":\"47.609945\",\"longitude\":\"-122.333447\",\"odometer\":\"20566.705\",\"distance\":{\"gps\":\"20566705\"},\"geofence\":{\"inside.names\":\"1056441,1057500,1058183\"},\"motion\":{\"acid\":\"4941\"},\"total\":{\"actualMovingElapsed\":\"2921947.33710211748\"},\"idling\":{\"totalElapsed\":\"\"},\"mean\":{\"speed\":\"0.0\"}}},{\"ID\":8251103943,\"AssetID\":16277,\"AssetName\":\"K4801 RT 12\",\"EdiIdentifier\":\"801\",\"EnterpriseCode\":\"GSF23\",\"AccountCode\":\"GSF23\",\"WhenOccurred\":\"2013-12-05T04:01:21\",\"Data\":{\"name\":\"position\",\"distance\":{\"gps\":\"20566705\"},\"gps\":{\"satellitesused\":\"7\",\"speed\":\"0.2\"},\"engine\":{\"running\":\"true\"},\"system\":{\"voltage\":\"12.531\"},\"modem\":{\"rssi\":\"31\",\"gprs.registration\":\"1\",\"gsm.registration\":\"1\"},\"latitude\":\"47.609945\",\"longitude\":\"-122.333447\",\"odometer\":\"20566.705\",\"speed\":{\"kmph\":\"0.0\"},\"heading\":\"\",\"speeding\":{\"speedLimit\":\"112.65408\"}}},{\"ID\":8252112639,\"AssetID\":16277,\"AssetName\":\"K4801 RT 12\",\"EdiIdentifier\":\"801\",\"EnterpriseCode\":\"GSF23\",\"AccountCode\":\"GSF23\",\"WhenOccurred\":\"2013-12-05T06:00:00\",\"Data\":{\"name\":\"positionTimer\",\"latitude\":\"47.611773\",\"longitude\":\"-122.335068\",\"odometer\":\"20567.027\",\"speed\":{\"kmph\":\"0.0\"},\"heading\":\"\",\"speeding\":{\"speedLimit\":\"112.65408\"},\"system\":{\"voltage\":\"14.467\"},\"total\":{\"engineRunningElapsed\":\"13584555.63887488097\"},\"idling\":{\"totalElapsed\":\"\"},\"moving\":{\"totalElapsed\":\"2868205.702\"},\"geofence\":{\"inside.names\":\"1057155,1057840,1057841\"}}},{\"ID\":8252159665,\"AssetID\":16277,\"AssetName\":\"K4801 RT 12\",\"EdiIdentifier\":\"801\",\"EnterpriseCode\":\"GSF23\",\"AccountCode\":\"GSF23\",\"WhenOccurred\":\"2013-12-05T06:04:06\",\"Data\":{\"name\":\"reeferFuelLevel\",\"percent\":\"66\",\"fuelLevel\":{\"percent\":\"66\"},\"latitude\":\"47.611773\",\"longitude\":\"-122.335068\",\"odometer\":\"20567.027\",\"distance\":\"20567027\"}},{\"ID\":8252327151,\"AssetID\":16277,\"AssetName\":\"K4801 RT 12\",\"EdiIdentifier\":\"801\",\"EnterpriseCode\":\"GSF23\",\"AccountCode\":\"GSF23\",\"WhenOccurred\":\"2013-12-05T06:30:00\",\"Data\":{\"name\":\"temperature1\",\"type\":\"comp\",\"id\":\"K4801\",\"comp\":\"1\",\"aat\":\"4.34\",\"temp\":\"-11.94\",\"sat\":\"-10.41\",\"set\":\"-17.75\",\"probe1\":\"-15.3358\",\"probe2\":\"NA\",\"probe3\":\"NA\",\"probe4\":\"NA\",\"mode\":\"DEFROST\",\"latitude\":\"47.613663\",\"longitude\":\"-122.337690\",\"geofence\":{\"inside.names\":\"1057157\"}}},{\"ID\":8252327155,\"AssetID\":16277,\"AssetName\":\"K4801 RT 12\",\"EdiIdentifier\":\"801\",\"EnterpriseCode\":\"GSF23\",\"AccountCode\":\"GSF23\",\"WhenOccurred\":\"2013-12-05T06:30:00\",\"Data\":{\"name\":\"temperature2\",\"type\":\"comp\",\"id\":\"K4801\",\"comp\":\"2\",\"aat\":\"4.34\",\"temp\":\"4.88\",\"set\":\"2.22\",\"probe1\":\"1.4224\",\"probe2\":\"NA\",\"probe3\":\"NA\",\"probe4\":\"NA\",\"mode\":\"DEFROST\",\"latitude\":\"47.613663\",\"longitude\":\"-122.337690\",\"geofence\":{\"inside.names\":\"1057157\"}}}]";
    
    arrResponse = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    NSDictionary *dict = [[arrResponse objectAtIndex:0] valueForKey:@"Data"];
    
    _dataTextFields[0].text = [NSString stringWithFormat:@"%.2f", odometerReading];
    
    [eodInfoTableView reloadData];
}
-(void)settlementButtonClicked{
    
    NSLog(@"Settlement Button Clicked !");
}

-(void)checkButtonClicked{
    
    NSLog(@"Check Button Clicked !");
}
@end
