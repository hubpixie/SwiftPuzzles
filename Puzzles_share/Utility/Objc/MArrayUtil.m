//
//  MArrayUtil.m
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/08/13.
//  Copyright © 2017 venus.janne. All rights reserved.
//

#import "MArrayUtil.h"

@implementation MArrayUtil
+(instancetype)sharedInstance {
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

-(NSArray*)combination:(NSArray*)array limit:(NSInteger)limit block:(void(^)(NSArray*))itemEach {
    NSMutableArray *combinations = [[NSMutableArray alloc] init];
    
    NSInteger cnt = [array count];
    if(cnt <= 1) {
        if(itemEach) {
            itemEach(array);
        }
        return array;
    }
    if(limit < cnt) {
        cnt = limit;
    } else {
        for(id obj in array ) {
            if(itemEach) {
                itemEach(@[obj]);
            }
        }
        return array;
    }
    for (NSInteger i = 0; i < cnt; i++) {
        for(NSInteger j = i + 1; j < cnt; j++){
            NSArray *newCombination = [[NSArray alloc] initWithObjects:
                                       [array objectAtIndex:i],
                                       [array objectAtIndex:j],
                                       nil];
            [combinations addObject:newCombination];
            if(itemEach) {
                itemEach(newCombination);
            }
        }
    }
    return combinations;
}

-(NSArray*)combination_1:(NSArray*)array limit:(NSInteger)limit  block:(void(^)(NSArray*))itemEach {
    NSMutableArray* combinations = [NSMutableArray array];
    
    void (^_comb_func)(NSMutableArray*, NSInteger, NSInteger);
    __block  void (^_comb_block)(NSMutableArray*, NSInteger, NSInteger) = _comb_func = ^void(NSMutableArray* combs, NSInteger depth, NSInteger idx) {
        for(NSInteger i = idx; i < [array count] - limit + depth + 1; i++) {
            [combs addObject:[array objectAtIndex:i]];
            if(depth < limit - 1) {
                _comb_block(combs, depth + 1, i + 1);
            }else{
                [combinations addObject:combs];
                if(itemEach) {
                    itemEach(combs);
                }
                [combs removeAllObjects];
            }
        }
    };
    _comb_block([NSMutableArray array], 0, 0);
    
    return combinations;
}

@end
