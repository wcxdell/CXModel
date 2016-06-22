//
//  Student.h
//  CXModelExample
//
//  Created by wcxdell on 16/6/20.
//  Copyright © 2016年 wcxdell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Student : Person
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *studentId;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) double doubleProperty;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) Student *smallStudent;
@property (nonatomic, strong) NSArray *studentArray;
@end
