//
//  ViewController.m
//  StaffManageDatabase
//
//  Created by Civet on 2019/5/3.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "ViewController.h"

#import "FMDatabase.h"
#import "StaffEntity.h"
#import "AddDatabase.h"
#import "AddTable.h"
#import "AddTableData.h"
#import "DeleteTableData.h"
#import "UpdateTableData.h"
#import "SelectTableData.h"
#import "DeleteTable.h"

@interface ViewController ()

//@property (nonatomic,copy) FMDatabase *db; //FMDB对象
@property (nonatomic,assign) NSInteger markStaff; //员工标记
@property (nonatomic,strong) NSString *dbPath; //数据库地址

@end

@implementation ViewController

+ (instancetype)sharedDatabaseInstance{
    static ViewController *shareVC = nil;
    if (shareVC == nil){
        shareVC = [[ViewController alloc]init];
    }
    return shareVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *addDBbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    addDBbtn.frame = CGRectMake(150, 60, 120, 30);
    addDBbtn.backgroundColor = [UIColor grayColor];
    [addDBbtn setTitle:@"新增/打开数据库" forState:UIControlStateNormal];
    [addDBbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addDBbtn addTarget:self action:@selector(createDatabase:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addDBbtn];
    
    UIButton *addTabbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    addTabbtn.frame = CGRectMake(150, 120, 120, 30);
    addTabbtn.backgroundColor = [UIColor grayColor];
    [addTabbtn setTitle:@"新增表格" forState:UIControlStateNormal];
    [addTabbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addTabbtn addTarget:self action:@selector(createDatabaseTable:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addTabbtn];
    
    UIButton *addDatabtn = [UIButton buttonWithType:UIButtonTypeSystem];
    addDatabtn.frame = CGRectMake(150, 180, 120, 30);
    addDatabtn.backgroundColor = [UIColor grayColor];
    [addDatabtn setTitle:@"新增数据" forState:UIControlStateNormal];
    [addDatabtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addDatabtn addTarget:self action:@selector(addDataToDatabase:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addDatabtn];
    
    UIButton *deleteDatabtn = [UIButton buttonWithType:UIButtonTypeSystem];
    deleteDatabtn.frame = CGRectMake(150, 240, 120, 30);
    deleteDatabtn.backgroundColor = [UIColor grayColor];
    [deleteDatabtn setTitle:@"删除数据" forState:UIControlStateNormal];
    [deleteDatabtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [deleteDatabtn addTarget:self action:@selector(deleteData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteDatabtn];
    
    UIButton *updateDatabtn = [UIButton buttonWithType:UIButtonTypeSystem];
    updateDatabtn.frame = CGRectMake(150, 300, 120, 30);
    updateDatabtn.backgroundColor = [UIColor grayColor];
    [updateDatabtn setTitle:@"修改数据" forState:UIControlStateNormal];
    [updateDatabtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [updateDatabtn addTarget:self action:@selector(updateData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateDatabtn];
    
    UIButton *selectDatabtn = [UIButton buttonWithType:UIButtonTypeSystem];
    selectDatabtn.frame = CGRectMake(150, 360, 120, 30);
    selectDatabtn.backgroundColor = [UIColor grayColor];
    [selectDatabtn setTitle:@"查询表格内容" forState:UIControlStateNormal];
    [selectDatabtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [selectDatabtn addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectDatabtn];
    
    UIButton *dropTabbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    dropTabbtn.frame = CGRectMake(150, 420, 120, 30);
    dropTabbtn.backgroundColor = [UIColor grayColor];
    [dropTabbtn setTitle:@"删除表格" forState:UIControlStateNormal];
    [dropTabbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [dropTabbtn addTarget:self action:@selector(dropTable:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dropTabbtn];
    
}


//新建数据库
- (IBAction)createDatabase:(id)sender {
    NSLog(@"新建数据库");
    
    AddDatabase *addDB = [[AddDatabase alloc]init];
    //[self presentModalViewController:addDB animated:YES];
    [self presentViewController:addDB animated:YES completion:^{
        NSLog(@"新增/打开数据库");
    }];

}

//新建数据库表
- (IBAction)createDatabaseTable:(id)sender {
    NSLog(@"新建数据库表");
    AddTable *addTable = [[AddTable alloc]init];
//    [self presentModalViewController:addTable animated:YES];
    [self presentViewController:addTable animated:YES completion:^{
        NSLog(@"创建数据库");
    }];
}

//添加数据
- (IBAction)addDataToDatabase:(id)sender{
    NSLog(@"添加数据");
    
    AddTableData *addTableData = [[AddTableData alloc]init];
//    [self presentModalViewController:addTableData animated:YES];
    [self presentViewController:addTableData animated:YES completion:^{
        NSLog(@"添加员工数据");
    }];
    
}

//删除数据
- (IBAction)deleteData:(id)sender {
    NSLog(@"删除数据");
    
    DeleteTableData *deleteTableData = [[DeleteTableData alloc]init];
//    [self presentModalViewController:deleteTableData animated:YES];
    [self presentViewController:deleteTableData animated:YES completion:^{
        NSLog(@"删除员工数据");
    }];
    
}

//修改数据
- (IBAction)updateData:(id)sender {
    NSLog(@"修改数据");

    UpdateTableData *updateTableData = [[UpdateTableData alloc]init];
    //[self presentModalViewController:updateTableData animated:YES];
    [self presentViewController:updateTableData animated:YES completion:^{
        NSLog(@"修改员工数据");
    }];
}

//查询数据
- (IBAction)selectData:(id)sender {
    NSLog(@"查询数据");
 
    SelectTableData *selectTableData = [[SelectTableData alloc]init];
//    [self presentModalViewController:selectTableData animated:YES];
    [self presentViewController:selectTableData animated:YES completion:^{
        NSLog(@"查询数据");
    }];

}

//删除表
- (IBAction)dropTable:(id)sender {
    NSLog(@"删除表");
    DeleteTable *deleteTable = [[DeleteTable alloc]init];
//    [self presentModalViewController:deleteTable animated:YES];
    [self presentViewController:deleteTable animated:YES completion:^{
        NSLog(@"删除表格");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
