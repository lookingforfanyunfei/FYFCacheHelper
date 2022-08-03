//
//  FYFCacheHelper.h
//  FYFCacheHelper
//
//  Created by 范云飞 on 2022/8/3.
//

#import <Foundation/Foundation.h>

/** 缓存基类协议 */
@protocol FYFBaseDataManagerProtocol <NSObject>

/** 初始化文件名,默认：com.fyf.cache.disk */
- (NSString *_Nullable)storageFileNameForDataManager;

@end

NS_ASSUME_NONNULL_BEGIN

/**
 缓存在document下
 */

@interface FYFCacheHelper : NSObject<FYFBaseDataManagerProtocol>

+ (FYFCacheHelper *)sharedInstance;

/**
 *  对象存储（同步方法）
 */
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;

/**
 *  对象存储（异步方法）
 */
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key completion:(void (^)(void))completion;

/**
 *  查找缓存的对象（同步方法）
 */
- (id<NSCoding>)objectForKey:(NSString *)key;

/**
 *  查找缓存的对象（异步方法）
 */
- (void)objectForKey:(NSString *)key completion:(void (^)(NSString *key, id<NSCoding> object))completion;

/**
 * 移除缓存的对象 (同步方法)
 */
- (void)removeObjectForKey:(NSString *)key;

/**
 * 移除缓存的对象 (异步方法)
 */
- (void)removeObjectForKey:(NSString *)key completion:(nullable void(^)(NSString *key))completion;


@end

NS_ASSUME_NONNULL_END

