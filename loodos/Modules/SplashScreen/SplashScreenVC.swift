//
//  SplashScreenVC.swift
//  loodos
//
//  Created by Berkay Delen on 19.08.2020.
//

import UIKit
import Firebase

class SplashScreenVC: UIViewController {

    @IBOutlet weak var outView2: UIView!
    @IBOutlet weak var outView1: UIView!
    @IBOutlet weak var logoLabel: UILabel!



    @IBOutlet weak var noConnectionView: UIView!

    @IBOutlet weak var logoView: UIView!

    override func viewWillAppear(_ animated: Bool) {
        self.noConnectionView.alpha = 0
        self.logoView.alpha = 0
        self.outView1.alpha = 0
        self.outView2.alpha = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        initCheckNetwork()

        //Fast

        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let initialViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        //        AppDelegate.view_window.rootViewController = initialViewController
        //        AppDelegate.view_window.makeKeyAndVisible()

        //Fast
    }
    func initCheckNetwork() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if InternetConnectionManager.isConnectedToNetwork(){
                print("Connected")
                timer.invalidate()
                self.fetchConfig()
            }else{
                print("Not Connected")
                if self.noConnectionView.alpha == 0{
                    UIView.animate(withDuration: 0.1) {
                        self.outView2.alpha = 1
                    }
                    UIView.animate(withDuration: 0.3) {
                        self.noConnectionView.alpha = 1
                    }
                }
            }
        }
    }



    func loadingAnim() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            UIView.animate(withDuration: 1.5) {
                self.outView1.alpha = 0.5
                self.outView2.alpha = 0.3
            }
        }
    }

    func fetchConfig() {
        UIView.animate(withDuration: 0.2, animations: {
  self.noConnectionView.alpha = 0
        }) { (success) in
            UIView.animate(withDuration: 0.3) {
                self.outView2.alpha = 0
            }
        }

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if Constants.Data.splashScreenName != ""{
                timer.invalidate()
                self.loadingAnim()
                UIView.animate(withDuration: 0.3) {
                    self.logoView.alpha = 1
                }
                self.setLoadingLabel()
                self.goHome()
            }
        }
    }

    func setLoadingLabel() {
        self.logoLabel.text = Constants.Data.splashScreenName
    }

    func goHome()  {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            AppDelegate.view_window.rootViewController = initialViewController
            AppDelegate.view_window.makeKeyAndVisible()
        }
    }

    

}
