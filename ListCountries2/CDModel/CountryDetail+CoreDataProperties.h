//
//  CountryDetail+CoreDataProperties.h
//  ListCountries2
//
//  Created by admin on 27.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//
//

#import "CountryDetail+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CountryDetail (CoreDataProperties)

+ (NSFetchRequest<CountryDetail *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *capital;
@property (nullable, nonatomic, copy) NSString *region;
@property (nonatomic) int32_t population;
@property (nullable, nonatomic, copy) NSString *currencies;
@property (nullable, nonatomic, copy) NSString *languages;
@property (nonatomic) int32_t area;
@property (nullable, nonatomic, retain) Country *country;

@end

NS_ASSUME_NONNULL_END
