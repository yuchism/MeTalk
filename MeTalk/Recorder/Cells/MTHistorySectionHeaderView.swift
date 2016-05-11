//
//  MTHistorySectionHeaderView.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 5. 11..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

import UIKit

class MTHistorySectionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        self.lblTitle.textColor = UIColor.init(red: 0x00, green: 0x00, blue: 0x00, alpha: 0.5)
    }

    func setTitle(str:String) -> Void {
        self.lblTitle.text = str
    }
    
}
