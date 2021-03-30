//
// AgoraAudioFrame.h
// AgoraRtcEngineKit
//
// Copyright (c) 2020 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>


/** The definition of the AgoraAudioFrame protocol.

@note Implement all the callbacks in this protocol in the critical thread. We recommend avoiding any time-consuming operation in the critical thread.
*/
@protocol AgoraAudioFrameDelegate <NSObject>
@required

- (BOOL)onRecordAudioFrame:(AgoraAudioFrame* _Nonnull)frame;
- (BOOL)onPlaybackAudioFrame:(AgoraAudioFrame* _Nonnull)frame;
- (BOOL)onMixedAudioFrame:(AgoraAudioFrame* _Nonnull)frame;
- (BOOL)onPlaybackAudioFrameBeforeMixing:(AgoraAudioFrame* _Nonnull)frame uid:(NSUInteger)uid;
@end
