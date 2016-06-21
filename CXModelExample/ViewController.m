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
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSDictionary *dic = @{
                          @"name":@"changxu",
                          @"studentId":@"2016",
                          @"age":@24,
                          @"doubleProperty":@12.25,
                          @"date":@"2016-12-13",
                          @"smallStudent":@{
                                  @"name":@"changxu",
                                  @"age":@24
                                  }
                          };
    Student *student = [Student objectWithJSON:dic];
    
    NSLog(@"%g",student.doubleProperty);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
