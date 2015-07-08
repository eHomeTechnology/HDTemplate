//
//  SNMenuViewCtr.m
//  SNVideo
//
//  Created by Hu Dennis on 14-9-2.
//  Copyright (c) 2014年 DennisHu. All rights reserved.
//

#import "HDMenuViewCtr.h"
#import "HDWorksViewCtr.h"
#import "HDMainViewCtr.h"
#import "HDScheduleViewCtr.h"
#import "HDPhotoViewCtr.h"
#import "HDMoreViewCtr.h"
#import "HDProfileViewCtr.h"
#import "HDNavigationController.h"

@interface HDMenuViewCtr ()<RESideMenuDelegate>{
    IBOutlet UIView         *v_head;
    IBOutlet UIButton       *btn_head;
    IBOutlet UILabel        *lb_name;
}

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HDMenuViewCtr


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IS_4INCH_SCREEN) {
        v_head.frame = CGRectMake(30, 80, v_head.frame.size.width, v_head.frame.size.height);
    }else{
        v_head.frame = CGRectMake(30, 30, v_head.frame.size.width, v_head.frame.size.height);
    }
    
    [self.view addSubview:v_head];
    self.sideMenuViewController.delegate    = self;
    btn_head.layer.cornerRadius             = btn_head.frame.size.width/2;
    btn_head.layer.masksToBounds            = YES;
    btn_head.layer.borderWidth              = 2.0f;
    btn_head.layer.borderColor              = [UIColor whiteColor].CGColor;
    btn_head.layer.shadowColor              = [UIColor blackColor].CGColor;
    btn_head.layer.shadowOffset             = CGSizeMake(0, 3);
    btn_head.layer.shadowRadius             = 5.0f;
    btn_head.layer.shadowOpacity            = 0.5f;
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(30, (self.view.frame.size.height - 54 * 5 - 123) / 2.0f + 123, self.view.frame.size.width/2, 54 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate          = self;
        tableView.dataSource        = self;
        tableView.opaque            = NO;
        tableView.backgroundColor   = [UIColor clearColor];
        tableView.backgroundView    = nil;
        tableView.separatorStyle    = UITableViewCellSeparatorStyleNone;
        tableView.bounces           = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
}
- (void)viewDidAppear:(BOOL)animated{

    self.tableView.frame = CGRectMake(30, (self.view.frame.size.height - 54 * 5 - 123) / 2.0f + 123, self.view.frame.size.width/2, 54 * 5);
}
- (IBAction)doShowProfile:(id)sender{
    [self.sideMenuViewController hideMenuViewController];
    HDProfileViewCtr *ctr       = [HDProfileViewCtr new];
    ctr.navigationItem.title    = @"个人信息";
    HDNavigationController *nav = [[HDNavigationController alloc] initWithRootViewController:ctr];
    [self.sideMenuViewController setContentViewController:nav animated:YES];
}

- (void)doGuideViewCancel{

}
#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    switch (indexPath.row) {
        case 0:{
            HDMainViewCtr *ctr          = [HDMainViewCtr new];
            ctr.navigationItem.title    = @"主页";
            HDNavigationController *nav = [[HDNavigationController alloc] initWithRootViewController:ctr];
            [self.sideMenuViewController setContentViewController:nav animated:YES];
            break;
        }
        case 1:{
            HDWorksViewCtr *ctr         = [HDWorksViewCtr new];
            ctr.navigationItem.title    = @"作品";
            HDNavigationController *nav = [[HDNavigationController alloc] initWithRootViewController:ctr];
            [self.sideMenuViewController setContentViewController:nav animated:YES];
            break;
        }
        case 2:{
            HDScheduleViewCtr *ctr      = [HDScheduleViewCtr new];
            ctr.navigationItem.title    = @"课程表";
            HDNavigationController *nav = [[HDNavigationController alloc] initWithRootViewController:ctr];
            [self.sideMenuViewController setContentViewController:nav animated:YES];
            break;
        }
        case 3:{
            HDPhotoViewCtr *ctr         = [HDPhotoViewCtr new];
            ctr.navigationItem.title    = @"照片管理";
            HDNavigationController *nav = [[HDNavigationController alloc] initWithRootViewController:ctr];
            [self.sideMenuViewController setContentViewController:nav animated:YES];
            break;
        }
        case 4:{
            HDMoreViewCtr *ctr          = [HDMoreViewCtr new];
            ctr.navigationItem.title    = @"更多";
            HDNavigationController *nav = [[HDNavigationController alloc] initWithRootViewController:ctr];
            [self.sideMenuViewController setContentViewController:nav animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor                = [UIColor clearColor];
        //cell.textLabel.font                 = [UIFont fontWithName:@"HelveticaNeue" size:15];
        //cell.textLabel.textColor            = [UIColor whiteColor];
        //cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView         = [[UIView alloc] init];
        UIImageView *imv_line               = [[UIImageView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-1, cell.frame.size.width, 0.5f)];
        imv_line.backgroundColor            = [UIColor whiteColor];
        imv_line.alpha                      = 0.5f;
        [cell.contentView addSubview:imv_line];
    }
    NSArray *titles         = @[@"    主页", @"    学生作品", @"    课程表", @"    照片管理", @"    更多"];
    NSArray *images         = @[@"icon_main", @"icon_works", @"icon_schedule", @"icon_image", @"icon_more"];
    cell.textLabel.text     = titles[indexPath.row];
    cell.imageView.image    = [UIImage imageNamed:images[indexPath.row]];
    return cell;
}

#pragma mark - RESideMenuDelegate
- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController{
    //NSString *sPath = [SNGlobalInfo instance].userInfo.sHeadPath;
//    if (sPath.length > 0) {
//        [btn_head setImage:[UIImage imageWithContentsOfFile:sPath] forState:UIControlStateNormal];
//    }
//    lb_name.text = [SNGlobalInfo instance].userInfo.sUserName;
}

@end
