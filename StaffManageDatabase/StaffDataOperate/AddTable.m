//
//  AddTable.m
//  StaffManageDatabase
//
//  Created by Civet on 2019/5/6.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "AddTable.h"

#import "ViewController.h"
#import "FMDatabase.h"
#import "AlertController.h"
#import "AlertController.h"

@interface AddTable ()

@property (nonatomic,strong) UITextField *tableName;    //表格名称
@property (nonatomic,copy) AlertController *alertController;    //声明警告控制器对象

@end

@implementation AddTable

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
    
    _tableName = [[UITextField alloc]initWithFrame:CGRectMake(160, 80, 150, 30)];
    _tableName.placeholder = @"请输入表格名称";
    _tableName.layer.borderWidth = 1;
    _tableName.layer.borderColor = [UIColor blackColor].CGColor;
    [_tableName setText:@""];
    [_tableName setTextColor:[UIColor blueColor]];
    [self.view addSubview: _tableName];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(140, 120, 100, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"新建表格" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    [btn addTarget:self action:@selector(addTable) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeSystem];
    btnBack.frame = CGRectMake(250, 120, 80, 30);
    btnBack.backgroundColor = [UIColor redColor];
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnBack.layer.borderWidth = 1;
    btnBack.layer.borderColor = [UIColor blackColor].CGColor;
    [btnBack addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    
}

//触发添加表格操作
- (void) addTable{
    
    //判断是否打开数据库
    if ([ViewController sharedDatabaseInstance].staffManageDB == nil){
        
        [_alertController operateController:self alertControllerWithTitle:nil message:@"请先打开数据库……" actionWithTitle:@"OK"];
    
        return;
    }
    //表格名称是否为空
    if ([_tableName.text isEqualToString:@""]){

        [_alertController operateController:self alertControllerWithTitle:nil message:@"表格名称不能为空，请重新输入……" actionWithTitle:@"OK"];
        
        return;
    }
    BOOL result = nil;
    NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(staff_id integer PRIMARY KEY AUTOINCREMENT,staff_name text NOT NULL,staff_age integer, staff_sex text,staff_department)",_tableName.text];
    NSLog(@"sqlStr================%@",sqlStr);
    result = [[ViewController sharedDatabaseInstance].staffManageDB executeUpdate:sqlStr];
    
    if (result){
        [_alertController operateController:self alertControllerWithTitle:nil message:@"新建表格成功"];
    }else{
        [_alertController operateController:self alertControllerWithTitle:nil message:@"新建表格失败"];
    }
}

- (void) backBtn{
    
//    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回主界面");
    }];
    
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
