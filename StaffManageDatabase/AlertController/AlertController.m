//
//  AlertController.m
//  StaffManageDatabase
//
//  Created by Civet on 2019/5/9.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "AlertController.h"

@implementation AlertController

//创建单例对象
+(instancetype) sharedAlertController{
    static AlertController *sharedAlertVC = nil;
    if (sharedAlertVC == nil){
        sharedAlertVC = [[AlertController alloc]init];
    }
    return sharedAlertVC;
}

//警告控制器，包括主题，消息
-(void)operateController:(id)operateController alertControllerWithTitle:(NSString *)title
               message:(NSString *)message{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:title message:message  preferredStyle:UIAlertControllerStyleAlert];
    
    [operateController presentViewController:alertCon animated:YES completion:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(creatAlert:) userInfo:alertCon repeats:NO];
    
}

//警告控制器，包括主题，消息，action主题
-(void)operateController:(id)operateController alertControllerWithTitle:(NSString *)title
                 message:(NSString *)message
         actionWithTitle:(NSString *)actionTitle{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:title message:message  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click");
    }];
    
    [alertCon addAction:action];
    
    [operateController presentViewController:alertCon animated:YES completion:nil];

}

#pragma mark - 让alert自动消失
- (void)creatAlert:(NSTimer *)timer{
    
    UIAlertController *alert = [timer userInfo];
    
    [alert dismissViewControllerAnimated:YES completion:nil];
    
    alert = nil;
    
}

@end
