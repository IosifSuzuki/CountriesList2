//
//  Configuration.h
//  ListCountries2
//
//  Created by admin on 25.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

extern NSString *sectionTableName;
extern NSString *countryTableName;
extern NSString *countryDatailTableName;
extern NSString *identifierCell;

@interface Configuration : NSObject

@property (nonatomic, strong, readonly) UIColor *mainColor;
@property (nonatomic, strong, readonly) UIColor *primatyColor;
@property (nonatomic, strong, readonly) UIColor *secondaryColor;


+ (Configuration *)sharedManager;

@end

NS_ASSUME_NONNULL_END
