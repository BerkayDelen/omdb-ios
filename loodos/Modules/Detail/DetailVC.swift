//
//  DetailVC.swift
//  loodos
//
//  Created by Berkay Delen on 20.08.2020.
//

import UIKit

class DetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var tableView: UITableView!

    var movieID:String? = nil

    lazy var viewModel: DetailVM = {
        return DetailVM()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initVM()
        generateClick(target: self, selector: #selector(backBtnViewFnc), view: backBtnView)
        initTableview()
    }

    func initVM() {
        viewModel.getMovieDetail(movieID: movieID!)
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

    }

    @objc func backBtnViewFnc(){
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        self.dismiss(animated: true, completion: nil)

    }

    ///Tableview
    func initTableview() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.contentInset.bottom = 100
        self.tableView.showsVerticalScrollIndicator = false

        var pullControl = UIRefreshControl()

        pullControl.accessibilityCustomRotors = .none
        pullControl.tintColor = .clear
        pullControl.subviews.first?.alpha = 0
        pullControl.attributedTitle = NSAttributedString(string: "")
        pullControl.addTarget(self, action: #selector(pulledRefreshControl), for: UIControl.Event.valueChanged)
        tableView.addSubview(pullControl) // not required when using UITableViewController
    }

    @objc func pulledRefreshControl() {
        // Code to refresh table view
        self.dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.getData() != nil {
            return 3
        }else{
            ///Movie Not Found
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0{
            let cell = Bundle.main.loadNibNamed(String(describing: TopImageViewCell.self), owner: self, options: nil)?.first  as! TopImageViewCell
            cell.setData(data: self.viewModel.getData()!)

            return cell
        }else if indexPath.row == 1{
            let cell = Bundle.main.loadNibNamed(String(describing: RatingCell.self), owner: self, options: nil)?.first  as! RatingCell
            cell.setData(data: self.viewModel.getData()!)

            return cell
        }else if indexPath.row == 2{
            let cell = Bundle.main.loadNibNamed(String(describing: DetailContentCell.self), owner: self, options: nil)?.first  as! DetailContentCell
            cell.setData(data: self.viewModel.getData()!)

            return cell
        }else{
            let cell = Bundle.main.loadNibNamed(String(describing: TopImageViewCell.self), owner: self, options: nil)?.first  as! TopImageViewCell

            return cell
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return self.view.frame.width * 1.1
        }else if indexPath.row == 1{
            return 225
        }else if indexPath.row == 2{
            return UITableView.automaticDimension
        }else{
            return UITableView.automaticDimension
        }
    }
    ///Tableview


}
