//
//  ViewController.m
//  XLX2
//
//  Created by bean on 15/10/21.
//  Copyright (c) 2015年 com.xile. All rights reserved.
//

#import "ViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>


#import "RootViewController.h"

@interface ViewController ()<TencentSessionDelegate>
{
    TencentOAuth * tencent;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
#warning 此处修改APPID之后还要在Info-->URLType中进行修改
    tencent = [[TencentOAuth alloc]initWithAppId:@"222222" andDelegate:self];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = [UIColor blackColor];
    btn.frame = CGRectMake(100, 100, 110, 100);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
//    other linker flags  要设置-fno-objc-arc
    //注意依赖库的导入
}


-(void)click
{
    
    //获取用户的哪些信息！！！！具体跳进去看  
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_IDOL,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_PIC_T,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_DEL_IDOL,
                            kOPEN_PERMISSION_DEL_T,
                            kOPEN_PERMISSION_GET_FANSLIST,
                            kOPEN_PERMISSION_GET_IDOLLIST,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_GET_REPOST_LIST,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                            kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                            nil];
    
    
    
    
    [tencent authorize:permissions inSafari:NO];
}


-(void)tencentDidLogin
{
    if (tencent.accessToken && [tencent.accessToken length]!=0) {
#pragma mark 跳转页面
        RootViewController * root = [[RootViewController alloc]init];
        [self presentViewController:root animated:NO completion:nil];
        
        [tencent getUserInfo];
    }
    else
    {
        NSLog(@"没有获取到token");
    }
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled) {
        NSLog(@"用户取消登陆");
    }
    else
    {
        NSLog(@"登录失败");
    }
}

-(void)tencentDidNotNetWork
{
    NSLog(@"无网络连接，请设置网络");
}


-(void)getUserInfoResponse:(APIResponse *)response
{
#pragma mark 获取用户的信息
    
    NSLog(@"respons:%@",response.jsonResponse);
   
#pragma mark 转码！！！！！
   NSString * str = [response.jsonResponse[@"gender"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    NSString * provincestr = [response.jsonResponse[@"province"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",provincestr);
    NSString * nicknamestr = [response.jsonResponse[@"nickname"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",nicknamestr);
    
    
}

-(void)tencentDidLogout
{
    NSLog(@"退出");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
