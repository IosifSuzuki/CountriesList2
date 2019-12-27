//
//  Country+CoreDataProperties.m
//  ListCountries2
//
//  Created by admin on 27.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//
//

#import "Country+CoreDataProperties.h"

@implementation Country (CoreDataProperties)

+ (NSFetchRequest<Country *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Country"];
}

@dynamic flag;
@dynamic name;
@dynamic shortName;
@dynamic section;
@dynamic detailInfo;

@end
