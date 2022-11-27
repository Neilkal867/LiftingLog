//
//  DetailTableViewCell.swift
//  LiftingLog
//
//  Created by Joseph Melito on 11/23/22.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var workoutTypeTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var repsTF: UITextField!
    @IBOutlet weak var setsTF: UITextField!
    @IBOutlet weak var commentsTF: UITextView!
    override func awakeFromNib() {
        //super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
