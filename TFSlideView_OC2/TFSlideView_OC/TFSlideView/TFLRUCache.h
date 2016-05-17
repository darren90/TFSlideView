//
//  TFLRUCache.h
//  TFSlideView_OC
//
//  Created by Fengtf on 16/5/17.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TFLRUCacheProtocol <NSObject>

- (void)setObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

@end


#pragma mark - TFLRUCache

@interface TFLRUCache : NSObject
- (id)initWithCount:(NSInteger)count;

- (void)setObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

@end
