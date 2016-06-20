//
//  NSObject+CXModel.m
//  CXModelExample
//
//  Created by wcxdell on 16/6/20.
//  Copyright © 2016年 wcxdell. All rights reserved.
//

#import "NSObject+CXModel.h"
#import <objc/runtime.h>
#import "CXProperty.h"

@implementation NSObject (CXModel)

#pragma mark - Main
+ (instancetype) objectWithJSON:(id) json{
    json = [json getDic];
    if (!json || json == [NSNull null]) return nil;
    
    id object = [[self alloc] init];
    return [object setProperties:json];
}

- (instancetype) setProperties:(NSDictionary*)dic{
    
    NSArray *properties = [[self class] getProperties];
    
    for (CXProperty * property in properties) {
        id value;
        value = [dic objectForKey:property.propertyName];
        
        if (!value || value == [NSNull null]) {
            return nil;
        }
        
        [self setValue:value forKey:property.propertyName];
        
    }
    
    
    
    return self;
}

+ (NSArray *) getProperties{
    NSMutableArray *propertyArray = [NSMutableArray array];
    Class cls = self;
    while (cls != [NSObject class]) {
        unsigned int propertyCount = 0;
        
        objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
        
        for (int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            CXProperty *cxProperty = [CXProperty initWithProperty:property];
            [propertyArray addObject:cxProperty];
        }
        cls = class_getSuperclass(cls);
    }
    return propertyArray;
}



#pragma mark - Util
- (id) getDic{
    if ([self isKindOfClass:[NSData class]]) {
        return [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    }else if ([self isKindOfClass:[NSString class]]){
        return [NSJSONSerialization JSONObjectWithData:[((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }else{
        return self;
    }
}
@end
