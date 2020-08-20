//
//  MovieBigCardCVCell.swift
//  loodos
//
//  Created by Berkay Delen on 19.08.2020.
//

import UIKit

class MovieBigCardCVCell: UICollectionViewCell {

    @IBOutlet weak var movieCardGradient: UIView!


    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieVotes: UILabel!


    @IBOutlet weak var movieStar1: UIImageView!
    @IBOutlet weak var movieStar2: UIImageView!
    @IBOutlet weak var movieStar3: UIImageView!
    @IBOutlet weak var movieStar4: UIImageView!
    @IBOutlet weak var movieStar5: UIImageView!

    var movieStars:[UIImageView] = []

    lazy var data:MovieData? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(data:MovieData) {
        self.data = data
        movieStars = [movieStar1,movieStar2,movieStar3,movieStar4,movieStar5]

        self.moviePoster.setImageKF(url: (self.data?.poster?.replace(findString: "SX300", replaceString: "SX900"))!)
        self.movieTitle.text = self.data?.title
        self.movieVotes.text = "\(self.data?.imdbVotes ?? "0") Oy"

        var rating:Float = 0

        rating = (self.data?.imdbRating?.floatValue() ?? 0)/2
        for n in 0..<movieStars.count {
            if n+1 <= Int(rating) {
                movieStars[n].image = UIImage(systemName: "star.fill")
            }else{
                if rating > Float(n) && rating < Float(n+1){
                    movieStars[n].image = UIImage(systemName: "star.leadinghalf.fill")
                }else{
                    movieStars[n].image = UIImage(systemName: "star")
                }
            }
        }
    }

}
