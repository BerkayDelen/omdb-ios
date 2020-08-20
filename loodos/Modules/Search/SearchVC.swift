//
//  SearchVC.swift
//  loodos
//
//  Created by Berkay Delen on 19.08.2020.
//

import UIKit

class SearchVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var searchClose: UIView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchRemoveTextView: UIView!
    @IBOutlet weak var searchNotFoundView: UIView!

    var searchPro:SearchPro? = nil

    lazy var workItem = WorkItem()

    lazy var viewModel: SearchVM = {
        return SearchVM()
    }()

    override func viewWillAppear(_ animated: Bool) {
        self.searchNotFoundView.alpha = 0
        self.searchRemoveTextView.alpha = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initVM()
        initCollectionView()
        initSearch()

    }

    func initVM() {
        viewModel.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.searchNotFoundClosure = { [weak self] () in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self?.searchNotFoundView.alpha = 1
                }
            }
        }
        viewModel.searchNotFoundCloseClosure = { [weak self] () in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self?.searchNotFoundView.alpha = 0
                }
            }
        }
    }
    func initSearch() {
        self.searchText.becomeFirstResponder()

        generateClick(target: self, selector: #selector(searchRemoveTextFnc), view: searchRemoveTextView)
        generateClick(target: self, selector: #selector(searchCloseFnc), view: self.searchClose)
        searchText.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    @objc func searchRemoveTextFnc(){
        self.searchText.text = ""
        self.view.endEditing(true)
        self.viewModel.clearSearchData()

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                self.searchNotFoundView.alpha = 0
                self.searchRemoveTextView.alpha = 0
            }
        }
    }
    @objc func searchCloseFnc(){
        self.searchText.text = ""
        self.view.endEditing(true)
        self.viewModel.clearSearchData()
        self.searchPro?.closeView()

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                self.searchNotFoundView.alpha = 0
                self.searchRemoveTextView.alpha = 0
            }
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {

        //0.35 More Fast
        //0.5 Normal
        workItem.perform(after: 0.35) {

            //            print("--Searched...")
            //            print("--Searched Text : \(textField.text!)")

            let searchText = textField.text!

            self.viewModel.clearSearchData()
            if searchText != ""{
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
                        self.searchRemoveTextView.alpha = 1
                    }
                }
                
                self.viewModel.getSearchMovies(searchText: searchText)

            }else{
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
                        self.searchNotFoundView.alpha = 0
                        self.searchRemoveTextView.alpha = 0
                    }
                }
                //self.searchData = nil
                //self.tableviewSearch.reloadData()
            }


        }

    }

    ///CollectionView
    func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.keyboardDismissMode = .onDrag

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
        return self.viewModel.numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCardSmallCVCell.self), for: indexPath) as! MovieCardSmallCVCell

        let cellData = self.viewModel.getCellViewModel(indexPath: indexPath)

        var movieData:MovieData = MovieData()
        movieData.imdbID = cellData.imdbID
        movieData.poster = cellData.poster
        movieData.title = cellData.title

        cell.setData(data: movieData)

        return cell
    }

    func layoutSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 2,
            trailing: 0)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/1.7))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: fullPhotoItem,
            count: 3
        )
        let section = NSCollectionLayoutSection(group: group)

        return section
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as? DetailVC
            {
                vc.movieID = self.viewModel.getCellViewModel(indexPath: indexPath).imdbID
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true, completion: nil)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (self.viewModel.numberOfCells) - 1{
            //Load More
            if self.viewModel.getAllCellViewModel() != nil{

                if (self.viewModel.getTotalResults()) >= (self.viewModel.numberOfCells) {
                    
                    self.viewModel.getSearchMovies(page: self.viewModel.getPage()+1, searchText: searchText.text!)
                }
            }
        }
    }
    //CollectionView

}
