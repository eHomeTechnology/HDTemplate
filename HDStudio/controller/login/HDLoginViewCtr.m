//
//  HDLoginViewCtr.m
//  HDStudio
//
//  Created by Hu Dennis on 14/12/12.
//  Copyright (c) 2014年 Hu Dennis. All rights reserved.
//

#import "HDLoginViewCtr.h"
#import "HDMainViewCtr.h"
#import "HDMenuViewCtr.h"
#import "HDNavigationController.h"
#import "HDGlobalInfo.h"
#import "HDForgetPwdViewCtr.h"
#import "HDDBManager.h"
#import "HDRegisterViewCtr.h"

@interface HDLoginViewCtr (){
    IBOutlet UIImageView    *imv_head;
    IBOutlet UITextField    *tf_account;
    IBOutlet UITextField    *tf_pwd;
    IBOutlet UISwitch       *sw_rememberPwd;
    IBOutlet UISwitch       *sw_autoLogin;
    IBOutlet UIImageView    *imv_back;
    HDUserInfo              *userInfo;
}

@end

@implementation HDLoginViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readUserInfo];
    
}

- (void)readUserInfo{
    //[HDDBManager createUserTable];
    userInfo = [HDDBManager selectLatestUser];
    if (userInfo.isAutoLogin) {
        userInfo.isRememberPwd = YES;
    }
    if (!userInfo.isRememberPwd) {
        userInfo.isAutoLogin = NO;
    }
}
- (void)adjustUI{
    sw_rememberPwd.tintColor        = [UIColor whiteColor];
    sw_rememberPwd.onTintColor      = [UIColor orangeColor];
    sw_autoLogin.tintColor          = [UIColor whiteColor];
    sw_autoLogin.onTintColor        = [UIColor orangeColor];
    
    imv_head.layer.cornerRadius     = imv_head.bounds.size.width/2;
    imv_head.layer.masksToBounds    = YES;
    imv_head.layer.borderWidth      = 1.0f;
    imv_head.layer.borderColor      = [UIColor whiteColor].CGColor;
    if (userInfo.img_head) {
        imv_head.image              = userInfo.img_head;
    }
    tf_account.text                 = userInfo.sPhone;
    sw_rememberPwd.on               = userInfo.isRememberPwd;
    sw_autoLogin.on                 = userInfo.isAutoLogin;
    if (userInfo.isRememberPwd) {
        tf_pwd.text                 = userInfo.sPwd;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidAppear:(BOOL)animated{
    [self adjustUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)doForgetPwd:(id)sender{
    [self.navigationController pushViewController:[HDForgetPwdViewCtr new] animated:YES];
}
- (IBAction)doRegister:(id)sender{

    [self.navigationController pushViewController:[HDRegisterViewCtr new] animated:YES];
}

- (IBAction)doSwitchValueChanged:(id)sender{
    if ([sender isEqual:sw_autoLogin]) {
        userInfo.isAutoLogin        = sw_autoLogin.on;
        if (sw_autoLogin.on) {
            sw_rememberPwd.on       = YES;
            userInfo.isRememberPwd  = YES;
        }
    }
    if ([sender isEqual:sw_rememberPwd]) {
        userInfo.isRememberPwd = sw_rememberPwd.on;
        if (!sw_rememberPwd.on) {
            sw_autoLogin.on         = NO;
            userInfo.isAutoLogin    = NO;
        }
    }
    [HDDBManager saveOrUpdataUser:userInfo];
}
- (IBAction)doLogin:(id)sender{
    BOOL isLoginSuc = [self isLoginSuccess];
    if (isLoginSuc) {
        HDMainViewCtr *ctr                      = [[HDMainViewCtr alloc] init];
        HDNavigationController *nav             = [[HDNavigationController alloc] initWithRootViewController:ctr];
        HDMenuViewCtr *leftMenuctr              = [[HDMenuViewCtr alloc] init];
        RESideMenu *sideMenuCtr                 = [[RESideMenu alloc] initWithContentViewController:nav
                                                                             leftMenuViewController:leftMenuctr
                                                                            rightMenuViewController:nil];
        sideMenuCtr.backgroundImage             = [UIImage imageNamed:@"back.png"];
        sideMenuCtr.menuPreferredStatusBarStyle = 1;
        sideMenuCtr.contentViewShadowColor      = [UIColor blackColor];
        sideMenuCtr.contentViewShadowOffset     = CGSizeMake(0, 0);
        sideMenuCtr.contentViewShadowOpacity    = 0.6;
        sideMenuCtr.contentViewShadowRadius     = 12;
        sideMenuCtr.contentViewShadowEnabled    = YES;
        [HDGlobalInfo instance].sideMenu        = sideMenuCtr;
        [self presentViewController:sideMenuCtr animated:YES completion:nil];
    }
}
- (BOOL)isLoginSuccess{
    if (![HDUtility isValidateMobile:tf_account.text]) {
        [HDUtility say:@"请输入正确的手机号码！"];
        return NO;
    }
    if (![HDUtility isValidatePassword:tf_pwd.text]) {
        [HDUtility say:FORMAT(@"您的密码有误！")];
        return NO;
    }
    HDUserInfo *user    = [HDUserInfo new];
    user.sPhone         = tf_account.text;
    user.sPwd           = tf_pwd.text;
    user.isRememberPwd  = sw_rememberPwd.on;
    user.isAutoLogin    = sw_autoLogin.on;
    [HDDBManager saveOrUpdataUser:user];
    return YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch      = [touches anyObject];
    UIView  *v_touch    = [touch view];
    if ([v_touch isEqual:imv_back]) {
        [tf_pwd resignFirstResponder];
        [tf_account resignFirstResponder];
    }
}
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [tf_account resignFirstResponder];
    [tf_pwd resignFirstResponder];
    return YES;
}

@end
