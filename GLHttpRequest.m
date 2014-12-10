//
//  GLHttpRequest.m
//  QFSNSUserListDemo
//
//  Created by mac on 14-11-24.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "GLHttpRequest.h"

@interface GLHttpRequest ()<NSURLConnectionDataDelegate>
{
    //为了存储init中传入block
    void (^_success)(NSData *data);
    
    //为了下载
    NSMutableData *_data;
    NSURLConnection *_urlConnection;
}
@end

@implementation GLHttpRequest
//初始化方法
-(id)initWithURLString:(NSString *)urlString
               success:( void (^)(NSData *data) )success
{
    if(self = [super init])
    {
        //保存参数
        _urlString = urlString;
        _success = success;
        
        //开始下载数据, 利用NSURLConnection
        _data = [[NSMutableData alloc] init];
        _urlConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]] delegate:self startImmediately:YES];
        
    }
    return self;
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //下载完成之后回调block
    if(_success)
    {
        _success(_data);
    }
}
@end
