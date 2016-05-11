//
//  MTAudioTableViewCell.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 5. 11..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

import UIKit

class MTAudioTableViewCell: UITableViewCell {

    @IBOutlet weak var plotView: UCPlotView!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.contentView.backgroundColor = UIColor.init(red: 0xf0, green: 0x00, blue: 0x00, alpha: 0.1);
        self.plotView.backgroundColor = UIColor.clearColor()
        self.plotView.plotColor = UIColor.init(red: 0x9c, green: 0x00, blue: 0x00, alpha: 0.9);
        self.plotView.plotWidth = 2.0
        self.plotView.mode = UCPlotViewModeProgress
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    func setTime(str:String) -> Void {
        self.lblTime.text = str
    }
    
    func setPlots(plots:Array<AnyObject>?) -> Void {
        self.plotView.setPeeks(plots)
    }

}
