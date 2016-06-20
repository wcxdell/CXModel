//
//  CXProperty.m
//  CXModelExample
//
//  Created by wcxdell on 16/6/20.
//  Copyright © 2016年 wcxdell. All rights reserved.
//

#import "CXProperty.h"

@implementation CXProperty


+ (instancetype) initWithProperty:(objc_property_t) property{
    CXProperty *cxProperty = [[CXProperty alloc] init];
    cxProperty.property = property;
    cxProperty.propertyName = @(property_getName(property));
    return cxProperty;
}
@end
