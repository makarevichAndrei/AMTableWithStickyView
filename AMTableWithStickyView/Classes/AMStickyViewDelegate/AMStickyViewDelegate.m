//
//  AMStickyViewDelegate.m
//  AMStickyView
//
//  Created by Dron on 7/10/16.
//  Copyright © 2016 Andrei Makarevich. All rights reserved.
//

#import "AMStickyViewDelegate.h"

@implementation AMStickyViewDelegate

-(instancetype)initWithObject:(NSObject*)object forTableWithStickyView:(AMTableWithStickyView *)tableWithStickyView {
    self.originalDelegate = object;
    self.tableWithStickyView = tableWithStickyView;
    return self;
}

+ (instancetype)proxyWithObject:(NSObject *)object forTableWithStickyView:(AMTableWithStickyView *)tableWithStickyView {
    return [[self alloc] initWithObject:object forTableWithStickyView:(AMTableWithStickyView *)tableWithStickyView];
}


- (BOOL)respondsToSelector:(SEL)selector {
    NSString *sel = NSStringFromSelector(selector);
    if ([sel isEqualToString:@"scrollViewDidScroll:"]) {
        return YES;
    }
    return [self.originalDelegate respondsToSelector:selector];
}

- (id)forwardingTargetForSelector:(SEL)selector {
    id delegate = self.originalDelegate;
    return [delegate respondsToSelector:selector] ? delegate : self;
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [self.originalDelegate methodSignatureForSelector:selector];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableWithStickyView performSelector:@selector(scrollViewDidScroll:) withObject:scrollView];
}

@end
