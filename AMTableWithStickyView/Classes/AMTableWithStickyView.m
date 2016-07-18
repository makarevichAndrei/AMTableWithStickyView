//
//  AMTableWithStickyView.m
//  AMTableWithStickyView
//
//  Created by Andrei Makarevich on 7/5/16.
//  Copyright © 2016 Andrei Makarevich. All rights reserved.
//

#import "AMTableWithStickyView.h"
#import "AMStickyViewDelegate.h"

@interface AMTableWithStickyView () {
    BOOL _topViewCanHiding;
    CGFloat _scrollHeight;
}
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AMStickyViewDelegate *stickyViewDelegate;

@end

@implementation AMTableWithStickyView

- (id)initWithTopView:(UIView *) topView tableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [topView setFrame:CGRectMake(0, self.searchBar.frame.size.height, 320,topView.frame.size.height)];
        self.topView = topView;
        self.tableView = tableView;
        self.stickyViewDelegate = [AMStickyViewDelegate proxyWithObject:self.tableView.delegate forTableWithStickyView:self];
        self.tableView.delegate = self.stickyViewDelegate;
    
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
    
        [self setFrame:CGRectMake(0, 0, 320, 480)];
    
        [self addSubview:self.searchBar];
        [self addSubview:self.topView];
        [self addSubview:self.tableView];
        [self setContentOffset:CGPointMake(0, self.searchBar.frame.size.height)];
        
    }
    return self;
}

- (void)updateViewWithFrame:(CGRect)viewFrame {
    [self setFrame: viewFrame];
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
    _topViewCanHiding = yesNo;
    self.tableView.scrollEnabled = NO;
    [self updateScrollHeight];
}

- (void)updateScrollHeight {
    _scrollHeight = self.searchBar.frame.size.height + (_topViewCanHiding ? self.topView.frame.size.height : 0);
    [self setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height +_scrollHeight)];
    CGFloat y = self.searchBar.frame.size.height + self.topView.frame.size.height;
    [self.tableView setFrame:CGRectMake(0, y, self.frame.size.width, self.contentSize.height - y)];
}

- (void) tableWasScrolled:(UIScrollView *)scrollView {
    [self scrollViewDidScroll:scrollView];
}

#pragma mark - UIScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_topViewCanHiding && ![scrollView isMemberOfClass:[UITableView class]]) {
        if (scrollView.contentOffset.y < self.searchBar.frame.size.height) {
            self.tableView.scrollEnabled = NO;
        } else {
            self.tableView.scrollEnabled = YES;
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
                self.contentOffset = CGPointMake(0, _scrollHeight);
            }
        }
    }
}

@end
