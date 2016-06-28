//
//  CXProperty.m
//  CXModelExample
//
//  Created by wcxdell on 16/6/20.
//  Copyright © 2016年 wcxdell. All rights reserved.
//

#import "CXProperty.h"

static NSArray *systemClass;

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
    
    if ([[typeString substringToIndex:1] isEqualToString:@"@"]) {
        NSString *tmp = [typeString substringWithRange:NSMakeRange(2, typeString.length - 3)];
        if ([tmp isEqualToString:@"NSDate"]) {
            cxProperty.type = CXPropertyTypeDate;
        }else if([tmp isEqualToString:@"NSArray"]){
            cxProperty.type = CXPropertyTypeArray;
        }else if ([self isSystemClass:tmp]){
            cxProperty.type = CXPropertyTypeSystem;
        }else{
            cxProperty.type = CXPropertyTypeCustom;
        }
        cxProperty.typeClass = NSClassFromString(tmp);
    }else if ([numberArray containsObject:typeString]){
        cxProperty.type = CXPropertyTypeNumber;
    }
    
    return cxProperty;
}

+ (BOOL)isSystemClass:(id)cls{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemClass = @[[NSURL class],[NSDate class],[NSValue class],[NSData class],[NSError class],[NSArray class],[NSDictionary class],[NSString class],[NSAttributedString class]];
    });
    if ([cls isKindOfClass:[NSString class]]) {
        return [systemClass containsObject:NSClassFromString(cls)];
    }else {
        return [systemClass containsObject:cls];
    }
}
@end
