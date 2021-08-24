//
//  HomeViewController.swift
//  sehatQ
//
//  Created by adriansalim on 23/08/21.
//  Copyright © 2020 adriansalim. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var tableViewList: UITableView!
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    
    var dataCategory = [Category]()
    var dataItems = [ProductPromo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.getDataAPI()
    }
    
    func prepareView(){
        self.roundedView.layer.cornerRadius = 10.0
        self.roundedView.clipsToBounds = true

        self.roundedView.layer.borderWidth = 1
        self.roundedView.layer.borderColor = UIColor.black.cgColor
    }
    
    func getDataAPI(){
        AF.request(URL(string: "https://private-4639ce-ecommerce56.apiary-mock.com/home")!, method: HTTPMethod(rawValue: "GET"), parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON{ response in
                if(response.response != nil){
                    guard let data = response.data else { return }
                    do{
                        let decodeData = try JSONDecoder().decode(modelHome.self, from: data )
                        self.dataCategory = decodeData[0].data.category
                        self.dataItems = decodeData[0].data.productPromo
                        
                        if(self.dataCategory.count > 0){
                            self.showCategory()
                        }
                        if(self.dataItems.count > 0){
                            self.showPromoProduct()
                        }
                    }
                    catch let jsonErr{
                        print(jsonErr)
                    }

                }
                else{
                   print("nil")
                }
        }
        
    }

    func showCategory(){
        self.collectionViewCategory.showsHorizontalScrollIndicator = false
        self.collectionViewCategory.showsVerticalScrollIndicator = false
        self.collectionViewCategory.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        self.collectionViewCategory.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        self.collectionViewCategory.delegate = self
        self.collectionViewCategory.dataSource = self
    }

    func showPromoProduct(){
        self.tableViewList.delegate = self
        self.tableViewList.dataSource = self
        self.tableViewList.separatorColor = .clear
        self.tableViewList.showsVerticalScrollIndicator  = false
        self.tableViewList.showsHorizontalScrollIndicator = false
        self.tableViewList.backgroundColor = UIColor.clear
        self.tableViewList.register(ProductTableViewCell.self, forCellReuseIdentifier: "productCell")
        self.tableViewList.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "productCell")
        self.tableViewList.tableFooterView = UIView(frame: CGRect.zero)
        self.tableViewList.reloadData()
        self.tableViewList.isHidden = false

    }
    
    @IBAction func btnSearch(_ sender: Any) {
        if(self.dataItems.count > 0){
            let vc = SearchViewController()
            vc.dataItems = self.dataItems
            self.navigationController?.pushViewController(vc, animated:true)
        }
    }
    

}
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 150)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.imageCell.sd_setImage(with: URL(string: self.dataCategory[indexPath.row].imageURL)!, completed: nil)
        cell.labelCell.text = self.dataCategory[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath as IndexPath) as! ProductTableViewCell
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = UIColor.clear
        cell.imageProduct.sd_setImage(with: URL(string: self.dataItems[indexPath.row].imageURL)!, completed: nil)
        if(self.dataItems[indexPath.row].loved == 0){
            cell.imageLike.image = UIImage(named: "loveempty")
        }
        else{
            cell.imageLike.image = UIImage(named: "lovefill")
        }
        cell.titleProduct.text = self.dataItems[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailProductViewController()
        vc.passTitle = self.dataItems[indexPath.row].title
        vc.passDesc = self.dataItems[indexPath.row].productPromoDescription
        vc.passImage = self.dataItems[indexPath.row].imageURL
        vc.passPrice = self.dataItems[indexPath.row].price
        vc.passID = self.dataItems[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated:true)
    }
}
