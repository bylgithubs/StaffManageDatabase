//
//  SelectTableData.m
//  StaffManageDatabase
//
//  Created by Civet on 2019/5/6.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "SelectTableData.h"

#import "ViewController.h"
#import "FMDatabase.h"
#import "TableNameDropdownList.h"
#import "AlertController.h"

@interface SelectTableData ()<TableNameDropdownListDelegate>

@property (nonatomic,strong) NSString *tableName;
@property (nonatomic,strong) UITextField *staffTF;  //员工ID
@property (nonatomic,strong) UITextView *staffDataTV;   //显示查询到的所有员工信息
@property (nonatomic,strong) NSMutableArray *tableNames;    //所有表格名称
@property (nonatomic,copy) AlertController *alertController;    //声明警告控制器

@end

@implementation SelectTableData

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _alertController = [AlertController sharedAlertController];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *tbName = [[UILabel alloc] initWithFrame:CGRectMake(55, 80, 100, 30)];
    [tbName setText:@"表格名称:"];
    [tbName setTextColor:[UIColor blueColor]];
    tbName.layer.borderWidth = 0;
    tbName.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:tbName];
    
    TableNameDropdownList *tableNameDropDownList = [[TableNameDropdownList alloc] init];
    _tableNames = tableNameDropDownList.tableNames;
    
    NSLog(@"adddata============tablename=========%@",_tableNames);
    TableNameDropdownList *tableNameDropdownList = [[TableNameDropdownList alloc] init];
    [tableNameDropdownList setFrame:CGRectMake(160, 80, 150, 30)];
    [tableNameDropdownList setDropdownList:_tableNames rowHeight:30];
    tableNameDropdownList.delegate = self;
    [self.view addSubview:tableNameDropdownList];
    
    UILabel *stfId = [[UILabel alloc] initWithFrame:CGRectMake(55, 120, 100, 30)];
    [stfId setText:@"员工ID:"];
    [stfId setTextColor:[UIColor blueColor]];
    stfId.layer.borderWidth = 0;
    stfId.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:stfId];
    
    _staffTF = [[UITextField alloc]initWithFrame:CGRectMake(160, 120, 150, 30)];
    _staffTF.placeholder = @"请输入员工ID";
    _staffTF.layer.borderWidth = 1;
    _staffTF.layer.borderColor = [UIColor blackColor].CGColor;
    //[_staffTF setText:@""];
    [_staffTF setTextColor:[UIColor blueColor]];
    [self.view addSubview: _staffTF];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(80, 160, 100, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"查询员工数据" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    [btn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeSystem];
    btnBack.frame = CGRectMake(200, 160, 80, 30);
    btnBack.backgroundColor = [UIColor redColor];
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnBack.layer.borderWidth = 1;
    btnBack.layer.borderColor = [UIColor blackColor].CGColor;
    [btnBack addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    _staffDataTV = [[UITextView alloc]initWithFrame:CGRectMake(40, 200, 330, 300)];
    _staffDataTV.layer.borderWidth = 1;
    _staffDataTV.layer.borderColor = [UIColor blackColor].CGColor;
    [_staffDataTV setText:@""];
    [_staffDataTV setTextColor:[UIColor blueColor]];
    [self.view addSubview: _staffDataTV];
    
    
}

//触发查询员工信息操作
- (void) select:(id)sender{
    
    if (_tableName == nil){
        [_alertController operateController:self alertControllerWithTitle:nil message:@"表格名称不能为空，请重新选择……" actionWithTitle:@"OK"];
        return;
    }
    
    FMResultSet *resultSet;
    NSLog(@"text===========%@",_staffTF.text);
    NSString *sqlStr = [NSString stringWithFormat:@"select * from %@ ",_tableName];
    NSString *sqlStr1 = [sqlStr stringByAppendingString:@" where staff_id = ?"];
    
    if (![_staffTF.text isEqual: @""]){
        resultSet = [[ViewController sharedDatabaseInstance].staffManageDB executeQuery:sqlStr1,_staffTF.text];
    }else{
        resultSet = [[ViewController sharedDatabaseInstance].staffManageDB executeQuery:sqlStr];
    }
    
    NSString *staffString = [NSString stringWithFormat:@"%@\n",_tableName];
    //遍历结果集合
    while ([resultSet next]) {
        NSInteger staffId = [resultSet intForColumn:@"staff_id"];
        NSString *staffName = [resultSet objectForColumn:@"staff_name"];
        NSInteger staffAge = [resultSet intForColumn:@"staff_age"];
        NSString *staffSex = [resultSet objectForColumn:@"staff_sex"];
        NSString *staffDepartment = [resultSet objectForColumn:@"staff_department"];
        NSString *str = [NSMutableString stringWithFormat:@"工号：%@ 姓名：%@ 年龄：%@ 性别：%@ 部门：%@\n",@(staffId),staffName,@(staffAge),staffSex,staffDepartment];
        staffString = [staffString stringByAppendingString:str];
        NSLog(@"str=============%@",staffString);
        
        NSLog(@"工号：%@ 姓名：%@ 年龄：%@ 性别：%@ 部门：%@",@(staffId),staffName,@(staffAge),staffSex,staffDepartment);
    }
    [_staffDataTV setText:staffString];
}

- (void) backBtn{
    
//    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回主界面");
    }];
    
}

#pragma mark - LMJDropdownMenu Delegate

- (void)dropdownList:(TableNameDropdownList *)list selectedCellNumber:(NSInteger)number{
    
    _tableName = _tableNames[number];
    NSLog(@"你选择了：%ld,%@",number,_tableNames[number]);
}

- (void)dropdownListWillShow:(TableNameDropdownList *)list{
    
    if ([ViewController sharedDatabaseInstance].staffManageDB == nil){
        [_alertController operateController:self alertControllerWithTitle:nil message:@"请先打开数据库……" actionWithTitle:@"OK"];
    }
    NSLog(@"--将要显示--");
}
- (void)dropdownListDidShow:(TableNameDropdownList *)list{
    NSLog(@"--已经显示--");
}

- (void)dropdownListWillHidden:(TableNameDropdownList *)list{
    
    if ([ViewController sharedDatabaseInstance].staffManageDB == nil){
        [_alertController operateController:self alertControllerWithTitle:nil message:@"请先打开数据库……" actionWithTitle:@"OK"];
    }
    NSLog(@"--将要隐藏--");
}
- (void)dropdownListDidHidden:(TableNameDropdownList *)list{
    NSLog(@"--已经隐藏--");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
