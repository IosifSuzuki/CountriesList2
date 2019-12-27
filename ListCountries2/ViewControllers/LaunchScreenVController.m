//
//  LaunchScreenVController.m
//  ListCountries2
//
//  Created by admin on 25.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//

#import "LaunchScreenVController.h"

@implementation LaunchScreenVController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self prepareViewInterface];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}


#pragma mark - Private methods

- (void)prepareViewInterface {
    [self.startButton.layer setBorderWidth:1.f];
    [self.startButton.layer setCornerRadius:5.f];
    [self.startButton.layer setBorderColor: [[UIColor blackColor] CGColor]];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [backgroundImage setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [backgroundImage setContentMode: UIViewContentModeScaleToFill];
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
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
