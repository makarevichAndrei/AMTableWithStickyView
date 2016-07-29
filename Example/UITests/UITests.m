//
//  UITests.m
//  UITests
//
//  Created by Dron on 7/30/16.
//  Copyright © 2016 Andrei Makarevich. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UITests : XCTestCase

@property(nonatomic, strong) XCUIApplication *app;

@end

@implementation UITests

- (void)setUp {
    [super setUp];
    
    self.continueAfterFailure = NO;
    
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStickyViewCanNotHiding {
    
    XCUIElement *scrollView = self.app.scrollViews.element;
    XCTAssertTrue(scrollView.exists);
    XCUIElementQuery *tablesQuery = self.app.scrollViews.tables;
    XCTAssertTrue(tablesQuery);
    XCUIElement *cellStaticText = [[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:3].staticTexts[@"Cell 4"];
    [cellStaticText swipeDown];
    XCTAssertTrue([[[[self.app.scrollViews childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeSearchField].element isHittable]);
    [cellStaticText swipeUp];
    XCTAssertFalse([[[[self.app.scrollViews childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeSearchField].element isHittable]);
    [cellStaticText swipeUp];
    XCTAssertTrue([self.app.scrollViews.otherElements.staticTexts[@"Sticky View"] isHittable]);
}

- (void)testStickyViewCanHiding {
    [self.app.navigationBars[@"Sticky View"].switches[@"1"] tap];
    
    XCUIElement *scrollView = self.app.scrollViews.element;
    XCTAssertTrue(scrollView.exists);
    XCUIElementQuery *tablesQuery = self.app.scrollViews.tables;
    XCTAssertTrue(tablesQuery);
    
    XCUIElement *cellStaticText = [[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:3].staticTexts[@"Cell 4"];
    [cellStaticText swipeDown];
    XCTAssertTrue([[[[self.app.scrollViews childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeSearchField].element isHittable]);
    [cellStaticText swipeUp];
    XCTAssertFalse([[[[self.app.scrollViews childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeSearchField].element isHittable]);
    [cellStaticText swipeUp];
    XCTAssertFalse([self.app.scrollViews.otherElements.staticTexts[@"Sticky View"] isHittable]);
}

- (void)testStickyViewCanNotHidingInLandscape {
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationLandscapeLeft;
    
    XCUIElement *scrollView = self.app.scrollViews.element;
    XCTAssertTrue(scrollView.exists);
    XCUIElementQuery *tablesQuery = self.app.scrollViews.tables;
    XCTAssertTrue(tablesQuery);
    XCUIElement *cellStaticText = [[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:1].staticTexts[@"Cell 2"];
    [cellStaticText swipeDown];
    XCTAssertTrue([[[[self.app.scrollViews childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeSearchField].element isHittable]);
    [cellStaticText swipeUp];
    XCTAssertFalse([[[[self.app.scrollViews childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeSearchField].element isHittable]);
    [cellStaticText swipeUp];
    XCTAssertTrue([self.app.scrollViews.otherElements.staticTexts[@"Sticky View"] isHittable]);
    
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
}

- (void)testStickyViewCanHidingInLandscape {
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationLandscapeLeft;
    
    [self.app.navigationBars[@"Sticky View"].switches[@"1"] tap];
    
    XCUIElement *scrollView = self.app.scrollViews.element;
    XCTAssertTrue(scrollView.exists);
    XCUIElementQuery *tablesQuery = self.app.scrollViews.tables;
    XCTAssertTrue(tablesQuery);
    
    XCUIElement *cellStaticText = [[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:1].staticTexts[@"Cell 2"];
    [cellStaticText swipeDown];
    XCTAssertTrue([[[[self.app.scrollViews childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeSearchField].element isHittable]);
    [cellStaticText swipeUp];
    XCTAssertFalse([[[[self.app.scrollViews childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeSearchField].element isHittable]);
    [cellStaticText swipeUp];
    XCTAssertFalse([self.app.scrollViews.otherElements.staticTexts[@"Sticky View"] isHittable]);
    
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
}

@end
