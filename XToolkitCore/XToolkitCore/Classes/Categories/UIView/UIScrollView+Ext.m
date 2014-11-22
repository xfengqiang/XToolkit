//
//  UIScrollView+Ext.m
//  XToolkitCore
//
//  Created by frank.xu on 11/27/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "UIScrollView+Ext.h"

@implementation UIScrollView(Ext)
- (UIPanGestureRecognizer *)getPangestureRecognizer
{
    UIPanGestureRecognizer *panGesture = nil;
    if ([self respondsToSelector:@selector(panGestureRecognizer)])
    {
        panGesture = [self panGestureRecognizer];
    }
    else
    {
        for (UIGestureRecognizer *g in self.gestureRecognizers)
        {
            if ([g isKindOfClass:[UIPanGestureRecognizer class]])
            {
                panGesture = (UIPanGestureRecognizer*)g;
                break;
            }
        }
    }
    return panGesture;
}
@end
