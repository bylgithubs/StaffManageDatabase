//
//  ViewController.h
//  StaffManageDatabase
//
//  Created by Civet on 2019/5/3.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FMDatabase.h"

@interface ViewController : UIViewController

+ (instancetype) sharedDatabaseInstance;
@property (nonatomic,strong) FMDatabase *staffManageDB; //FMDB对象

@end

