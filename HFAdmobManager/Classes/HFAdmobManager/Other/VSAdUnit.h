//
//  VSAdUnit.h
//  HFAdmobManager
//
//  Created by hf on 2021/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface VSAdUnit : NSObject

+ (void)saveWithObj:(id)obj key:(NSString *)key;
+ (void)saveWithInt:(NSInteger)value key:(NSString *)key;
+ (NSInteger)intValueForKey:(NSString *)key;
+ (id)objForKey:(NSString *)key;
+ (void)removeObjForKey:(NSString *)key;

+ (void)saveSerializedObj:(id)obj key:(NSString *)key;
+ (id)getSerializedObjForKey:(NSString *)key;
+ (void)removeSerializedObjForKey:(NSString *)key;


#pragma mark - fileManager
+ (BOOL)writeFileWithFileName:(NSString *)fileName dic:(NSDictionary *)dic;
+ (NSDictionary *)readFileWithFileName:(NSString *)fileName;

+ (BOOL)writeFileWithFileName:(NSString *)fileName array:(NSArray *)array;
+ (NSArray *)readArrayFileWithFileName:(NSString *)fileName;

+ (BOOL)writeFileWithFileName:(NSString *)fileName contentStr:(NSString *)contentStr;
+ (NSString *)readStringWithFileName:(NSString *)fileName;


+ (UIImage*)createImageFromColors:(NSArray*)colors withFrame: (CGSize) size;


+ (nullable NSString*)jsonStringWithObject:(id _Nullable)object;
+ (id _Nullable)objectWithJsonString:(NSString * _Nullable)jsonString;
@end

NS_ASSUME_NONNULL_END
