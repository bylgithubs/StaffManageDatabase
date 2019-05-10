//
//  StaffEntity.h
//  StaffManageDatabase
//
//  Created by Civet on 2019/5/3.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StaffEntity : NSObject

@property(nonatomic,assign) NSInteger staff_id; //员工id
@property(nonatomic,strong) NSString *staff_Name;   //员工姓名
@property(nonatomic,assign) NSInteger staff_age;    //员工年龄
@property(nonatomic,strong) NSString *staff_sex;    //员工性别
@property(nonatomic,strong) NSString *staff_department;    //员工部门

@end
