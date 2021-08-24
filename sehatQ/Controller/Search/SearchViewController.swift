//
//  SearchViewController.swift
//  sehatQ
//
//  Created by adriansalim on 23/08/21.
//  Copyright © 2020 adriansalim. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var tableViewList: UITableView!
    
    
    var dataItems = [ProductPromo]()
    var selectedItems = [ProductPromo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }

    func prepareView(){
        self.roundedView.layer.cornerRadius = 10.0
        self.roundedView.clipsToBounds = true

        self.roundedView.layer.borderWidth = 1
        self.roundedView.layer.borderColor = UIColor.black.cgColor
        
        self.textFieldSearch.tag = 1
        self.textFieldSearch.delegate = self
        
        self.tableViewList.delegate = self
        self.tableViewList.dataSource = self
        self.tableViewList.separatorColor = .clear
        self.tableViewList.showsVerticalScrollIndicator  = false
        self.tableViewList.showsHorizontalScrollIndicator = false
        self.tableViewList.backgroundColor = UIColor.clear
        self.tableViewList.register(searchTableViewCell.self, forCellReuseIdentifier: "searchCell")
        self.tableViewList.register(UINib(nibName: "searchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        self.tableViewList.tableFooterView = UIView(frame: CGRect.zero)
        self.tableViewList.reloadData()
        self.tableViewList.isHidden = false
    }

    func getProduct(keyword: String){
        let group = DispatchGroup()
        group.enter()

        DispatchQueue.main.async {
            for i in 0...(self.dataItems.count-1) {
                if self.dataItems[i].title.lowercased().contains(keyword.lowercased()) {
                    self.selectedItems.append(self.dataItems[i])
                }
            }
            group.leave()
        }

        group.notify(queue: .main) {
            self.tableViewList.reloadData()
        }
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.tag == 1){
            self.getProduct(keyword: textField.text!)
        }
        return true;
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath as IndexPath) as! searchTableViewCell
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = UIColor.clear
        cell.imageSearch.sd_setImage(with: URL(string: self.selectedItems[indexPath.row].imageURL)!, completed: nil)
        cell.titleSearch.text = self.selectedItems[indexPath.row].title
        cell.priceSearch.text = self.selectedItems[indexPath.row].price
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailProductViewController()
        vc.passTitle = self.selectedItems[indexPath.row].title
        vc.passDesc = self.selectedItems[indexPath.row].productPromoDescription
        vc.passImage = self.selectedItems[indexPath.row].imageURL
        vc.passPrice = self.selectedItems[indexPath.row].price
        vc.passID = self.selectedItems[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated:true)
    }
}
