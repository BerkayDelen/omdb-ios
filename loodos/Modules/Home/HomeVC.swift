//
//  HomeVC.swift
//  loodos
//
//  Created by Berkay Delen on 19.08.2020.
//

import UIKit

class HomeVC: UIViewController , UITableViewDelegate,UITableViewDataSource,SearchPro {


    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchOutView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchIconView: UIView!



    lazy var viewModel: HomeVM = {
        return HomeVM()
    }()

    override func viewWillAppear(_ animated: Bool) {
        searchOutView.alpha = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        AlertView.instance.showAlert(alertType: .loading)

        initTableview()
        initVM()


        generateClick(target: self, selector: #selector(searchOpenFnc), view: searchIconView)
    }

    func closeView() {
        UIView.animate(withDuration: 0.3) {
            self.searchOutView.alpha = 0
        }
    }
    @objc func searchOpenFnc(){
        initSearch()
        UIView.animate(withDuration: 0.3) {
            self.searchOutView.alpha = 1
        }
    }
    func initSearch() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: SearchVC.self)) as! SearchVC
        controller.searchPro = self
        self.embed(controller, inView: searchView)
    }
    func initVM() {
        viewModel.getHeaderMovie()
        viewModel.getNewMovies()
        viewModel.getPopularMovies()

        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

    }

    ///Tableview
    func initTableview() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.contentInset.bottom = 100
        self.tableView.showsVerticalScrollIndicator = false
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.getHeaderData()?.imdbID != nil{
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                AlertView.instance.dismisAlert()
            }
            return 3
        }else{
            return 0
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        if indexPath.row == 0 {
            let cell = Bundle.main.loadNibNamed(String(describing: HomeTopViewCell.self), owner: self, options: nil)?.first  as! HomeTopViewCell
            if self.viewModel.getHeaderData() != nil{
                cell.setData(vc:self,data: self.viewModel.getHeaderData()!)
            }

            return cell
        }else if indexPath.row == 1 {
            let cell = Bundle.main.loadNibNamed(String(describing: MovieCardCell.self), owner: self, options: nil)?.first  as! MovieCardCell


            cell.setData(vc: self,data: self.viewModel.getAllPopularMovieData(),cellSize: 0.3,cellType: .small,title: "Popülerler")
            return cell

        }else{
            let cell = Bundle.main.loadNibNamed(String(describing: MovieCardCell.self), owner: self, options: nil)?.first  as! MovieCardCell

            cell.setData(vc: self,data: self.viewModel.getAllViewModelData(),cellSize: 0.4,cellType: .big,title: "En Yeniler")
            return cell
        }


    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.view.frame.width * 1.1
        }else if indexPath.row == 1 {
            return 200 + 55
        }else if indexPath.row == 2 {
            return 350 + 55
        }else{
            return UITableView.automaticDimension
        }
    }
    ///Tableview


}
