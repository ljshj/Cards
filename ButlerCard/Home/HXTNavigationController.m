//
//  HXTNavigationController.m
//  ButlerCard
//
//  Created by johnny tang on 3/19/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTNavigationController.h"

@interface HXTNavigationController ()

@end

@implementation HXTNavigationController

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
    self.navigationBar.backgroundColor = [UIColor redColor];
    NSLog(@"self.tabBarItem.tag = %ld", (long)self.tabBarItem.tag );
    switch (self.tabBarItem.tag) {
        case 0:{ //首页
            [self.tabBarItem  setSelectedImage:[UIImage imageNamed:@"tabbar_home_s"]];
        }
            break;
        case 1:{ //收藏
            [self.tabBarItem  setSelectedImage:[UIImage imageNamed:@"tabbar_collection_s"]];
        }
            break;
        case 2:{ //购物车
            [self.tabBarItem  setSelectedImage:[UIImage imageNamed:@"tabbar_trolley_s"]];
        }
            break;
        case 3:{ //我的管家
            [self.tabBarItem  setSelectedImage:[UIImage imageNamed:@"tabbar_myButler_s"]];
        }
            break;
            
        default:
            break;
    }
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
