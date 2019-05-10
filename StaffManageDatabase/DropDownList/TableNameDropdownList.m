//
//  TableNameDropDownList.m
//  StaffManageDatabase
//
//  Created by Civet on 2019/5/8.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "TableNameDropdownList.h"

#import "ViewController.h"
@interface TableNameDropdownList()

@property (nonatomic,strong) UIImageView *arrowMark; //下拉列表图标
@property (nonatomic,strong) UIView *listView;  //下拉列表背景
@property (nonatomic,strong) UITableView *tableView;//下拉列表表格
@property (nonatomic,strong) NSArray *listArr;  //下拉列表数组
@property (nonatomic,assign) CGFloat rowHeight; //下拉列表行高

@property (nonatomic,strong) NSString *tableName;   //选中表格名称

@end


@implementation TableNameDropdownList

//初始化DropdownList
- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createDropdownListBtnWithFrame:frame];
    }
 
    if (![[ViewController sharedDatabaseInstance].staffManageDB isEqual:@""]){
        FMResultSet *resultSet;
        
        NSString *sqlStr = [NSString stringWithFormat:
                            @"select * from SQLITE_MASTER where type = 'table' order by name asc"];
        resultSet = [[ViewController sharedDatabaseInstance].staffManageDB executeQuery:sqlStr];
        _tableNames = [NSMutableArray array];
        //遍历结果集合
        while ([resultSet next]) {
            
            NSString *tableName = [resultSet stringForColumnIndex:1];
            NSLog(@"表名:%@",tableName);
            //[[TableNamedropDownList sharedTableNamesInstance].tableNames addObject:tableName];
            [_tableNames addObject:tableName];
        }
    }
    
    return self;
}

//添加Dropdown样式
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    [self createDropdownListBtnWithFrame:frame];
}

//实现DropdownList样式，由一个button，尖头图标组成
- (void) createDropdownListBtnWithFrame:(CGRect)frame{
    
    [_dropdownListBtn removeFromSuperview];
    //自定义按钮样式
    _dropdownListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dropdownListBtn setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [_dropdownListBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_dropdownListBtn setTitle:@"请选择表格名称" forState:UIControlStateNormal];
    [_dropdownListBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_dropdownListBtn addTarget:self action:@selector(clickDropdownListBtn:) forControlEvents:UIControlEventTouchUpInside];
    _dropdownListBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _dropdownListBtn.titleLabel.font    = [UIFont systemFontOfSize:14.f];
    _dropdownListBtn.titleEdgeInsets    = UIEdgeInsetsMake(0, 15, 0, 0);
    _dropdownListBtn.selected           = NO;
    _dropdownListBtn.backgroundColor    = [UIColor whiteColor];
    _dropdownListBtn.layer.borderColor  = [UIColor blackColor].CGColor;
    _dropdownListBtn.layer.borderWidth  = 1;
    
    [self addSubview:_dropdownListBtn];
    
    
    // 旋转尖头
    _arrowMark = [[UIImageView alloc] initWithFrame:CGRectMake(_dropdownListBtn.frame.size.width - 15, 0, 9, 9)];
    _arrowMark.center = CGPointMake(_arrowMark.center.x, _dropdownListBtn.frame.size.height/2);
    _arrowMark.image  = [UIImage imageNamed:@"dropdownMenu_cornerIcon.png"];
    [_dropdownListBtn addSubview:_arrowMark];
    
}

//下拉DropdownList样式，里面包含tableview
- (void) setDropdownList:(NSArray *)listArr rowHeight:(CGFloat)rowHeight{
    if (self == nil) {
        return;
    }
    
    _listArr  = [NSArray arrayWithArray:listArr];
    _rowHeight = rowHeight;
    
    
    // 下拉列表背景View
    _listView = [[UIView alloc] init];
    _listView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
    _listView.clipsToBounds       = YES;
    _listView.layer.masksToBounds = NO;
    _listView.layer.borderColor   = [UIColor lightTextColor].CGColor;
    _listView.layer.borderWidth   = 0.5f;
    
    
    // 下拉列表TableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(
        0, 0,self.frame.size.width, _listView.frame.size.height)];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.bounces         = NO;
    [_listView addSubview:_tableView];}

//DropdownList的显示与隐藏
- (void)clickDropdownListBtn:(UIButton *)button{
    
    [self.superview addSubview:_listView]; // 将下拉视图添加到控件的俯视图上
    
    if(button.selected == NO) {
        [self showDropdownList];
    }
    else {
        [self hiddenDropdownList];
    }
}

//显示Dropdown内容
- (void)showDropdownList{   // 显示下拉列表
    
    [_listView.superview bringSubviewToFront:_listView]; // 将下拉列表置于最上层
    
    
    
    if ([self.delegate respondsToSelector:@selector(dropdownListWillShow:)]) {
        [self.delegate dropdownListWillShow:self]; // 将要显示回调代理
    }
    
    
    [UIView animateWithDuration:0.25f animations:^{
        
        self.arrowMark.transform = CGAffineTransformMakeRotation(M_PI);
        self.listView.frame  = CGRectMake(self.listView.frame.origin.x, self.listView.frame.origin.y,
                                          self.listView.frame.size.width, self.rowHeight *self.listArr.count);
        
        self.tableView.frame = CGRectMake(0, 0, self.listView.frame.size.width, self.listView.frame.size.height);
        self.tableView.layer.borderWidth = 1;
        
    }completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(dropdownListDidShow:)]) {
            [self.delegate dropdownListDidShow:self]; // 已经显示回调代理
        }
    }];
    
    
    
    _dropdownListBtn.selected = YES;
}

//隐藏Dropdown内容
- (void)hiddenDropdownList{  // 隐藏下拉列表
    
    
    if ([self.delegate respondsToSelector:@selector(dropdownListWillHidden:)]) {
        [self.delegate dropdownListWillHidden:self]; // 将要隐藏回调代理
    }
    
    
    [UIView animateWithDuration:0.25f animations:^{
        
        self.arrowMark.transform = CGAffineTransformIdentity;
        self.listView.frame  = CGRectMake(self.listView.frame.origin.x, self.listView.frame.origin.y, self.listView.frame.size.width, 0);
        self.tableView.frame = CGRectMake(0, 0, self.listView.frame.size.width, self.listView.frame.size.height);
        
    }completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(dropdownListDidHidden:)]) {
            [self.delegate dropdownListDidHidden:self]; // 已经隐藏回调代理
        }
    }];
    
    
    
    _dropdownListBtn.selected = NO;
}

#pragma mark - UITableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_listArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //UILabel *celLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
    if (cell == nil) {
        //---------------------------下拉选项样式，可在此处自定义-------------------------
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font          = [UIFont systemFontOfSize:11.f];
        cell.textLabel.textColor     = [UIColor blackColor];  
        cell.selectionStyle          = UITableViewCellSelectionStyleNone;
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, _rowHeight -0.5, cell.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor blackColor];
        [cell addSubview:line];
        //---------------------------------------------------------------------------
    }

    cell.textLabel.text =[_listArr objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [_dropdownListBtn setTitle:cell.textLabel.text forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(dropdownList:selectedCellNumber:)]) {
        [self.delegate dropdownList:self selectedCellNumber:indexPath.row]; // 回调代理
    }
    
    [self hiddenDropdownList];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
