
import Foundation
import UIKit

class AlertView: UIView {
    
    @IBOutlet weak var backBview: UIView!
    static var instance = AlertView()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        commonInit()
        alertView.applyGradient(type: .topToBottom, colours: [Constants.Colors.mainColor,Constants.Colors.black50])
        
        
        rotate2(imageView: alertView, aCircleTime: 0.7)
        
        generateClick(target: self, selector: #selector(backV), view: backBview)
    }
    
    @objc func backV(){
        parentView.removeFromSuperview()
    }
    func rotate2(imageView: UIView, aCircleTime: Double) { //UIView

        UIView.animate(withDuration: aCircleTime/2, delay: 0.0, options: .curveLinear, animations: {
            imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }, completion: { finished in
            UIView.animate(withDuration: aCircleTime/2, delay: 0.0, options: .curveLinear, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*2))
            }, completion: { finished in
                self.rotate2(imageView: imageView, aCircleTime: aCircleTime)
            })
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {

        // alertView.layer.cornerRadius = 10
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    enum AlertType {
        case success
        case failure
        case loading
    }
    
    func showAlert(alertType: AlertType) {

        DispatchQueue.main.async {
            //Klavye Kapatmak için
            UIApplication.shared.keyWindow?.endEditing(true)
            UIApplication.shared.keyWindow?.addSubview(self.parentView)
        }

        

    }

    @IBAction func onClickDone(_ sender: Any) {
        parentView.removeFromSuperview()
    }
    
    func dismisAlert(){
        DispatchQueue.main.async {

            UIView.animate(withDuration: 0.3, animations: {
                self.parentView.alpha = 0
            }) { (finised) in
                self.parentView.removeFromSuperview()
                AlertView.instance = AlertView()

            }



        }
        
    }
}
