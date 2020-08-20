//
//  RatingCell.swift
//  loodos
//
//  Created by Berkay Delen on 20.08.2020.
//

import UIKit

class RatingCell: UITableViewCell {

    @IBOutlet weak var imdbTitle: UILabel!
    @IBOutlet weak var imdbRating: UILabel!

    @IBOutlet weak var sectionOneCompany: UILabel!
    @IBOutlet weak var sectionTwoCompany: UILabel!
    @IBOutlet weak var sectionThreeCompany: UILabel!

    @IBOutlet weak var sectionOneRating: UILabel!
    @IBOutlet weak var sectionTwoRating: UILabel!
    @IBOutlet weak var sectionThreeRating: UILabel!

    @IBOutlet weak var movieStar1: UIImageView!
    @IBOutlet weak var movieStar2: UIImageView!
    @IBOutlet weak var movieStar3: UIImageView!
    @IBOutlet weak var movieStar4: UIImageView!
    @IBOutlet weak var movieStar5: UIImageView!

    var movieStars:[UIImageView] = []


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
        movieStars = [movieStar1,movieStar2,movieStar3,movieStar4,movieStar5]

        var rating:Float = 0
        rating = (self.data?.imdbRating?.floatValue() ?? 0)/2

        imdbRating.text = "\(rating)"

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

        for n in 0..<(self.data?.ratings!.count)!  {
            if n == 0 {
                sectionOneCompany.text = self.data?.ratings![n].source
                sectionOneRating.text = self.data?.ratings![n].value
            }else if n == 1 {
                sectionTwoCompany.text = self.data?.ratings![n].source
                sectionTwoRating.text = self.data?.ratings![n].value
            }else if n == 2 {
                sectionThreeCompany.text = self.data?.ratings![n].source
                sectionThreeRating.text = self.data?.ratings![n].value
            }
        }
        
    }
    
}
