//
//  RootViewController.m
//  通讯录联系人列表(中文排序)
//
//  Created by tian on 14-4-23.
//  Copyright (c) 2014年 tian. All rights reserved.
//

#import "RootViewController.h"
#import "ChineseString.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) NSMutableArray *indexArray;
@property (nonatomic,retain) NSMutableArray *letterResultArray;
@property (nonatomic,retain) UITableView *tableView;
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    NSArray *stringsToSort=[NSArray arrayWithObjects:
                            @"￥hhh, .$",@" ￥Chin ese ",@"开源中国 ",@"www.oschina.net",
                            @"开源技术",@"社区",@"开发者",@"传播",@"wwwbaidu.com",
                            @"2013",@"100",@"中国",@"暑假作业",
                            @"键盘", @"鼠标",@"hello",@"world",
                            nil];

    
    
    self.indexArray =[[NSMutableArray alloc]initWithArray:[ChineseString IndexArray:stringsToSort]];
    self.letterResultArray = [[NSMutableArray alloc]initWithArray:[ChineseString LetterSortArray:stringsToSort]];
    //改变位置以及改变名称
    if ([self.indexArray[0] isEqualToString:@"#"]) {
        [self.indexArray addObject:@"其他"];
        [self.indexArray removeObjectAtIndex:0];
        
        [self.letterResultArray addObject:self.letterResultArray[0]];
        [self.letterResultArray removeObjectAtIndex:0];
    }
    
    NSLog(@"===$%@",self.letterResultArray);
    [self _initTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}
-(void)_initTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,320 , self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    /*返回table有多少section*/
    return self.letterResultArray.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return  self.indexArray[section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [[self.letterResultArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    /*返回table有多少Row*/
    return [self.letterResultArray[section] count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*点击Row触发事件
     
     do something...
     
     */
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
