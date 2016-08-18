//
//  NSObject+CXModel.h
//  CXModelExample
//
//  Created by wcxdell on 16/6/20.
//  Copyright © 2016年 wcxdell. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CXModel <NSObject>

@optional
+ (NSDictionary *) classInArray;

@end

@interface NSObject (CXModel) <CXModel>
+ (instancetype) cx_objectWithJSON:(id) json;
+ (NSArray*) cx_arrayWithJSON:(id) json;
- (NSDictionary*) cx_dicValues;
+ (NSArray *) cx_dicArray:(NSArray *) array;
@end