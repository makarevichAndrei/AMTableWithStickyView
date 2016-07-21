//
//  AMViewController.m
//  AMTableWithStickyView
//
//  Created by Andrei Makarevich on 07/18/2016.
//  Copyright (c) 2016 Andrei Makarevich. All rights reserved.
//

#import "AMTableWithStickyView.h"
#import "AMViewController.h"

@interface AMViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) AMTableWithStickyView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, weak) IBOutlet UISwitch *switchButton;
@property (nonatomic, strong) NSMutableArray *tableData;

@end

@implementation AMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.switchButton setOn:YES];
    
    self.tableData = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 2; i++) {
        NSArray *arr = @[@"Cell 1",
                         @"Cell 2",
                         @"Cell 3",
                         @"Cell 4",
                         @"Cell 5",
                         @"Cell 6",
                         @"Cell 7",
                         @"Cell 8",
                         @"Cell 9",
                         @"Cell 10",
                         @"Cell 11",
                         @"Cell 12",
                         @"Cell 13",
                         @"Cell 14",
                         @"Cell 15",
                         @"Cell 16",
                         @"Cell 17",
                         @"Cell 18",
                         @"Cell 19",
                         @"Cell 20"];
        
        [self.tableData addObject:arr];
    }
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.scrollView.searchBar.frame.size.height, self.scrollView.frame.size.width, 44)];
    self.topView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    label.text = @"Sticky View";
    label.textAlignment = NSTextAlignmentCenter;
    [self.topView addSubview:label];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.scrollView = [[AMTableWithStickyView alloc] initWithTopView:self.topView tableView:self.tableView frame:self.view.frame];
    [self.view addSubview:self.scrollView];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.scrollView updateViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}

- (IBAction)switchToggled:(UISwitch *)sender {
    if (sender.isOn) {
        [self.scrollView topViewShouldHiding:NO];
    } else {
        [self.scrollView topViewShouldHiding:YES];
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableData count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    NSInteger rowsCount = [self.tableData[section] count];
    return rowsCount;
}

- (CGFloat)tableView:(UITableView *)table heightForHeaderInSection:(NSInteger)section {
    return 22.0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.tableData[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
    view.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
    label.text = [NSString stringWithFormat:@"Section %d", (int)section + 1];
    [view addSubview:label];
    return view;
}

#pragma mark - Device rotation support

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.scrollView updateViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}

@end
