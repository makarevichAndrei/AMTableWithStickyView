//
//  AMTableWithStickyViewTests.m
//  AMTableWithStickyViewTests
//
//  Created by Andrei Makarevich on 07/18/2016.
//  Copyright (c) 2016 Andrei Makarevich. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AMTableWithStickyView/AMTableWithStickyView.h>
#import <AMTableWithStickyView/AMStickyViewDelegate.h>

@interface Tests : XCTestCase

@property (nonatomic, strong) AMTableWithStickyView *tableWithStickyView;
@property (nonatomic, strong) AMStickyViewDelegate *stickyViewDelegate;

@end

@implementation Tests

- (void)setUp {
    [super setUp];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableWithStickyView.searchBar.frame.size.height, self.tableWithStickyView.frame.size.width, 44)];
    topView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,320, 40)];
    label.text = @"Sticky View";
    label.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:label];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    self.tableWithStickyView = [[AMTableWithStickyView alloc] initWithTopView:topView tableView:tableView];
    [self.tableWithStickyView updateViewWithFrame:CGRectMake(0, 0, 320, 480)];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    XCTAssertNotNil(self.tableWithStickyView);
    XCTAssertNotNil(self.tableWithStickyView.searchBar);
    
    XCTAssertEqual(self.tableWithStickyView.frame.origin.x, 0);
    XCTAssertEqual(self.tableWithStickyView.frame.origin.y, 0);
    XCTAssertEqual(self.tableWithStickyView.frame.size.width, 320);
    XCTAssertEqual(self.tableWithStickyView.frame.size.height, 480);
    
    NSObject *object = [[NSObject alloc] init];
    self.stickyViewDelegate = [AMStickyViewDelegate proxyWithObject:object forTableWithStickyView:self.tableWithStickyView];
    XCTAssertEqualObjects(self.stickyViewDelegate.originalDelegate, object);
    XCTAssertEqualObjects(self.stickyViewDelegate.tableWithStickyView, self.tableWithStickyView);
    XCTAssertTrue([self.stickyViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        AMTableWithStickyView *scrollView = [[AMTableWithStickyView alloc] init];
        [scrollView updateViewWithFrame:CGRectMake(0, 0, 320, 480)];
        // Put the code you want to measure the time of here.
    }];
}

- (void)testDelegatePerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        NSObject *object = [[NSObject alloc] init];
        AMTableWithStickyView *tableWithStickyView = [[AMTableWithStickyView alloc] init];
        [AMStickyViewDelegate proxyWithObject:object forTableWithStickyView:tableWithStickyView];
        // Put the code you want to measure the time of here.
    }];
}

@end