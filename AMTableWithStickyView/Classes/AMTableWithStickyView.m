//
//  AMTableWithStickyView.m
//  AMTableWithStickyView
//
//  Created by Andrei Makarevich on 7/5/16.
//  Copyright © 2016 Andrei Makarevich. All rights reserved.
//

#import "AMTableWithStickyView.h"

@interface AMTableWithStickyView()

@property BOOL topViewCanHiding;
@property CGFloat scrollHeight;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AMTableWithStickyView {
    BOOL _observerIsSeted;
    BOOL _scrollHeightIsUpdating;
}

- (id)initWithSearchBar:(UIView *)searchBar topView:(UIView *)topView tableView:(UITableView *)tableView {
    return [self initWithSearchBar:searchBar topView:topView tableView:tableView frame:CGRectMake(0, 0, 320, 480)];
}

- (id)initWithSearchBar:(UIView *)searchBar topView:(UIView *)topView tableView:(UITableView *)tableView frame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.searchBar = searchBar;
        [topView setFrame:CGRectMake(0, self.searchBar.frame.size.height, frame.size.width, topView.frame.size.height)];
        self.topView = topView;
        self.tableView = tableView;
        _observerIsSeted = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        
        [self setFrame:frame];
        
        [self addSubview:self.searchBar];
        [self addSubview:self.topView];
        [self addSubview:self.tableView];
        
    }
    return self;
}

- (id)initWithTopView:(UIView *) topView tableView:(UITableView *)tableView  {
    return [self initWithTopView:topView tableView:tableView frame:CGRectMake(0, 0, 320, 480)];
}

- (id)initWithTopView:(UIView *) topView tableView:(UITableView *)tableView frame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.searchBar = (UIView *)[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [topView setFrame:CGRectMake(0, self.searchBar.frame.size.height, frame.size.width, topView.frame.size.height)];
        self.topView = topView;
        self.tableView = tableView;
        _observerIsSeted = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
    
        [self setFrame:frame];
    
        [self addSubview:self.searchBar];
        [self addSubview:self.topView];
        [self addSubview:self.tableView];
        
    }
    return self;
}

- (void)updateViewWithFrame:(CGRect)viewFrame {
    [self setFrame:viewFrame];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self updateScrollHeight];
}

- (void)setUpTopView:(UIView *)topView {
    self.topView = topView;
    [self updateScrollHeight];
}

- (void)setUpTableView:(UITableView *)tableView {
    [self removeObserverForTable];
    self.tableView = tableView;
    [self updateScrollHeight];
}

- (void)topViewShouldHiding:(BOOL)yesNo{
    self.topViewCanHiding = yesNo;
    self.tableView.scrollEnabled = NO;
    [self updateScrollHeight];
}

- (void)updateScrollHeight {
    _scrollHeightIsUpdating = YES;
    [self.searchBar setFrame:CGRectMake(0, 0, self.frame.size.width, self.searchBar.frame.size.height)];
    self.scrollHeight = self.searchBar.frame.size.height + (self.topViewCanHiding ? self.topView.frame.size.height : 0);
    [self setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height + self.scrollHeight)];
    [self.topView setFrame:CGRectMake(0, self.searchBar.frame.size.height, self.frame.size.width, self.topView.frame.size.height)];
    CGFloat y = self.searchBar.frame.size.height + self.topView.frame.size.height;
    [self.tableView setFrame:CGRectMake(0, y, self.frame.size.width, self.contentSize.height - y)];
    _scrollHeightIsUpdating = NO;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqual:@"contentOffset"] && !_scrollHeightIsUpdating) {
        [self scrollViewDidScroll:self.tableView];
    }
}

- (void)setUpObserverForTable {
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    _observerIsSeted = YES;
}

- (void)removeObserverForTable {
    if (_observerIsSeted) {
        [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
        _observerIsSeted = NO;
    }
}

- (void)dealloc {
    [self removeObserverForTable];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.topViewCanHiding && ![scrollView isKindOfClass:[UITableView class]]) {
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
        if (![scrollView isKindOfClass:[UITableView class]]) {
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
