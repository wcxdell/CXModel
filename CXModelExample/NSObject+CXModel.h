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
+ (instancetype) objectWithJSON:(id) json;
+ (NSArray*) arrayWithJSON:(id) json;
- (NSDictionary*) dicValues;
+ (NSArray *) dicArray:(NSArray *) array;
@end