//
//  AMTableWithStickyView.h
//  AMTableWithStickyView
//
//  Created by Andrei Makarevich on 7/5/16.
//  Copyright © 2016 Andrei Makarevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMTableWithStickyView : UIScrollView <UIScrollViewDelegate, UITableViewDelegate>

/**
 Accessors to customize search bar or use it create your UISearchDisplayController
 */
@property (nonatomic, strong) UISearchBar *searchBar;

/** 
 Create AMTableWithStickyView instance with default frame
 
 - parameter topView: view that should by sticky
 - parameter tableView: table view with delegate and data source
 
 */
- (id)initWithTopView:(UIView *) topView tableView:(UITableView *)tableView;

/**
 Create AMTableWithStickyView instance
 
 - parameter topView: view that should by sticky
 - parameter tableView: table view with delegate and data source
 - parameter frame: frame of instance AMTableWithStickyView
 
 */
- (id)initWithTopView:(UIView *) topView tableView:(UITableView *)tableView frame:(CGRect)frame;

/**
 Update frame of AMTableWithStickyView instance
 */
- (void)updateViewWithFrame:(CGRect)viewFrame;

/**
 Raplace sticky view with topView
 */
- (void)setUpTopView:(UIView *)topView;

/**
 Replace table with tableView
 */
- (void)setUpTableView:(UITableView *)tableView;

/**
 Setup behavior of sticky view
 */
- (void)topViewShouldHiding:(BOOL)yesNo; //default value is NO

@end
