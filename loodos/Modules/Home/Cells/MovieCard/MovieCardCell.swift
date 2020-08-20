//
//  MovieCardCell.swift
//  loodos
//
//  Created by Berkay Delen on 19.08.2020.
//

import UIKit

class MovieCardCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cellTitle: UILabel!


    var vc:UIViewController? = nil

    var cellSize:CGFloat = 0.4
    var cellType:CellTypes = .small

    lazy var data:[MovieData] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(vc:UIViewController,data:[MovieData],cellSize:CGFloat,cellType:CellTypes,title:String) {
        self.vc = vc
        self.data = data

        self.cellSize = cellSize
        self.cellType = cellType
        self.cellTitle.text = title

        self.collectionView.reloadData()
    }



    ///CollectionView
    func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        let collectionViewLayout: UICollectionViewLayout = {

            let layout = UICollectionViewCompositionalLayout { [self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
                return self.layoutSection()
            }
            return layout
        }()

        collectionView!.collectionViewLayout = collectionViewLayout

        collectionView.register(UINib(nibName: String(describing: MovieBigCardCVCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MovieBigCardCVCell.self))
        collectionView.register(UINib(nibName: String(describing: MovieCardSmallCVCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MovieCardSmallCVCell.self))

        self.collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if cellType == .small{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCardSmallCVCell.self), for: indexPath) as! MovieCardSmallCVCell
            cell.setData(data: self.data[indexPath.row])
            return cell
        }else if cellType == .big{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieBigCardCVCell.self), for: indexPath) as! MovieBigCardCVCell
            cell.setData(data: self.data[indexPath.row])
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieBigCardCVCell.self), for: indexPath) as! MovieBigCardCVCell
            cell.setData(data: self.data[indexPath.row])
            return cell
        }
    }


    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(cellSize), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as? DetailVC
            {
                vc.movieID = self.data[indexPath.row].imdbID
                vc.modalPresentationStyle = .overCurrentContext
                self.vc!.present(vc, animated: true, completion: nil)
            }
        }
    }
    ///CollectionView
    
}
