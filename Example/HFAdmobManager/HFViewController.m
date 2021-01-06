//
//  HFViewController.m
//  HFAdmobManager
//
//  Created by hufengiOS on 12/31/2020.
//  Copyright (c) 2020 hufengiOS. All rights reserved.
//

#import "HFViewController.h"
#import <HFAdmobManager/HFAdmobManagerHeader.h>



@interface HFViewController ()

@end

@implementation HFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [HFAdmobManager preloadAllAds];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
