//
//  personalInformationTableViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/3.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "personalInformationTableViewController.h"
#import "nameViewController.h"
#import "personal.h"
@interface personalInformationTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic , strong)personal *model;
@end

@implementation personalInformationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = kColor_RGB(241, 238, 238);
    [self configNavigation];
    self.tableView.separatorColor = [UIColor clearColor];
    [self setBottomView];
    //不可滚动
    self.tableView.scrollEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
    [self loadPersonalModel];
}
#pragma mark ----- setBottomView
- (void)setBottomView {
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 120, SCREEN_WIDTH, 60)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.tableView addSubview:bottomView];
    
    UIButton *outBtn = [UIButton new];
    [outBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [outBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    outBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [outBtn setBackgroundImage:[UIImage imageNamed:@"提交订单"] forState:UIControlStateNormal];
    [bottomView addSubview:outBtn];
    
    [outBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(10);
        make.left.mas_equalTo((SCREEN_WIDTH - 200)/2);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    
}
#pragma mark ----- 创建导航栏
- (void)configNavigation {
    self.title = @"个人信息";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 15, 15);
    [backButton setBackgroundImage:[UIImage imageNamed:@"箭头白"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dealBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    //导航添加背景颜色
    [self.navigationController.navigationBar setBarTintColor:kColor_RGB(217, 57, 84)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void) dealBack {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 1;
        case 1:
            return 2;
        default:
            return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    //设置辅助视图
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                cell.textLabel.text = @"头像";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
               // NSString *imageStr = [NSString stringWithFormat:@"%@%@",ImageUrl ,_model.touxiang];
                /** 如果包含HTTP  or 不包含 */
                if ([_model.touxiang containsString:@"http"]) {
                    NSString *imageStr = [NSString stringWithFormat:@"%@",_model.touxiang];
                    UIImage *image = [UIImage imageNamed:imageStr];
                    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
                    imageView.frame = CGRectMake(SCREEN_WIDTH - 70, 25, 30, 30);
                    /** 圆形 */
                    imageView.layer.masksToBounds = YES;
                    imageView.layer.cornerRadius = imageView.bounds.size.width * 0.5;
                    imageView.layer.borderWidth = 2;
                    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
                    [cell.contentView addSubview:imageView];
                }else{
                    NSString *imageStr = [NSString stringWithFormat:@"%@",_model.touxiang];
                    UIImage *image = [UIImage imageNamed:imageStr];
                    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
                    imageView.frame = CGRectMake(SCREEN_WIDTH - 70, 25, 30, 30);
                    /** 圆形 */
                    imageView.layer.masksToBounds = YES;
                    imageView.layer.cornerRadius = imageView.bounds.size.width * 0.5;
                    imageView.layer.borderWidth = 2;
                    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
                    [cell.contentView addSubview:imageView];
                }
            }else if (indexPath.row == 1) {
                cell.textLabel.text = @"ID";
                cell.detailTextLabel.text = _model.uid;
                cell.detailTextLabel.textColor =  [UIColor orangeColor];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }else if (indexPath.row == 2){
                cell.textLabel.text = @"推存码";
                cell.detailTextLabel.text = _model.tuid;
                cell.detailTextLabel.textColor =  [UIColor orangeColor];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }else {
                cell.backgroundColor = [UIColor clearColor];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                cell.textLabel.text = @"昵称:";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(122, 15, 200, 30)];
                nameLabel.textColor = [UIColor grayColor];
                nameLabel.text = _model.name;
                [cell.contentView addSubview:nameLabel];
            }else {
                cell.textLabel.text = @"手机号码:";
                cell.accessoryType = UITableViewCellAccessoryNone;
                UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(122, 15, 200, 30)];
                numberLabel.textColor = [UIColor grayColor];
                numberLabel.text = _model.shouji;
                [cell.contentView addSubview:numberLabel];
            }
            break;
        case 2:
            cell.textLabel.text = @"推送通知:(开关)";
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        }
    }
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    // 添加判断，防止模拟器崩溃
                    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
                        pickerController.delegate = self;
                        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                        [self presentViewController:pickerController animated:YES completion:nil];
                    }
                }];
                UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
                    pickerController.delegate = self;
                    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    pickerController.allowsEditing = YES;
                    // 可以设置手势
                    [self presentViewController:pickerController animated:YES completion:nil];
                }];
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:photoAction];
                [alertController addAction:albumAction];
                [alertController addAction:cancleAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                nameViewController *nameVC = [[nameViewController alloc]init];
                nameVC.userID = self.userID;
                [self.navigationController pushViewController:nameVC animated:YES];
            }
            break;
    }
}

/** 获取个人信息 */
- (void)loadPersonalModel {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/userInfo/uid/%d",self.userID];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = responseObject;
        NSArray *dataArray = dataDic[@"data"];
        for (NSDictionary *tempDic in dataArray) {
            _model = [personal setPersonalDataWithDic:tempDic];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    BXHttpManager *manager = [BXHttpManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/headPic/uid/%d",self.userID];
    [manager PostImagesToServer:urlStr dicPostParams:nil imageArray:@[image] file:@[@"file"] imageName:@[@"touxiang"] Success:^(id responseObject) {
        //结束的时候关闭相机
        [picker dismissViewControllerAnimated:YES completion:nil];
    } andFailure:^(NSError *error) {
        //结束的时候关闭相机
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    
}




















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
