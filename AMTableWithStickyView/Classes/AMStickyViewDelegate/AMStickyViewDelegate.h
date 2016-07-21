//
//  AMStickyViewDelegate.h
//  AMStickyView
//
//  Created by Dron on 7/10/16.
//  Copyright © 2016 Andrei Makarevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AMTableWithStickyView.h"

@interface AMStickyViewDelegate : NSProxy<UITableViewDelegate>

/**
 Stored original table delagate from AMTableWithStickyView
 */
@property (nonatomic, strong) NSObject *originalDelegate;
/**
 Stored reference to instance of AMTableWithStickyView
 */
@property (nonatomic, weak) AMTableWithStickyView *tableWithStickyView;

/**
 Create a instance of AMStickyViewDelegate
 
 - parameter object: it shoud be delegate of table in AMTableWithStickyView
 - parameter tableWithStickyView: AMTableWithStickyView where proxy delegate will replace original delegate of table
 
 */
+ (instancetype)proxyWithObject:(NSObject *)object forTableWithStickyView:(AMTableWithStickyView *)tableWithStickyView;

@end
