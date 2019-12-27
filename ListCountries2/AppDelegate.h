//
//  AppDelegate.h
//  ListCountries2
//
//  Created by admin on 25.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

