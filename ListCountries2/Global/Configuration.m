//
//  Configuration.m
//  ListCountries2
//
//  Created by admin on 25.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//

#import "Configuration.h"

NSString *sectionTableName = @"Section";
NSString *countryTableName = @"Country";
NSString *identifierCell = @"Cell";
NSString *countryDatailTableName = @"CountryDetail";

@implementation Configuration

- (UIColor *)mainColor {
    return RGBA(44, 150, 253, 1);
}

- (UIColor *)primatyColor {
    return RGBA(45, 183, 255, 1);
}

- (UIColor *)secondaryColor {
    return [UIColor whiteColor];
}

+ (Configuration *)sharedManager {
    static Configuration *configuration = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configuration = [[Configuration alloc] init];
    });
    return configuration;
}

@end
