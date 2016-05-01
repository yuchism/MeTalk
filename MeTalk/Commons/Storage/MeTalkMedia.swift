//
//  MeTalkMedia.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 5. 1..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

import Foundation
import CoreData

@objc(MeTalkMedia)
class MeTalkMedia: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    
    func setAudioPeeksList(audioPeeks:AnyObject!) ->Void {
        self.audioPeeks = NSKeyedArchiver.archivedDataWithRootObject(audioPeeks)
    }
    
    func getAudioPeeksList() -> Array<Float> {
        return NSKeyedUnarchiver.unarchiveObjectWithData(self.audioPeeks!)! as! Array<Float>
    }
    
    func setAudio(audio:MTAudio) {
        
        self.createDate = audio.createDate;
        self.filePath = audio.filePath;
        self.mediaId = audio.mediaId;
        self.duration = audio.duration;
        self.setAudioPeeksList(audio.audioPeaks)
    }
    
    
}
