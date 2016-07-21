//
//  AMTableWithStickyView.h
//  AMTableWithStickyView
//
//  Created by Andrei Makarevich on 7/5/16.
//  Copyright © 2016 Andrei Makarevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMTableWithStickyView : UIScrollView <UIScrollViewDelegate, UITableViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

- (id)initWithTopView:(UIView *) topView tableView:(UITableView *)tableView;
- (id)initWithTopView:(UIView *) topView tableView:(UITableView *)tableView size:(CGSize) size;
- (void)updateViewWithFrame:(CGRect)viewFrame;


- (void)setUpTopView:(UIView *)topView;
- (void)setUpTableView:(UITableView *)tableView;

- (void)topViewShouldHiding:(BOOL)yesNo; //default value is NO

@end
