# CXModel
字典模型互转工具
## 功能
实现功能大致有json转模型，模型转字典，嵌套模型的转换，缓存，模型数组与字典数组的互转并且对date类型有特殊的处理。
## 复杂字典转模型
```
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
Student *student = [Student objectWithJSON:dic];
```
##模型转字典
```
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

NSDictionary *testDic = [student dicValues];
```
##说明
该工具实现了字典模型互转的核心功能，但并不完善，建议用于学习而不是用于实际工程的开发。


