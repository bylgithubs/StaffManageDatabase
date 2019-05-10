//
//  TableNameDropDownList.h
//  StaffManageDatabase
//
//  Created by Civet on 2019/5/8.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableNameDropdownList;

@protocol TableNameDropdownListDelegate <NSObject>

@optional

- (void)dropdownListWillShow:(TableNameDropdownList *)list; // 当下拉菜单将要显示时调用
- (void)dropdownListDidShow:(TableNameDropdownList *)list;  // 当下拉菜单已经显示时调用
- (void)dropdownListWillHidden:(TableNameDropdownList *)list;   // 当下拉菜单将要收起时调用
- (void)dropdownListDidHidden:(TableNameDropdownList *)list;    // 当下拉菜单已经收起时调用

- (void)dropdownList:(TableNameDropdownList *)list selectedCellNumber:(NSInteger)number; // 当选择某个选项时调用

@end

@interface TableNameDropdownList : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIButton *dropdownListBtn; //下拉列表按钮；
@property (nonatomic,assign) id <TableNameDropdownListDelegate>delegate;

- (void) setDropdownList:(NSArray *)listArr rowHeight:(CGFloat)rowHeight;   //设置下拉列表属性

- (void) showDropdownList;  //显示下拉列表；
- (void) hiddenDropdownList;    //隐藏下拉列表；

//+ (instancetype) sharedTableNamesInstance;
@property (nonatomic,strong) NSMutableArray *tableNames;    //所有表格名称

@end
