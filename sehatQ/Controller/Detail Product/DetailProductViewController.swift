//
//  DetailProductViewController.swift
//  sehatQ
//
//  Created by adriansalim on 23/08/21.
//  Copyright © 2020 adriansalim. All rights reserved.
//

import UIKit

class DetailProductViewController: UIViewController {

    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var titleProduct: UILabel!
    @IBOutlet weak var descProduct: UITextView!
    @IBOutlet weak var imageProduct: UIImageView!
    
    var passPrice = String()
    var passTitle = String()
    var passDesc = String()
    var passImage = String()
    var passID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descProduct.isUserInteractionEnabled = false
        self.prepareData()
    }

    func prepareData(){
        self.priceProduct.text = passPrice
        self.titleProduct.text = passTitle
        self.descProduct.text = passDesc
        self.imageProduct.sd_setImage(with: URL(string: passImage)!, completed: nil)
    }

    @IBAction func btnBuy(_ sender: Any) {
        let model = [modelCart.init(price: passPrice, title: passTitle, desc: passDesc, image: passImage, id: passID)]
        
        
        if((UserDefaults.standard.decode(for: [modelCart].self, using: String(describing: "cart"))) != nil){
            var tmp = UserDefaults.standard.decode(for: [modelCart].self, using: String(describing: "cart"))
            tmp?.append(contentsOf: model)
            UserDefaults.standard.encode(for: tmp, using: String(describing: "cart"))
            self.successBuy()
        }
        else{
            UserDefaults.standard.encode(for: model, using: String(describing: "cart"))
            self.successBuy()
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bntShare(_ sender: Any) {
        let items = [URL(string: passImage)!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    
    func successBuy(){
        let alertController = UIAlertController(title: "Success", message: nil, preferredStyle:UIAlertController.Style.alert)

        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        { action -> Void in
        })
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UserDefaults {
    func decode<T : Codable>(for type : T.Type, using key : String) -> T? {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: key) as? Data else {return nil}
        let decodedObject = try? PropertyListDecoder().decode(type, from: data)
        return decodedObject
    }

    func encode<T : Codable>(for type : T, using key : String) {
        let defaults = UserDefaults.standard
        let encodedData = try? PropertyListEncoder().encode(type)
        defaults.set(encodedData, forKey: key)
        defaults.synchronize()
    }
}
