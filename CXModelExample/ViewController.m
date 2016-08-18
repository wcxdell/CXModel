//
//  ViewController.m
//  CXModelExample
//
//  Created by wcxdell on 16/6/20.
//  Copyright © 2016年 wcxdell. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "CXModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self jsonToModel];
    [self modelToDic];
    
}

//json转模型
- (void) jsonToModel{
    NSDictionary *dic = @{
                          @"name":@"changxu",
                          @"studentId":@"2016",
                          @"age":@24,
                          @"doubleProperty":@12.25,
                          @"date":@"2016-12-13",
                          @"smallStudent":@{
                                  @"name":@"changxu",
                                  @"age":@24
                                  },
                          @"studentArray":@[
                                  @{
                                      @"name":@"changxu",
                                      @"studentId":@"2015"
                                      },
                                  @{
                                      @"age":@14,
                                      @"date":@"1992-02-18"
                                      }
                                  ]
                          };
    
    
    Student *student = [Student cx_objectWithJSON:dic];
    NSLog(@"\n字典转模型\n请自行调试student对象");
}
//模型转字典
- (void) modelToDic{
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<2; i++) {
        Student *tmpStudent = [[Student alloc] init];
        tmpStudent.name = @"changxu";
        [array addObject:tmpStudent];
    }
    
    Student *smallStudent = [[Student alloc] init];
    smallStudent.name = @"changxu";
    smallStudent.age = 24;
    
    Student *student = [[Student alloc] init];
    student.name = @"changxu";
    student.studentId = @"2016";
    student.age = 24;
    student.doubleProperty = 12.25;
    student.smallStudent = smallStudent;
    student.date = [NSDate date];
    student.studentArray = array;
    
    NSDictionary *testDic = [student cx_dicValues];
    NSLog(@"\n模型转字典\n%@",testDic);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
