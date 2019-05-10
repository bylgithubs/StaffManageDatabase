//
//  DeleteTable.m
//  StaffManageDatabase
//
//  Created by Civet on 2019/5/6.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "DeleteTable.h"

#import "ViewController.h"
#import "FMDatabase.h"
#import "TableNameDropdownList.h"
#import "AlertController.h"

@interface DeleteTable ()<TableNameDropdownListDelegate>

@property (nonatomic,strong) NSString *tableName;   //选中表格名称
@property (nonatomic,strong) NSMutableArray *tableNames;    //所有表格名称
@property (nonatomic,copy) AlertController *alertController;

@end

@implementation DeleteTable

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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(80, 120, 100, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"删除表格" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    [btn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeSystem];
    btnBack.frame = CGRectMake(220, 120, 80, 30);
    btnBack.backgroundColor = [UIColor redColor];
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnBack.layer.borderWidth = 1;
    btnBack.layer.borderColor = [UIColor blackColor].CGColor;
    [btnBack addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
}

//触发删除员工操作
- (void) delete:(id)sender{
    if (_tableName == nil){
         [_alertController operateController:self alertControllerWithTitle:nil message:@"表格名称不能为空，请重新选择……" actionWithTitle:@"OK"];
        return;
    }
    
    
   
    BOOL result = nil;
    
    NSString *sqlStr = [NSString stringWithFormat:@"drop table if exists %@",_tableName];
    NSLog(@"sqlstr==========%@",sqlStr);
    result = [[ViewController sharedDatabaseInstance].staffManageDB executeUpdate:sqlStr];
    
    
    
    if (result) {
        [_alertController operateController:self alertControllerWithTitle:nil message:@"删除表格成功"];
    } else {
        [_alertController operateController:self alertControllerWithTitle:nil message:@"删除表格失败"];
    }
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
