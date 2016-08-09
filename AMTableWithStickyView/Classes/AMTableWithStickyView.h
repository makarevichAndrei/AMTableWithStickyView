//
//  AMTableWithStickyView.h
//  AMTableWithStickyView
//
//  Created by Andrei Makarevich on 7/5/16.
//  Copyright © 2016 Andrei Makarevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMTableWithStickyView : UIScrollView <UIScrollViewDelegate>

/**
 * Accessors to customize search bar or use it create your UISearchDisplayController
 */
@property (nonatomic, strong) UIView *topView;

/**
 * Create AMTableWithStickyView instance with default frame
 *
 * @param topView you top view
 * @param background shuold be copy of top view if top view is subclass of UISearchBar
 * @param stickyView view that should by sticky
 * @param tableView table view with delegate and data source
 *
 * @return instance of AMTableWithStickyView
 */
- (id)initWithTopView:(UIView *)topView searchBackground:(UIView *)background stickyView:(UIView *)stickyView tableView:(UITableView *)tableView;

/**
 * Create AMTableWithStickyView instance
 *
 * @param topView you top view
 * @param background shuold be copy of top view if top view is subclass of UISearchBar
 * @param stickyView view that should by sticky
 * @param tableView table view with delegate and data source
 * @param frame frame of instance AMTableWithStickyView
 *
 * @return instance of AMTableWithStickyView
 */
- (id)initWithTopView:(UIView *)topView searchBackground:(UIView *)background stickyView:(UIView *)stickyView tableView:(UITableView *)tableView frame:(CGRect)frame;

/**
 * Update frame of AMTableWithStickyView instance
 *
 * @param viewFrame frame that will be setted for instance of AMTableWithStickyView
 */
- (void)updateViewWithFrame:(CGRect)viewFrame;

/**
 * Raplace sticky view with topView
 *
 * @param topView view that will replace old sticky view
 */
- (void)setUpStickyView:(UIView *)stickyView;

/**
 * Replace table with tableView
 *
 * @param tableView table with delegate and data source that will repalece old table
 */
- (void)setUpTableView:(UITableView *)tableView;

/**
 * Setup behavior of sticky view
 *
 * @param yesNo bool value that setup behavoir of sticky view (default is NO)
 */
- (void)stickyViewShouldHiding:(BOOL)yesNo; //default value is NO

@end