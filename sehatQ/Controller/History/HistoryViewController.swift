//
//  HistoryViewController.swift
//  sehatQ
//
//  Created by adriansalim on 14/08/20.
//  Copyright © 2020 adriansalim. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableViewList: UITableView!

    var arrHistory = [modelCart]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.prepareView()
    }
    
    func prepareView(){
        if((UserDefaults.standard.decode(for: [modelCart].self, using: String(describing: "cart"))) != nil){
            self.arrHistory = UserDefaults.standard.decode(for: [modelCart].self, using: String(describing: "cart"))!
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
        else{
            self.tableViewList.delegate = nil
            self.tableViewList.dataSource = nil
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrHistory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath as IndexPath) as! searchTableViewCell
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = UIColor.clear
        cell.imageSearch.sd_setImage(with: URL(string: self.arrHistory[indexPath.row].image!)!, completed: nil)
        cell.titleSearch.text = self.arrHistory[indexPath.row].title!
        cell.priceSearch.text = self.arrHistory[indexPath.row].price!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailProductViewController()
        vc.passTitle = self.arrHistory[indexPath.row].title!
        vc.passDesc = self.arrHistory[indexPath.row].desc!
        vc.passImage = self.arrHistory[indexPath.row].image!
        vc.passPrice = self.arrHistory[indexPath.row].price!
        vc.passID = self.arrHistory[indexPath.row].id!
        self.navigationController?.pushViewController(vc, animated:true)
    }
}
