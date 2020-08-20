//
//  DetailContentCell.swift
//  loodos
//
//  Created by Berkay Delen on 20.08.2020.
//

import UIKit

class DetailContentCell: UITableViewCell {

    @IBOutlet weak var movieDetail: UITextView!

    var data:MovieData? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setData(data:MovieData) {
        self.data = data
        movieDetail.text = self.data?.plot
    }
    
}
