//
//  TopImageViewCell.swift
//  loodos
//
//  Created by Berkay Delen on 20.08.2020.
//

import UIKit

class TopImageViewCell: UITableViewCell {
    @IBOutlet weak var posterGradientView: UIView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieType: UILabel!


    var data:MovieData? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        DispatchQueue.main.async {
            self.posterGradientView.applyGradient(type: .topToBottom,colours: [Constants.Colors.black0,Constants.Colors.black],points:[0.2,0.90])
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setData(data:MovieData)  {
        self.data = data

        self.moviePoster
            .setImageKFLoader(
                url: (self.data?.poster?.replace(findString: "SX300", replaceString: "SX2000"))!,
                placeholder: (self.data?.poster?.replace(findString: "SX300", replaceString: "SX100"))!
            )

        self.movieTitle.text = "\(self.data?.title ?? "") (\(self.data?.year ?? "" ))"
    }
    
}
