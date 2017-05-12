//
//  InviteRecordViewController.m
//  全了电动商城
//
//  Created by Admin on 2017/5/9.
//  Copyright © 2017年 亮点网络. All rights reserved.
//
#import "InviteRecordModel.h"

#import "InviteRecordViewController.h"

@interface InviteRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *cellArr;
@end

@implementation InviteRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请记录";
    self.view.backgroundColor = [UIColor whiteColor];
    [QLRequest inviteRecordSuccess:^(id response) {
        if ([response[@"code"]intValue]!=96000) {
            return ;
        }
        NSArray *arr = response[@"data"];
        for (NSDictionary*dic  in arr) {
            InviteRecordModel*model = [[InviteRecordModel alloc]initWithDictionary:dic];
            [self.cellArr addObject:model];
        }
        [self.view addSubview:self.tableview];
    } error:^(id response) {
        
    }];
   
}

#pragma mark - tableviewDelegate
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        
    }
    return _tableview;
}
-(NSMutableArray*)cellArr{
    if(!_cellArr){
        _cellArr = [NSMutableArray array];
    }
    return _cellArr;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableCell = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCell];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:tableCell];
    }
    if (self.cellArr.count>0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        InviteRecordModel *model = self.cellArr[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld 级好友:%@",(long)model.level,model.name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"时间：%@",model.atime];
        UILabel *lab = [[UILabel alloc]init];
        lab.frame = CGRectMake(0, 0, 70, 50);
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = model.result;
        lab.font = [UIFont systemFontOfSize:14];
        if ([model.result isEqualToString:@"有效推广"]) {
            lab.textColor = [UIColor greenColor];
        }else{
            lab.textColor = [UIColor redColor];
        }
        cell.accessoryView = lab;
        
    }
    
    return cell;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
