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
#import <UIKit/UIKit.h>

#define force_inline static __inline__ __attribute__((always_inline))

@implementation NSObject (CXModel)
#pragma mark - Main
+ (instancetype) objectWithJSON:(id) json{
    json = [json getDic];
    if (!json || json == [NSNull null]) return nil;
    
    id object = [[self alloc] init];
    return [object setProperties:json];
}

- (instancetype) setProperties:(NSDictionary*)dic{
    
    //获取属性列表
    NSArray *properties = [[self class] getProperties];
    
    //赋值
    for (CXProperty * property in properties) {
        id value;
        value = [dic objectForKey:property.propertyName];
        
        if (property.type == CXPropertyTypeDate) {
            value = CXNSDateFromString(value);
        }
        
        if (property.type == CXPropertyTypeCustom) {
            value = [property.typeClass objectWithJSON:value];
        }
        
        if (!value || value == [NSNull null]) {
            continue;
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

force_inline NSDate *CXNSDateFromString(__unsafe_unretained NSString *string) {
    typedef NSDate* (^CXNSDateParseBlock)(NSString *string);
    #define kParserNum 34
    static CXNSDateParseBlock blocks[kParserNum + 1] = {0};
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        {
            /*
             2014-01-20
             */
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter.dateFormat = @"yyyy-MM-dd";
            blocks[10] = ^(NSString *string) {
                
                if ([string rangeOfString:@"-"].location == NSNotFound) {
                    return [NSDate dateWithTimeIntervalSince1970:[string integerValue]];
                }
                return [formatter dateFromString:string];
            };
        }
        
        {
            /*
             2014-01-20 12:24:48
             2014-01-20T12:24:48
             2014-01-20 12:24:48.000
             2014-01-20T12:24:48.000
             */
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            formatter1.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter1.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter1.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
            
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter2.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            
            NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
            formatter3.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter3.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter3.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
            
            NSDateFormatter *formatter4 = [[NSDateFormatter alloc] init];
            formatter4.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter4.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter4.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
            
            blocks[19] = ^(NSString *string) {
                if ([string characterAtIndex:10] == 'T') {
                    return [formatter1 dateFromString:string];
                } else {
                    return [formatter2 dateFromString:string];
                }
            };
            
            blocks[23] = ^(NSString *string) {
                if ([string characterAtIndex:10] == 'T') {
                    return [formatter3 dateFromString:string];
                } else {
                    return [formatter4 dateFromString:string];
                }
            };
        }
        
        {
            /*
             2014-01-20T12:24:48Z
             2014-01-20T12:24:48+0800
             2014-01-20T12:24:48+12:00
             2014-01-20T12:24:48.000Z
             2014-01-20T12:24:48.000+0800
             2014-01-20T12:24:48.000+12:00
             */
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
            
            NSDateFormatter *formatter2 = [NSDateFormatter new];
            formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
            
            blocks[20] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[24] = ^(NSString *string) { return [formatter dateFromString:string]?: [formatter2 dateFromString:string]; };
            blocks[25] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[28] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
            blocks[29] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
        }
        
        {
            /*
             Fri Sep 04 00:12:21 +0800 2015
             Fri Sep 04 00:12:21.000 +0800 2015
             */
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
            
            NSDateFormatter *formatter2 = [NSDateFormatter new];
            formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.dateFormat = @"EEE MMM dd HH:mm:ss.SSS Z yyyy";
            
            blocks[30] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[34] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
        }
    });
    if (!string) return nil;
    if (string.length > kParserNum) return nil;
    CXNSDateParseBlock parser = blocks[string.length];
    if (!parser) return nil;
    return parser(string);
    #undef kParserNum
}


@end
