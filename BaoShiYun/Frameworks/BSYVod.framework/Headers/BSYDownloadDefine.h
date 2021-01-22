//
//  BSYDownloadDefine.h
//  BSYunVod
//
//  Created by zddMac on 2020/10/26.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifndef BSYDownloadDefine_h
#define BSYDownloadDefine_h

// 下载状态
typedef NS_ENUM(NSUInteger, BSYDownloadState) {
    BSYDownloadStateNone,        // 未下载 或 下载删除了
    BSYDownloadStateReadying,    // 等待下载
    BSYDownloadStateRunning,     // 正在下载
    BSYDownloadStateSuspended,   // 下载暂停
    BSYDownloadStateCompleted,   // 下载完成
    BSYDownloadStateFailed       // 下载失败
};


// 下载文件类型
typedef NS_ENUM(NSUInteger, BSYDownloadType) {
    BSYDownloadTypeVideo,        //视频
};







#endif /* BSYDownloadDefine_h */
