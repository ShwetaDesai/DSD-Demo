//
//  ServiceWizardViewController.m
//  DSD Demo
//
//  Created by Shweta on 02/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "ServiceWizardViewController.h"

@interface ServiceWizardViewController ()

@end

@implementation ServiceWizardViewController
@synthesize segmentedBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        arr_NoServiceItems = [NSArray arrayWithObjects:@"Late delivery",@"Delivery refusal by customer",@"Quality problem",@"Wrong load",@"Product not ordered",@"Others", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:19], NSFontAttributeName,nil];
    
    [segmentedBar addTarget:self
                         action:@selector(segmentedBarClicked:)
               forControlEvents:UIControlEventValueChanged];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    IDlastSelectedTab = 1;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)segmentedBarClicked:(UISegmentedControl*)control{
    selectedSegmentBarID = control.selectedSegmentIndex;
    if(control.selectedSegmentIndex == 2){
        [self onClickNoSaleTab];
    }else if (control.selectedSegmentIndex == 3){
        [self onClickSummaryTab];
    }
}

-(void) onClickNoSaleTab {
    if ([self.view viewWithTag:selectedSegmentBarID] != nil &&[self.view viewWithTag:selectedSegmentBarID].hidden) {
        [[self.view viewWithTag:selectedSegmentBarID] setHidden:NO];
    }else{
        [[self.view viewWithTag:IDlastSelectedTab] setHidden:YES];
        tbvNoService = [[UITableView alloc] initWithFrame:CGRectMake(5, 55, tableWidth - 10, [arr_NoServiceItems count] *row_Height_TodayTableView) style:UITableViewStylePlain];
        tbvNoService.dataSource = self;
        tbvNoService.delegate = self;
        tbvNoService.tag = 3;
        IDlastSelectedTab = 3;
        [self.view addSubview:tbvNoService];
    }
}

-(void) onClickSalesTab {
    [self prepareDataForSalesTable];
//        tbvSales = [[UITableView alloc] initWithFrame:CGRectMake(5, 55, tableWidth - 80, ) style:UITableViewStylePlain];
//        tbvSales.dataSource = self;
//        tbvSales.delegate = self;
    
}
-(void)prepareDataForSalesTable{
    
}
-(void) onClickSummaryTab {
    if ([self.view viewWithTag:selectedSegmentBarID] != nil &&[self.view viewWithTag:selectedSegmentBarID].hidden) {
        [[self.view viewWithTag:selectedSegmentBarID] setHidden:NO];
    }else{
    [[self.view viewWithTag:IDlastSelectedTab] setHidden:YES];
    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(5,55,tableWidth - 10,600)];
    scrollV.scrollEnabled = YES;
    scrollV.showsVerticalScrollIndicator = YES;
    scrollV.tag = 4;
      
        
//        yPos = 55 + 2*row_Height_TodayTableView;
//        tbvSummary = [[UITableView alloc] initWithFrame:CGRectMake(5, 55, tableWidth - 80, yPos) style:UITableViewStylePlain];
//    tbvSummary.dataSource = self;
//    tbvSummary.delegate = self;
//
//    [scrollV addSubview:tbvSummary];
    [self showSignCaptureTool];
//    [scrollV addSubview:signatureViewController.view];
    
    UIButton  *acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
    acceptButton.titleLabel.text = @"Accept and Print Invoice";
    acceptButton.titleLabel.textColor = [UIColor redColor];
    
    [acceptButton setFrame:CGRectMake(75,150, 150, 30)];
    [scrollV addSubview:acceptButton];
    [self.view addSubview:scrollV];
}
}

//-(void)addAcceptbutton{
//    UIButton  *acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
////    [acceptButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
////    backButton.tag = 4;
//    acceptButton.titleLabel.text = @"Accept and Print Invoice";
//    acceptButton.titleLabel.textColor = [UIColor redColor];
//    
//    [acceptButton setFrame:CGRectMake((tableWidth-150)/2, yPos + 20, 150, 23)];
////    [backButton addTarget:self action:@selector(onclickBackButton) forControlEvents:UIControlEventTouchUpInside];
//    
//
//}

-(void)showSignCaptureTool {
    signatureViewController = [[SignCaptureViewController alloc] init];
    [signatureViewController.view setFrame:CGRectMake(20, yPos + 20, tableWidth - 60 , 200)];
    yPos+=20+200;
    signatureViewController.view.backgroundColor = [UIColor colorWithRed:58.0/255.0
                                                                   green:134.0/255.0
                                                                    blue:206.0/255.0
                                                                   alpha:0.39];
    signatureViewController.view.layer.borderWidth = 1.0;
    signatureViewController.view.layer.borderColor = [[UIColor blueColor] CGColor];
    signatureViewController.view.layer.cornerRadius = 5.0;
    signatureViewController.view.layer.masksToBounds = YES;
    
}
#pragma mark table View methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyCellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    // Configure the cell...
    
    if([selectedRow isEqual:indexPath])
    {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = [arr_NoServiceItems objectAtIndex:indexPath.row] ;
    cell.textLabel.font = [UIFont systemFontOfSize:font_TodayTableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = indexPath;
    [tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == tbvNoService) {
            return [arr_NoServiceItems count];
    }
    return 2;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return row_Height_TodayTableView;
}

@end
