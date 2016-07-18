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

@property (nonatomic, strong) NSObject *originalDelegate;
@property (nonatomic, weak) AMTableWithStickyView *tableWithStickyView;

+ (instancetype)proxyWithObject:(NSObject *)object forTableWithStickyView:(AMTableWithStickyView *)tableWithStickyView;

@end
