//
//  CXProperty.h
//  CXModelExample
//
//  Created by wcxdell on 16/6/20.
//  Copyright © 2016年 wcxdell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


typedef NS_ENUM(NSUInteger,CXPropertyType){
    CXPropertyTypeNumber = 0,
    CXPropertyTypeNSString,
    CXPropertyTypeDate
};



@interface CXProperty : NSObject
@property (nonatomic, assign) objc_property_t property;
@property (nonatomic, copy) NSString *propertyName;
@property (nonatomic, assign) CXPropertyType type;


+ (instancetype) initWithProperty:(objc_property_t) property;
@end
