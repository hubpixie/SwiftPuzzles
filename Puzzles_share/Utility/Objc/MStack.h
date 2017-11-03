//
//  MStack.h
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/07/04.
//  Copyright © 2017 venus.janne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MStack : NSObject <NSFastEnumeration>

@property (nonatomic, assign, readonly) NSUInteger count;

- (id)initWithArray:(NSArray*)array;

- (void)pushObject:(id)object;
- (id)popObject;

@end
