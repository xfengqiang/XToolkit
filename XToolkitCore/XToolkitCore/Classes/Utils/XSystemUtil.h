//
//  XSystemUtil.h
//  XToolkitCore
//
//  Created by frank.xu on 11/27/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XSystemUtil : NSObject
SINGLETON_FOR_CLASS_HEADER(XSystemUtil)

+ (CGFloat)systemVersion;
@end
