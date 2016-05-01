//
//  MTHistoryDataController.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 5. 1..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

import UIKit

class MTHistoryDataController: NSObject {
    
    lazy var list:IndexedItems = {
       return IndexedItems()
    }()

    var onComplete:((error:NSError?)->Void)?
    
    override init() {
        
        super.init()
    }
    
    
    func numberOfRowsInSection(section:Int) -> Int {
        return self.list.numberOfItemsPerGroup(section)
    }
    
    func numberOfSection() -> Int {
        return self.list.numberOfGroups()
    }
    
    func audioAtIndex(index:Int,section:Int) -> MTAudio {
        return self.list.itemForGroup(section, index: index) as! MTAudio
    }
    
    func groupAtSection(section:Int) -> DefaultGroup {
        
        return self.list.groupForIdx(section) as! DefaultGroup;
    }
    
    
    func requestList() -> Void {
        MTStorageService .sharedInstance.loadList {[unowned self] (list, error) in
            list?.forEach({ (media:MeTalkMedia) in
                let audio:MTAudio = MTAudio.init(metalkMedia: media)
                self.list.addItem(audio)
            })
            
            if self.onComplete != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    self.onComplete!(error: error)
                })
            }
            
        }
    }
    
}
