//
//  Section+CoreDataProperties.m
//  ListCountries2
//
//  Created by admin on 27.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//
//

#import "Section+CoreDataProperties.h"

@implementation Section (CoreDataProperties)

+ (NSFetchRequest<Section *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Section"];
}

@dynamic name;
@dynamic countries;

@end
