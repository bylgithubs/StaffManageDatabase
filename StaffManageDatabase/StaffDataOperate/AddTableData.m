//
//  addTableData.m
//  StaffManageDatabase
//
//  Created by Civet on 2019/5/6.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "AddTableData.h"

#import "ViewController.h"
#import "FMDatabase.h"
#import "TableNameDropdownList.h"
#import "AlertController.h"

@interface AddTableData ()<UIPickerViewDataSource,UIPickerViewDelegate,TableNameDropdownListDelegate>

@property (nonatomic,strong) NSString *tableName;   //选中表格名称
@property (nonatomic,strong) UITextField *staffName;    //员工姓名
@property (nonatomic,strong) UITextField *staffAge;     //员工年龄
@property (nonatomic,strong) NSString *staffSex;        //员工性别
@property (nonatomic,strong) UITextField *staffDepartment;  //员工所属部门
@property (nonatomic,strong) NSArray *arrSex;       //性别Dropdown内容
@property (nonatomic,strong) NSMutableArray *tableNames;    //所有表格名称
@property (nonatomic,copy) AlertController *alertController;    //警告控制器

@end

@implementation AddTableData

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
    
    UILabel *stfName = [[UILabel alloc] initWithFrame:CGRectMake(55, 120, 100, 30)];
    [stfName setText:@"员工名字:"];
    [stfName setTextColor:[UIColor blueColor]];
    stfName.layer.borderWidth = 0;
    stfName.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:stfName];
    
    _staffName = [[UITextField alloc]initWithFrame:CGRectMake(160, 120, 150, 30)];
    _staffName.placeholder = @"请输入名字";
    _staffName.layer.borderWidth = 1;
    _staffName.layer.borderColor = [UIColor blackColor].CGColor;
    [_staffName setText:@""];
    [_staffName setTextColor:[UIColor blueColor]];
    [self.view addSubview: _staffName];
    
    UILabel *stfAge = [[UILabel alloc] initWithFrame:CGRectMake(55, 160, 100, 30)];
    [stfAge setText:@"年龄："];
    [stfAge setTextColor:[UIColor blueColor]];
    stfAge.layer.borderWidth = 0;
    stfAge.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:stfAge];
    
    _staffAge = [[UITextField alloc]initWithFrame:CGRectMake(160, 160, 150, 30)];
    _staffAge.placeholder = @"请输入年龄";
    [_staffAge setText:@""];
    _staffAge.layer.borderWidth = 1;
    _staffAge.layer.borderColor = [UIColor blackColor].CGColor;
    [_staffAge setTextColor:[UIColor blueColor]];
    [self.view addSubview: _staffAge];
    
    UILabel *stfSex = [[UILabel alloc] initWithFrame:CGRectMake(55, 200, 100, 30)];
    [stfSex setText:@"性别："];
    [stfSex setTextColor:[UIColor blueColor]];
    stfSex.layer.borderWidth = 0;
    stfSex.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:stfSex];
    
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(160, 190, 50, 50)];
  
    picker.delegate = self;
    picker.dataSource = self;
    [self.view addSubview:picker];
    _arrSex = @[@"男",@"女"];
    
    [self pickerView:picker didSelectRow:0 inComponent:0];

    UILabel *stfDepartment = [[UILabel alloc] initWithFrame:CGRectMake(55, 240, 100, 30)];
    [stfDepartment setText:@"部门："];
    [stfDepartment setTextColor:[UIColor blueColor]];
    stfDepartment.layer.borderWidth = 0;
    stfDepartment.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:stfDepartment];
    
    _staffDepartment = [[UITextField alloc]initWithFrame:CGRectMake(160, 240, 150, 30)];
    _staffDepartment.placeholder = @"请输入所在部门";
    [_staffDepartment setText:@""];
    _staffDepartment.layer.borderWidth = 1;
    _staffDepartment.layer.borderColor = [UIColor blackColor].CGColor;
    [_staffDepartment setTextColor:[UIColor blueColor]];
    [self.view addSubview: _staffDepartment];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(140, 280, 100, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"添加表格数据" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    [btn addTarget:self action:@selector(addTableData) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeSystem];
    btnBack.frame = CGRectMake(250, 280, 80, 30);
    btnBack.backgroundColor = [UIColor redColor];
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnBack.layer.borderWidth = 1;
    btnBack.layer.borderColor = [UIColor blackColor].CGColor;
    [btnBack addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];

}

//触发添加员工数据操作
- (void) addTableData{
    
    if (_tableName == nil){
        [_alertController operateController:self alertControllerWithTitle:nil message:@"表格名称不能为空，请重新选择……" actionWithTitle:@"OK"];
        return;
    }
    
    NSScanner *scan = [NSScanner scannerWithString:_staffAge.text];
    int val;
    //    NSLog(@"leixing============%d",[scan scanInt:&val] && [scan isAtEnd]);
    NSLog(@"age=============%@",_staffAge.text);
    NSInteger age = [_staffAge.text integerValue];

    if ( age > 150 || age < 16 || !([scan scanInt:&val] && [scan isAtEnd])){
        [_alertController operateController:self alertControllerWithTitle:nil message:@"年龄范围:16-150正整数" actionWithTitle:@"OK"];
        return;
    }
    
    BOOL result = nil;
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@(staff_name,staff_age,staff_sex,staff_department)VALUES(?,?,?,?)",_tableName];
    result = [[ViewController sharedDatabaseInstance].staffManageDB executeUpdate:sqlStr
              ,_staffName.text,_staffAge.text,_staffSex,_staffDepartment.text];
    
    if (result){
        
        [_alertController operateController:self alertControllerWithTitle:nil message:@"添加员工成功"];
        
    }else{
        
        [_alertController operateController:self alertControllerWithTitle:nil message:@"添加员工失败"];
    }
}

- (void) backBtn{
    
//    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回主界面");
    }];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

//显示性别选择器选项
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [NSString stringWithFormat:@"%@",_arrSex[row]];
    //return [NSString stringWithFormat:@"%lu分区%lu数据",component,row];
}
//返回选择值
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _staffSex = _arrSex[row];
    NSLog(@"性别：%@",_arrSex[row]);
    
}

//将选择器中的text转换为Label形式，并修改样式
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{

    UILabel *myView = nil;
    myView = [[UILabel alloc] initWithFrame:CGRectMake(160, 190, 50, 40)];
    myView.text = [_arrSex objectAtIndex:row];
    myView.textAlignment = NSTextAlignmentLeft;
    myView.font = [UIFont systemFontOfSize:18];
    myView.backgroundColor = [UIColor clearColor];
    
    return myView;

}

- (CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 50;
}

#pragma mark - LMJDropdownMenu Delegate

//DropdownList选择表格名称
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
