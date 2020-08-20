//
//  MovieCardSmallCVCell.swift
//  loodos
//
//  Created by Berkay Delen on 19.08.2020.
//

import UIKit

class MovieCardSmallCVCell: UICollectionViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!

    lazy var data:MovieData? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(data:MovieData) {
        self.data = data
        self.moviePoster.setImageKFLoader(
            url: (self.data?.poster?.replace(findString: "SX300", replaceString: "SX500"))!,
            placeholder: (self.data?.poster?.replace(findString: "SX300", replaceString: "SX50"))!
        )

        self.movieTitle.text = self.data?.title

    }

}
