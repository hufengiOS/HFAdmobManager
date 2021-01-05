//
//  VSAdUnit.m
//  HFAdmobManager
//
//  Created by hf on 2021/1/4.
//

#import "VSAdUnit.h"

@implementation VSAdUnit

+ (void)saveWithObj:(id)obj key:(NSString *)key {
    if(nil != obj && nil != key){
        [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)removeObjForKey:(NSString *)key {
    if(key){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)saveWithInt:(NSInteger)value key:(NSString *)key {
    if(nil != key){
        [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSInteger)intValueForKey:(NSString *)key {
    if (nil != key) {
        return [[NSUserDefaults standardUserDefaults] integerForKey:key];
    }
    return 0;
}

+ (id)objForKey:(NSString *)key {
    if (nil != key) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    return nil;
}

+ (void)saveSerializedObj:(id)obj key:(NSString *)key {
    NSData *serialized = [NSKeyedArchiver archivedDataWithRootObject:obj];
    if(serialized){
        [[NSUserDefaults standardUserDefaults] setObject:serialized forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (id)getSerializedObjForKey:(NSString *)key {
    if (nil != key) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
    }
    return nil;
}

+ (void)removeSerializedObjForKey:(NSString *)key {
    if (nil != key) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - fileManager
//dic
+ (BOOL)writeFileWithFileName:(NSString *)fileName dic:(NSDictionary *)dic {
    return [dic writeToFile:[VSAdUnit filePathWithFileName:fileName] atomically:YES];
}

+ (NSDictionary *)readFileWithFileName:(NSString *)fileName {
    return [NSDictionary dictionaryWithContentsOfFile:[VSAdUnit filePathWithFileName:fileName]];
}

// array
+ (BOOL)writeFileWithFileName:(NSString *)fileName array:(NSArray *)array {
    return [array writeToFile:[VSAdUnit filePathWithFileName:fileName] atomically:YES];
}

+ (NSArray *)readArrayFileWithFileName:(NSString *)fileName {
    return [NSArray arrayWithContentsOfFile:[VSAdUnit filePathWithFileName:fileName]];
}

// string
+ (BOOL)writeFileWithFileName:(NSString *)fileName contentStr:(NSString *)contentStr {
    return [contentStr writeToFile:[VSAdUnit filePathWithFileName:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (NSString *)readStringWithFileName:(NSString *)fileName {
    return [NSString stringWithContentsOfFile:[VSAdUnit filePathWithFileName:fileName] encoding:NSUTF8StringEncoding error:nil];
}

// 沙盒路径
+ (NSString *)filePathWithFileName:(NSString *)fileName {
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    docDir = [docDir stringByAppendingPathComponent:@"VPNSpeed"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:docDir isDirectory:&isDir];
    if (!(isDir == YES && existed == YES)) {
        [fileManager createDirectoryAtPath:docDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    docDir = [docDir stringByAppendingPathComponent:fileName];
    
//    HFAdDebugLog(@"沙盒路径 %@", docDir);
    
    return docDir;
}


+ (UIImage*)createImageFromColors:(NSArray*)colors withFrame: (CGSize) size {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    start = CGPointMake(0.0, size.height);
    end = CGPointMake(size.width, 0.0);
    CGContextDrawLinearGradient(context, gradient, start, end,kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    
    UIGraphicsEndImageContext();
    return image;
}


+ (nullable NSString*)jsonStringWithObject:(id _Nullable)object {
    if (!object) {
        return nil;
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (id _Nullable)objectWithJsonString:(NSString * _Nullable)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingAllowFragments
                                                          error:&err];
    
    if(err) {/*JSON解析失败*/
        return nil;
    }
    return dic;
}

@end
