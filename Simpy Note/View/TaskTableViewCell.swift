//
//  TaskTableViewCell.swift
//  Simpy Note
//
//  Created by Khin Phone Ei on 13/03/2023.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
