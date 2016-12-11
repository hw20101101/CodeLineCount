//
//  main.m
//  20161211CodeLineCount
//
//  Created by hw on 2016/12/11.
//  Copyright © 2016年 hwacdx. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
 
        int line = 0;
        line += codeLineCount(@"/Users/HW/Documents/hexo_item");
        NSLog(@"-->> 代码行数:%d", line);
    }
    return 0;
}


//计算单个文件的代码行数
int codeLineCount(NSString *path){
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dir = NO;
    BOOL exists = [fileManager fileExistsAtPath:path isDirectory:&dir];
    
    if (!exists) {//文件夹/文件不存在
        return 0;
    }
    
    if (dir) {//是文件夹
        
        int line = 0;
        
        //1.获取当前路径下的所有文件夹(名)
        NSArray *array = [fileManager contentsOfDirectoryAtPath:path error:nil];
        
        //2.遍历当前路径下的所有文件夹(名)
        for (NSString *fileName in array) {
            
            //3.拼接子文件夹(名)
            NSString *fullPath = [path stringByAppendingPathComponent:fileName];
            //4.递归调用
            line += codeLineCount(fullPath);
        }
        
        return line;
        
    } else {//是文件
        
        //1.判断文件的扩展名
        NSString *extens = [[path pathExtension] lowercaseString];
        if (![extens isEqualToString:@"h"] && ![extens isEqualToString:@"m"] && ![extens isEqualToString:@"c"]) {
            return 0;
        }
        
        //2.加载文件内容
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        //3.将文件内容切割为每一行
        NSArray *array = [content componentsSeparatedByString:@"\n"];
        return array.count;
    }
}
