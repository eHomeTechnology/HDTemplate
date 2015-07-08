//
//  HDBackViewCtr.m
//  HDStudio
//
//  Created by Hu Dennis on 14/12/13.
//  Copyright (c) 2014年 Hu Dennis. All rights reserved.
//

#import "HDBackViewCtr.h"

@interface HDBackViewCtr ()

@end

@implementation HDBackViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconGoBack"] style:UIBarButtonItemStylePlain target:self action:@selector(doGoBack:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doGoBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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