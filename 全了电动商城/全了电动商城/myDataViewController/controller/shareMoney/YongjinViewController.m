//
//  YongjinViewController.m
//  全了电动商城
//
//  Created by Admin on 2017/5/9.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "XTPickerView.h"
#import "YongjinRecordModel.h"
#import "YongjinViewController.h"

@interface YongjinViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *cellArr;

@end

@implementation YongjinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"佣金记录";
    self.view.backgroundColor = [UIColor whiteColor];
    [QLRequest yongjinRecordSuccess:^(id response) {
        if ([response[@"code"]intValue]!=96010) {
            return ;
        }
        NSArray *arr = response[@"data"];
        for (NSDictionary* dic in arr) {
            YongjinRecordModel*model = [[YongjinRecordModel alloc]initWithDictionary:dic];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        YongjinRecordModel *model = self.cellArr[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"任务奖励：%@",model.data];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"时间：%@",model.atime];
        UILabel *lab = [[UILabel alloc]init];
        lab.frame = CGRectMake(0, 0, 70, 50);
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = [NSString stringWithFormat:@"+ %@",model.huobi];
        lab.font = [UIFont systemFontOfSize:15];
        lab.textColor = [UIColor redColor];
        cell.accessoryView = lab;

    }
    
    return cell;
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
