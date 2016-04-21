//
//  ViewController.m
//  ZXTableViewDelMore
//
//  Created by macmini on 16/4/21.
//  Copyright © 2016年 macmini. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewVC;
@property (nonatomic, strong) NSMutableArray *allDataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllViews];
    [self loadAllData];
}
- (void)addAllViews
{
#warning iOS8 - 分割线样式
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    _tableViewVC.separatorEffect = vibrancyEffect;
    // 注册
    [_tableViewVC registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
}
- (void)loadAllData
{
    self.allDataArray =[[NSMutableArray alloc] initWithObjects:@"王菲",@"周迅",@"李冰冰",@"白冰",@"紫薇",@"马苏",@"刘诗诗",@"赵薇",@"angelbaby",@"熊黛林",nil];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allDataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = _allDataArray[indexPath.row];
    return cell;
}
#pragma mark 设置可以进行编辑

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark 设置编辑的样式

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark 设置处理编辑情况

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 1. 更新数据
        [_allDataArray removeObjectAtIndex:indexPath.row];
        // 2. 更新UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


#pragma mark 设置可以移动

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath

{
    return YES;
}

#pragma mark 处理移动的情况

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath

{
    // 1. 更新数据
    NSString *title = _allDataArray[sourceIndexPath.row];
    [_allDataArray removeObject:title];
    [_allDataArray insertObject:title atIndex:destinationIndexPath.row];
    // 2. 更新UI
    [tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

#pragma mark 在滑动手势删除某一行的时候，显示出更多的按钮

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath

{
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"点击了删除");
        // 1. 更新数据
        [_allDataArray removeObjectAtIndex:indexPath.row];
        // 2. 更新UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    
//        // 删除一个置顶按钮
//    
//        UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//
//            NSLog(@"点击了置顶");
//            // 1. 更新数据
//            [_allDataArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
//            // 2. 更新UI
//            NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
//            [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
//        }];
//    
//        topRowAction.backgroundColor = [UIColor blueColor];
    
    // 添加一个更多按钮
    
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了更多");
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
    }];
    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    // 将设置好的按钮放到数组中返回
//     return @[deleteRowAction, topRowAction, moreRowAction];
    return @[deleteRowAction, moreRowAction];

}



#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}







@end
