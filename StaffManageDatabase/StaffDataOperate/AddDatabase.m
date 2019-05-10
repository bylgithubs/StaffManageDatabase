//
//  AddDatabase.m
//  StaffManageDatabase
//
//  Created by Civet on 2019/5/6.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "AddDatabase.h"
#import "ViewController.h"
#import "FMDatabase.h"
#import "AlertController.h"
@interface AddDatabase ()

@property (nonatomic,strong) UITextField *tfDBName; //数据库名称
@property (nonatomic,strong) UITextField *tfDBAddress;  //数据库地址

@end

@implementation AddDatabase

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *dbName = [[UILabel alloc] initWithFrame:CGRectMake(55, 80, 100, 30)];
   // dbName.backgroundColor = [UIColor grayColor];
    [dbName setText:@"数据库名称:"];
    [dbName setTextColor:[UIColor blueColor]];
    dbName.layer.borderWidth = 0;
    dbName.layer.borderColor = [UIColor blackColor].CGColor;
    //self.databaseName = @"1111111111111";
    //NSLog(@"adddatabase=================");
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dbName];
    
    _tfDBName = [[UITextField alloc]initWithFrame:CGRectMake(160, 80, 150, 30)];
    _tfDBName.placeholder = @"格式：XXX.sqlite";
    _tfDBName.layer.borderWidth = 1;
    _tfDBName.layer.borderColor = [UIColor blackColor].CGColor;
    [_tfDBName setText:@"test1.sqlite"];
    [_tfDBName setTextColor:[UIColor blueColor]];
    [self.view addSubview: _tfDBName];
    
    UILabel *dbAddress = [[UILabel alloc] initWithFrame:CGRectMake(55, 120, 100, 30)];
    // dbName.backgroundColor = [UIColor grayColor];
    [dbAddress setText:@"数据库地址:"];
    [dbAddress setTextColor:[UIColor blueColor]];
    dbAddress.layer.borderWidth = 0;
    dbAddress.layer.borderColor = [UIColor blackColor].CGColor;
    
    //self.databaseAdress = @"1111111111111";
    //NSLog(@"adddatabase=================");
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dbAddress];
    
    _tfDBAddress = [[UITextField alloc]initWithFrame:CGRectMake(160, 120, 150, 30)];
    _tfDBAddress.placeholder = @"格式:/Users/civet/XXX";
    [_tfDBAddress setText:@"/Users/civet/F3235807/datum_free/"];
    _tfDBAddress.layer.borderWidth = 1;
    _tfDBAddress.layer.borderColor = [UIColor blackColor].CGColor;
    [_tfDBAddress setTextColor:[UIColor blueColor]];
    [self.view addSubview: _tfDBAddress];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 160, 120, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"新增/打开数据库" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    [btn addTarget:self action:@selector(addDatabase) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeSystem];
    btnBack.frame = CGRectMake(230, 160, 80, 30);
    btnBack.backgroundColor = [UIColor redColor];
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnBack.layer.borderWidth = 1;
    btnBack.layer.borderColor = [UIColor blackColor].CGColor;
    [btnBack addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];}

//触发新增数据库操作
- (void) addDatabase{
    //判断数据库名称和地址是否为空
    if ([_tfDBName.text isEqualToString:@""]  || [_tfDBAddress.text isEqualToString:@""]){
        
        AlertController *alertController = [AlertController sharedAlertController];
        [alertController operateController:self alertControllerWithTitle:@"注意" message:@"数据库名称/地址不能为空，请重新输入……" actionWithTitle:@"OK"];
        
        return;
    }
  
        NSString *databaseName = [_tfDBAddress.text stringByAppendingString:_tfDBName.text];
    
        [ViewController sharedDatabaseInstance].staffManageDB = [FMDatabase databaseWithPath:databaseName];
    
    if ([[ViewController sharedDatabaseInstance].staffManageDB open]){
        
        AlertController *alertController = [AlertController sharedAlertController];
        [alertController operateController:self alertControllerWithTitle:@"" message:@"新建/打开数据库成功"];
        
    }else{
        
        AlertController *alertController = [AlertController sharedAlertController];
        [alertController operateController:self alertControllerWithTitle:@"" message:@"新建/打开数据库失败"];

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
