//
//  MTHistoryViewController.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 5. 11..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

import UIKit

class MTHistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let cellIdentifier:String = "audioCell"
    let headerIdentifier:String = "audioHeader"
    lazy var dataController:MTHistoryDataController = {
        return MTHistoryDataController()
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView .registerNib(UINib.init(nibName: "MTAudioTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView .registerNib(UINib.init(nibName: "SectionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: headerIdentifier)
    
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .SingleLine
        tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10)
        
        self.dataController.onComplete = {[unowned self](error:NSError?) -> Void in
            
            self.tableView .reloadData();
        }
        
        self.dataController.requestList();
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:MTAudioTableViewCell = tableView .dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath) as! MTAudioTableViewCell
        
        let audio:MTAudio = self.dataController.audioAtIndex(indexPath.row, section: indexPath.section)
        
        let duration:CGFloat = CGFloat(audio.duration.doubleValue)
        
        cell.setTime(MTUtils.durationToString(duration))
        cell.setPlots(audio.audioPeaks)
        

        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let group:DefaultGroup = dataController.groupAtSection(section)
        let view:MTHistorySectionHeaderView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(headerIdentifier) as! MTHistorySectionHeaderView
        
        view.setTitle(group.groupTitle())
        
        return view
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataController.numberOfRowsInSection(section)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataController.numberOfSection()
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }

 
 
 
 

}
