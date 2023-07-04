//
//  FilterViewController.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import UIKit
protocol FilterDelegate:AnyObject{
    func appliedFilters(filters:[raceCategoryID])
}
class FilterViewController: UITableViewController {
    let cellIdentifier = "cellID"
    weak var delegate:FilterDelegate?
    var applyBt:UIBarButtonItem?
    var clearbt:UIBarButtonItem?
    let filterList:[[String:Any]] = [["name":"Greyhound","catagory":raceCategoryID.Greyhound_race],["name":"Harness","catagory":raceCategoryID.Harness_race],
                  ["name":"Horse","catagory":raceCategoryID.Horse_race]]
    var applyFilterList:[raceCategoryID] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let  applyFilterButton = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(self.applyFilter))
        let  clearFilterButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(self.clearFilter))
        self.applyBt = applyFilterButton
        self.clearbt = clearFilterButton
        navigationItem.rightBarButtonItems = [clearFilterButton,applyFilterButton]
        self.applyBt?.isEnabled = !applyFilterList.isEmpty
        self.clearbt?.isEnabled = !applyFilterList.isEmpty
        
        let  closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.closeView))
        navigationItem.leftBarButtonItem = closeButton
    }

    // MARK: - Table view data source

   
   @objc func applyFilter(){
           delegate?.appliedFilters(filters: applyFilterList)
       dismiss(animated: true)
    }
    @objc func clearFilter(){
        applyFilterList.removeAll()
        self.applyBt?.isEnabled = applyFilterList.isEmpty
        self.clearbt?.isEnabled = !applyFilterList.isEmpty
        tableView.reloadData()
     }
    @objc func closeView(){
        dismiss(animated: true)
     }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filterList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        let filterData = filterList[indexPath.row]
        if let name = filterData["name"] as? String,let catagory = filterData["catagory"] as? raceCategoryID{
            
            cell.textLabel?.text = name
            cell.accessoryType = applyFilterList.contains(catagory) ? .checkmark : .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filterData = filterList[indexPath.row]
        if let catagory = filterData["catagory"] as? raceCategoryID{
            if applyFilterList.contains(catagory){
                applyFilterList.removeAll{$0 == catagory}
            }else{
                applyFilterList.append(catagory)
            }
            updateButtons()
            tableView.reloadData()
        }
    }

    func updateButtons(){
        self.applyBt?.isEnabled = true
        self.clearbt?.isEnabled = true
    }
}
