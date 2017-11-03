//
//  MStack.m
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/07/04.
//  Copyright © 2017 venus.janne. All rights reserved.
//

#import "MStack.h"

@interface MStack ()
@property (nonatomic, strong) NSMutableArray *objects;
@end

@implementation MStack

//@synthesize objects = _objects;

#pragma mark -

- (id)init {
    if ((self = [self initWithArray:nil])) {
    }
    return self;
}

- (id)initWithArray:(NSArray*)array {
    if ((self = [super init])) {
        _objects = [[NSMutableArray alloc] initWithArray:array];
    }
    return self;
}


#pragma mark - Custom accessors

- (NSUInteger)count {
    return _objects.count;
}


#pragma mark -

- (void)pushObject:(id)object {
    if (object) {
        [_objects addObject:object];
    }
}

/*
- (void)pushObjects:(NSArray*)objects {
    for (id object in objects) {
        [self pushObject:object];
    }
}*/

- (id)popObject {
    if (_objects.count > 0) {
        id object = [_objects objectAtIndex:(_objects.count - 1)];
        [_objects removeLastObject];
        return object;
    }
    return nil;
}



#pragma mark - NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len {
    return [_objects countByEnumeratingWithState:state objects:buffer count:len];
}

@end
