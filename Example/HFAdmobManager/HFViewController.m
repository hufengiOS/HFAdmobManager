//
//  HFViewController.m
//  HFAdmobManager
//
//  Created by hufengiOS on 12/31/2020.
//  Copyright (c) 2020 hufengiOS. All rights reserved.
//

#import "HFViewController.h"
#import <HFAdmobManager/HFAdmobManagerHeader.h>
#import "SCRequest.h"



@interface HFViewController ()

@property (nonatomic, strong) UIButton *showAdsBtn;

@end

@implementation HFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [HFAdmobManager shareInstance].loadNibHandler = ^NSArray * _Nonnull{
        return [[NSBundle mainBundle] loadNibNamed:@"VSAdNavTemplateView" owner:nil options:nil];
    };
    [[HFAdmobManager shareInstance] openDebugModeWithHandler:^BOOL{
        return YES;
    }];
    [self requestConfigInfo];
    
    [self.view addSubview:self.showAdsBtn];
    [self.showAdsBtn addTarget:self action:@selector(showAdAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAdAction {
    [HFAdmobManager showAdsWithPlaceType:VSAdShowPlaceTypeFullStart controller:self];
}

- (void)requestConfigInfo {
    [SCRequest requestGlobalConfigWithCallBackHandler:^(NSDictionary * _Nullable dataModel, NSError * _Nullable error) {
        if ([dataModel isKindOfClass:[NSDictionary class]] && [dataModel.allKeys containsObject:@"data"]) {
            
            [[VSGlobalConfigManager shareInstance] configWithDic:dataModel[@"data"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameVSGlobalConfigManagerLoadSuccess object:nil];
        } else {
           [[VSGlobalConfigManager shareInstance] configModel];
        }
        
        [HFAdmobManager preloadAllAds];
        
    }];
}

//            NSString *filePath = [[NSBundle mainBundle] pathForResource:kGlobalConfigFileName ofType:@"txt"];
//            NSString *configStr = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//            NSDictionary *localDic = [VSAdUnit objectWithJsonString:configStr];

- (UIButton *)showAdsBtn {
    if (!_showAdsBtn) {
        _showAdsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showAdsBtn setTitle:@"展示广告" forState:UIControlStateNormal];
        _showAdsBtn.backgroundColor = UIColor.grayColor;
        _showAdsBtn.frame = CGRectMake(100, 100, 80, 40);
    }
    return _showAdsBtn;
}
@end

