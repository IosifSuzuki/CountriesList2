//
//  CountryDetail+CoreDataProperties.m
//  ListCountries2
//
//  Created by admin on 27.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//
//

#import "CountryDetail+CoreDataProperties.h"

@implementation CountryDetail (CoreDataProperties)

+ (NSFetchRequest<CountryDetail *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"CountryDetail"];
}

@dynamic capital;
@dynamic region;
@dynamic population;
@dynamic currencies;
@dynamic languages;
@dynamic area;
@dynamic country;

@end
