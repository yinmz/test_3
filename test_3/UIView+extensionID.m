//
//  UIView+extensionID.m
//  test_3
//
//  Created by bytedance on 2020/5/20.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "UIView+extensionID.h"

#import <objc/runtime.h>


@implementation UIView (extensionID)

- (void)setNumber:(NSNumber *)number {
    objc_setAssociatedObject(self, @selector(number), number, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)number { 
    return objc_getAssociatedObject(self, _cmd);
}

@end
