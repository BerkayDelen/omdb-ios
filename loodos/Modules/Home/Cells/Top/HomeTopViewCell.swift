//
//  HomeTopViewCell.swift
//  loodos
//
//  Created by Berkay Delen on 19.08.2020.
//

import UIKit

class HomeTopViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieType: UILabel!
    @IBOutlet weak var posterGradientView: UIView!
    @IBOutlet weak var detailBtn: UIView!

    lazy var data:MovieData? = nil

    var vc:UIViewController? = nil

    override func awakeFromNib() {
        super.awakeFromNib()

        DispatchQueue.main.async {
            self.posterGradientView.applyGradient(type: .topToBottom,colours: [Constants.Colors.black0,Constants.Colors.black],points:[0.2,0.90])
        }

        generateClick(target: self, selector: #selector(detailBtnFnc), view: detailBtn)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setData(vc:UIViewController,data:MovieData) {
        self.vc = vc
        self.data = data

        self.moviePoster.setImageKF(url: (self.data?.poster?.replace(findString: "SX300", replaceString: "SX2000"))!)
        self.movieTitle.text = self.data?.title
        self.movieType.text = self.data?.genre
    }


    @objc func detailBtnFnc(){
        DispatchQueue.main.async {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as? DetailVC
            {
                vc.movieID = self.data?.imdbID
                vc.modalPresentationStyle = .overCurrentContext
                self.vc!.present(vc, animated: true, completion: nil)
            }
        }
    }
}
