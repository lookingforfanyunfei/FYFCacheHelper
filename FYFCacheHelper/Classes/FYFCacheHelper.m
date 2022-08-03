//
//  FYFCacheHelper.m
//  FYFCacheHelper
//
//  Created by 范云飞 on 2022/8/3.
//

#import "FYFCacheHelper.h"

#import <YYCache/YYCache.h>

@interface FYFCacheHelper ()

@property (nonatomic, strong) YYCache *yycache;

@end

@implementation FYFCacheHelper

+ (FYFCacheHelper *)sharedInstance {
    static FYFCacheHelper *ins = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[super allocWithZone:nil] init];
    });
    return ins;
}

+ (id)allocWithZone:(NSZone *)zone{
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone{
    return [[self class] sharedInstance];
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return [[self class] sharedInstance];
}

- (NSString *)storageFileNameForDataManager {
    return @"com.fyf.cache.disk";
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *fileName = [self storageFileNameForDataManager];
        NSString *path = [documentPath stringByAppendingPathComponent:fileName];
        _yycache = [YYCache cacheWithPath:path];
    }
    return self;
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    [_yycache setObject:object forKey:key];
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key completion:(void (^)(void))completion {
    [_yycache setObject:object forKey:key withBlock:completion];
}

- (id<NSCoding>)objectForKey:(NSString *)key {
    return [_yycache objectForKey:key];
}

- (void)objectForKey:(NSString *)key completion:(void (^)(NSString *key, id<NSCoding> object))completion {
    [_yycache objectForKey:key withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        if (completion) {
            completion(key, object);
        }
    }];
}

- (void)removeObjectForKey:(NSString *)key {
    [_yycache removeObjectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key completion:(nullable void(^)(NSString *key))completion {
    [_yycache removeObjectForKey:key withBlock:^(NSString * _Nonnull key) {
        if (completion) {
            completion(key);
        }
    }];
}


@end
