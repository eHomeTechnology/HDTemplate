//
//  HDViewController.m
//  SNVideo
//
//  Created by Hu Dennis on 14-9-2.
//  Copyright (c) 2014年 StarNet智能家居研发部. All rights reserved.


#import "HDListViewCtr.h"
#import "HDGlobalInfo.h"

@interface HDListViewCtr ()

@end

@implementation HDListViewCtr

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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconList"] style:UIBarButtonItemStylePlain target:self action:@selector(doShowList:)];
}

- (void)doShowList:(id)sender{
    [[HDGlobalInfo instance].sideMenu presentLeftMenuViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
