//
//  AlertController.h
//  StaffManageDatabase
//
//  Created by Civet on 2019/5/9.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class AlertController;

@interface AlertController : UIViewController

+(instancetype) sharedAlertController;  //类方法，创建单例对象

//警告控制器
-(void)operateController:(id)operateController alertControllerWithTitle:(NSString *)title message:(NSString *)message;

//警告控制器
-(void)operateController:(id)operateController alertControllerWithTitle:(NSString *)title message:(NSString *)message actionWithTitle:(NSString *)actionTitle;

@end
