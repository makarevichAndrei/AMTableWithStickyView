//
//  AMTableWithStickyView.m
//  AMTableWithStickyView
//
//  Created by Andrei Makarevich on 7/5/16.
//  Copyright © 2016 Andrei Makarevich. All rights reserved.
//

#import "AMTableWithStickyView.h"
#import "AMStickyViewDelegate.h"

@interface AMTableWithStickyView()

@property BOOL topViewCanHiding;
@property CGFloat scrollHeight;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AMStickyViewDelegate *stickyViewDelegate;

@end

@implementation AMTableWithStickyView

- (id)initWithTopView:(UIView *) topView tableView:(UITableView *)tableView  {
    return [self initWithTopView:topView tableView:tableView size:CGSizeMake(320, 480)];
}

- (id)initWithTopView:(UIView *) topView tableView:(UITableView *)tableView size:(CGSize) size {
    self = [super init];
    if (self) {
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, size.width, 44)];
        self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [topView setFrame:CGRectMake(0, self.searchBar.frame.size.height, size.width, topView.frame.size.height)];
        self.topView = topView;
        self.tableView = tableView;
        self.stickyViewDelegate = [AMStickyViewDelegate proxyWithObject:self.tableView.delegate forTableWithStickyView:self];
        self.tableView.delegate = self.stickyViewDelegate;
    
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
    
        [self setFrame:CGRectMake(0, 0, size.width, size.height)];
    
        [self addSubview:self.searchBar];
        [self addSubview:self.topView];
        [self addSubview:self.tableView];
        [self setContentOffset:CGPointMake(0, self.searchBar.frame.size.height)];
        
    }
    return self;
}

- (void)updateViewWithFrame:(CGRect)viewFrame {
    [self setFrame:viewFrame];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self updateScrollHeight];
    [self setContentOffset:CGPointMake(0, self.searchBar.frame.size.height)];
}

- (void)setUpTopView:(UIView *)topView {
    self.topView = topView;
    [self updateScrollHeight];
}

- (void)setUpTableView:(UITableView *)tableView {
    self.tableView = tableView;
    [self updateScrollHeight];
}

- (void)topViewShouldHiding:(BOOL)yesNo{
    self.topViewCanHiding = yesNo;
    self.tableView.scrollEnabled = NO;
    [self updateScrollHeight];
}

- (void)updateScrollHeight {
    self.scrollHeight = self.searchBar.frame.size.height + (self.topViewCanHiding ? self.topView.frame.size.height : 0);
    [self setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height + self.scrollHeight)];
    CGFloat y = self.searchBar.frame.size.height + self.topView.frame.size.height;
    [self.tableView setFrame:CGRectMake(0, y, self.frame.size.width, self.contentSize.height - y)];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.topViewCanHiding && ![scrollView isMemberOfClass:[UITableView class]]) {
        if (scrollView.contentOffset.y < self.searchBar.frame.size.height) {
            self.tableView.scrollEnabled = NO;
        } else {
            scrollView.scrollEnabled = NO;
            self.tableView.scrollEnabled = YES;
            self.contentOffset = CGPointMake(0, self.searchBar.frame.size.height);
            scrollView.scrollEnabled = YES;
        }
        if (self.tableView.contentOffset.y > 0) {
            self.contentOffset = CGPointMake(0, self.searchBar.frame.size.height);
        }
    } else {
        if (![scrollView isMemberOfClass:[UITableView class]]) {
            if (scrollView.contentOffset.y < self.searchBar.frame.size.height) {
                self.tableView.scrollEnabled = NO;
            } else {
                if (!(self.tableView.contentOffset.y > 0)) {
                    self.contentOffset =CGPointMake(0, self.searchBar.frame.size.height);
                    self.scrollEnabled = NO;
                }
                self.tableView.scrollEnabled = YES;
            }
        } else {
            if (scrollView.contentOffset.y < 0) {
                self.tableView.contentOffset = CGPointMake(0, 0);
                self.scrollEnabled = YES;
            }
            if (scrollView.contentOffset.y < self.topView.frame.size.height) {
                self.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + self.searchBar.frame.size.height);
            } else {
                self.contentOffset = CGPointMake(0, self.scrollHeight);
            }
        }
    }
}

@end
