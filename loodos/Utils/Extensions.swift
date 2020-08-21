//
//  Extension.swift
//  loodos
//
//  Created by Berkay Delen on 6.08.2020.
//

import UIKit
import Foundation


extension UIImageView{
    func setImageKF(url:String){
        self.kf.setImage(with: URL(string: (url)))
    }

    func setImageKFLoader(url:String,placeholder:String){
        var first = true

        self.kf.setImage(with: URL(string: (url)),
                         progressBlock: { (receivedSize, totalSize) in

                            if first{
                                DispatchQueue.main.async {
                                    ///Add Blur Maybe?
                                    var bgImage = UIImageView()
                                    bgImage.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                                    bgImage.contentMode = .scaleAspectFill
                                    bgImage.kf.setImage(with: URL(string: (placeholder)))
                                    bgImage.tag = 101
                                    self.addSubview(bgImage)
                                }
                                first = false
                            }
                         }) { (image, error, cacheType, imageUrl) in


            if let viewWithTag = self.viewWithTag(101) {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.1) {
                        viewWithTag.removeFromSuperview()
                    }
                }
            }
        }
    }
    func tint(color:UIColor){
        self.image = self.image!.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}


extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}


extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    func applyGradient(type:GradientType,colours: [UIColor],points:[Double]) -> Void {
        DispatchQueue.main.async {

            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = colours.map { $0.cgColor }
            if type == .topToBottom{
                gradient.startPoint = CGPoint(x : 0.0, y : points[0])
                gradient.endPoint = CGPoint(x :0.0, y: points[1])
            }else if type == .bottomToTop{
                gradient.startPoint = CGPoint(x : 0.0, y : points[0])
                gradient.endPoint = CGPoint(x :0.0, y: points[1])
            }

            self.layer.insertSublayer(gradient, at: 0)
        }
    }
    func applyGradient(type:GradientType,colours: [UIColor]) -> Void {
        DispatchQueue.main.async {

            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = colours.map { $0.cgColor }
            if type == .topToBottom{
                gradient.startPoint = CGPoint(x : 0.0, y : 0)
                gradient.endPoint = CGPoint(x :0.0, y: 1)
            }else if type == .bottomToTop{
                gradient.startPoint = CGPoint(x : 0.0, y : 1)
                gradient.endPoint = CGPoint(x :0.0, y: 0)
            }

            self.layer.insertSublayer(gradient, at: 0)
        }
    }
    func applyGradientTopBottom(colours: [UIColor]) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x : 0.0, y : 0)
        gradient.endPoint = CGPoint(x :1.0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
}



extension UIView {
    @IBInspectable
    var circle: Bool {
        get {
            return layer.cornerRadius == min(self.frame.width, self.frame.height) / CGFloat(2.0) ? true : false
        }
        set {
            if newValue {
                layer.cornerRadius = layer.frame.size.width/2
                layer.masksToBounds = true
            }


        }
    }
    @IBInspectable
    var cornerCircle: Bool {
        get {
            return layer.cornerRadius == min(self.frame.width, self.frame.height) / CGFloat(2.0) ? true : false
        }
        set {
            if newValue {
                layer.cornerRadius = layer.frame.size.height/2
                layer.masksToBounds = true
            }


        }
    }
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}


extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    func placeHolderColorFunc(_ color: UIColor){
        var placeholderText = ""
        if self.placeholder != nil{
            placeholderText = self.placeholder!
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
}
extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}
extension UIViewController{
    func embed(_ viewController:UIViewController, inView view:UIView){
        //remove()
        for view in (self.children){


            if view.view.accessibilityIdentifier == "Embed" {
                view.view.backgroundColor = UIColor.green

                view.view.removeFromSuperview()
            }

            // printData("Log Data -> \(view.view.tag)")


        }

        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        print(view.bounds)
        view.accessibilityIdentifier = "Embed"
        view.tag = 199
        viewController.view.tag = 199
        viewController.view.accessibilityIdentifier = "Embed"

        view.addSubview(viewController.view)
        self.addChild(viewController)
        print(view.subviews.count)
        viewController.didMove(toParent: self)
    }
}


extension UserDefaults {
    open func setStruct<T: Codable>(_ value: T?, forKey defaultName: String){
        let data = try? JSONEncoder().encode(value)
        set(data, forKey: defaultName)
    }

    open func structData<T>(_ type: T.Type, forKey defaultName: String) -> T? where T : Decodable {
        guard let encodedData = data(forKey: defaultName) else {
            return nil
        }

        return try! JSONDecoder().decode(type, from: encodedData)
    }

    open func setStructArray<T: Codable>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }

        set(data, forKey: defaultName)
    }

    open func structArrayData<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: defaultName) as? [Data] else {
            return []
        }

        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
}

extension String{
    func replace(findString:String,replaceString:String) -> String{
        return self.replacingOccurrences(of: findString,
                                         with: replaceString,
                                         options: .literal)
    }
    func floatValue() -> Float? {
        return Float(self)
    }
}
