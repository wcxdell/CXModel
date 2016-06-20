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
    
    NSString *attrString = @(property_getAttributes(property));
    
    NSUInteger commaLoc = [attrString rangeOfString:@","].location;
    
    NSString *typeString = [attrString substringWithRange:NSMakeRange(1, commaLoc - 1)];
    
    static NSArray *numberArray;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        numberArray = @[@"d",@"f",@"i",@"l",@"s"];
    });
    
    if ([typeString isEqualToString:@"@\"NSString\""]) {
        cxProperty.type = CXPropertyTypeNSString;
    }else if ([numberArray containsObject:typeString]){
        cxProperty.type = CXPropertyTypeNumber;
    }else if ([typeString isEqualToString:@"@\"NSDate\""]){
        cxProperty.type = CXPropertyTypeDate;
    }
    
    return cxProperty;
}
@end
