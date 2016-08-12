//
//  AMTableWithStickyView.m
//  AMTableWithStickyView
//
//  Created by Andrei Makarevich on 7/5/16.
//  Copyright © 2016 Andrei Makarevich. All rights reserved.
//

#import "AMTableWithStickyView.h"

@interface AMTableWithStickyView()

@property BOOL stickyViewCanHiding;
@property CGFloat scrollHeight;
@property (nonatomic, strong) UIView *stickyView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation AMTableWithStickyView {
    BOOL _scrollHeightIsUpdating;
}

- (id)initWithTopView:(UIView *)topView searchBackground:(UIView *)background stickyView:(UIView *)stickyView tableView:(UITableView *)tableView {
    return [self initWithTopView:topView searchBackground:background stickyView:stickyView tableView:tableView frame:CGRectMake(0, 0, 320, 480)];
}

- (id)initWithTopView:(UIView *)searchBar searchBackground:(UIView *)background stickyView:(UIView *)stickyView tableView:(UITableView *)tableView frame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.topView = searchBar;
        [stickyView setFrame:CGRectMake(0, self.topView.frame.size.height, frame.size.width, stickyView.frame.size.height)];
        self.backgroundView = background;
        [self.backgroundView setFrame:self.topView.frame];
        self.stickyView = stickyView;
        self.tableView = tableView;
        [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        
        [self setFrame:frame];
        
        [self addSubview:self.backgroundView];
        [self addSubview:self.topView];
        [self addSubview:self.stickyView];
        [self addSubview:self.tableView];
        [self setContentOffset:CGPointMake(0, self.topView.frame.size.height)];
        
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

- (void)setUpStickyView:(UIView *)stickyView {
    self.stickyView = stickyView;
    [self updateScrollHeight];
}

- (void)setUpTableView:(UITableView *)tableView {
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
    self.tableView = tableView;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self updateScrollHeight];
}

- (void)stickyViewShouldHiding:(BOOL)yesNo{
    self.stickyViewCanHiding = yesNo;
    self.tableView.scrollEnabled = NO;
    [self updateScrollHeight];
}

- (void)updateScrollHeight {
    _scrollHeightIsUpdating = YES;
    [self.topView setFrame:CGRectMake(0, 0, self.frame.size.width, self.topView.frame.size.height)];
    [self.backgroundView setFrame:CGRectMake(0, 0, self.frame.size.width, self.topView.frame.size.height)];
    self.scrollHeight = self.topView.frame.size.height + (self.stickyViewCanHiding ? self.stickyView.frame.size.height : 0);
    [self setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height + self.scrollHeight)];
    [self.stickyView setFrame:CGRectMake(0, self.topView.frame.size.height, self.frame.size.width, self.stickyView.frame.size.height)];
    CGFloat y = self.topView.frame.size.height + self.stickyView.frame.size.height;
    [self.tableView setFrame:CGRectMake(0, y, self.frame.size.width, self.contentSize.height - y)];
    _scrollHeightIsUpdating = NO;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqual:@"contentOffset"] && !_scrollHeightIsUpdating) {
        [self scrollViewDidScroll:self.tableView];
    }
}

- (void)dealloc {
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.stickyViewCanHiding && ![scrollView isKindOfClass:[UITableView class]]) {
        if (scrollView.contentOffset.y < self.topView.frame.size.height) {
            self.tableView.scrollEnabled = NO;
        } else {
            scrollView.scrollEnabled = NO;
            self.tableView.scrollEnabled = YES;
            self.contentOffset = CGPointMake(0, self.topView.frame.size.height);
            scrollView.scrollEnabled = YES;
        }
        if (self.tableView.contentOffset.y > 0) {
            self.contentOffset = CGPointMake(0, self.topView.frame.size.height);
        }
    } else {
        if (![scrollView isKindOfClass:[UITableView class]]) {
            if (scrollView.contentOffset.y < self.topView.frame.size.height) {
                self.tableView.scrollEnabled = NO;
            } else {
                if (!(self.tableView.contentOffset.y > 0)) {
                    self.contentOffset =CGPointMake(0, self.topView.frame.size.height);
                    self.scrollEnabled = NO;
                }
                self.tableView.scrollEnabled = YES;
            }
        } else {
            if (scrollView.contentOffset.y < 0) {
                self.tableView.contentOffset = CGPointMake(0, 0);
                self.scrollEnabled = YES;
            }
            if (scrollView.contentOffset.y < self.stickyView.frame.size.height) {
                self.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + self.topView.frame.size.height);
            } else {
                self.contentOffset = CGPointMake(0, self.scrollHeight);
            }
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y >= self.topView.frame.size.height/2) {
        [scrollView setContentOffset:CGPointMake(0, self.topView.frame.size.height) animated:YES];
    } else {
        [scrollView setContentOffset:CGPointZero animated:YES];
    }
}

@end
