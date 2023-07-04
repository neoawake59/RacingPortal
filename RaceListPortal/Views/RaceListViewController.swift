//
//  RaceListViewController.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import Foundation
import UIKit

class RaceListViewController: UITableViewController {
    
    
    var appliedFiltersList:[raceCategoryID] = []
    var usersListData:RacesListModel?
    var raceList:[RaceSummary] = []
    var filteredRaceList:[RaceSummary] = []
    var filterButton:UIBarButtonItem?
    var isFilterApplied:Bool = false
    var timer:Timer?
//    var iscallAPI:Bool = true
    private lazy var networkService = NetworkService<RaceListAPI>()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.title = "List Of Races"
        let nib = UINib(nibName: "RaceListCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "RaceListCell")
        
        filterButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), style: .plain, target: self, action: #selector(self.showFilters))
        navigationItem.rightBarButtonItem = filterButton
        getRaceList()
    }
    
    @objc func showFilters(){

            let vc = FilterViewController()
            vc.delegate = self
            vc.applyFilterList = self.appliedFiltersList
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .pageSheet

            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
            }
            present(nav, animated: true, completion: nil)

    }
    private func getRaceList(){
        
        self.usersListData = nil
        let indicator = Utilities.activityIndicatior(position: view.center)
        DispatchQueue.main.async { [self] in
            view.addSubview(indicator)
            indicator.startAnimating()
        }
        
        let usersRequest = RaceListAPI.getRaceList
        self.networkService.modelResponseWithRequest(usersRequest, type: RacesListModel.self) {  response in
            DispatchQueue.main.async {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
            self.filteredRaceList.removeAll()
            self.raceList.removeAll()
            switch response{
           
            case .success(let data):
                self.usersListData = data
                
                if let raceSummaryData = self.usersListData?.data?.raceSummaries?.values{
                    
                    for raceSummaryRecord in raceSummaryData{
                        
                        self.raceList.append(raceSummaryRecord)
                    }
                    self.raceList = self.raceList.sorted{($0.advertisedStart?.seconds)! < ($1.advertisedStart?.seconds)!}
                    self.startTimer()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
               
            case .failure(_):
                print("error")
            }
        }
    }
}


extension RaceListViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFilterApplied ? filteredRaceList.count : raceList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RaceListCell", for: indexPath) as? RaceListCell else {return UITableViewCell()}
        
        let raceData = isFilterApplied ? filteredRaceList[indexPath.row] : raceList[indexPath.row]
        cell.raceNameLabel?.text = "\(raceData.meetingName ?? "") : \(raceData.raceNumber ?? 1)"
        cell.countdownCompleteDelegate = self
        cell.backgroundColor = UIColor.lightText
        cell.racemage.image = UIImage(named: Utilities.getRaceCategoryImage(catetegoryID: raceCategoryID(rawValue: raceData.categoryID!) ?? .Greyhound_race))
        if let unixTime = raceData.advertisedStart?.seconds{
            let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
            let time = timeDiffrance(fromDate: Date(), toDate: date)
            if let sc = time{
                cell.configureCell(withCountdownTimer: (index: raceData.raceID!, createdAt: Date().timeIntervalSince1970, duration: Double(sc + 60)))
            }
        }
        cell.accessoryType = .none
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func timeDiffrance(fromDate:Date,toDate:Date) -> Int? {
        let difference = Calendar.current.dateComponents([.second], from: fromDate, to: toDate)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second]
        return difference.second
    }
}

extension RaceListViewController:TimerFineshDelegate{
    func countdownHasFinished(atIndex index: String) {
        DispatchQueue.main.async { [self] in
            for (index1, element) in isFilterApplied ? filteredRaceList.enumerated() : raceList.enumerated() {
              
                if element.raceID == index{
                    if isFilterApplied{
                        filteredRaceList.remove(at: index1)
                        raceList.removeAll{$0.raceID == index}
                    }else{
                        raceList.remove(at: index1)
                    }
                    
                    tableView.deleteRows(at: [IndexPath(row: index1, section: 0)], with: .automatic)
                }
            }
            if isFilterApplied {
                if filteredRaceList.count != 0 {
                    isFilterApplied = true
                }else{
                    isFilterApplied = false
                   if raceList.count < 5 {
                       appliedFiltersList.removeAll()
                       
                   }else{
                       tableView.reloadData()
                   }
                }
            }else{
                if raceList.count < 5 {
//                        getRaceList()
                    
                    appliedFiltersList.removeAll()
                }
            }
            
        }
    }
}

extension RaceListViewController{
    func startTimer()  {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                if self.raceList.count < 5 {
                    self.isFilterApplied = false
                    self.appliedFiltersList.removeAll()
                    self.getRaceList()
                    self.stopTimer()
                    
                }
            }
        }
        
    }
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
}

extension RaceListViewController:FilterDelegate{
    func appliedFilters(filters: [raceCategoryID]) {
        if filters.count != 0 {
            appliedFiltersList = filters
            filteredRaceList.removeAll()
            for cat in appliedFiltersList{
                filteredRaceList.append(contentsOf: raceList.filter{$0.categoryID == cat.rawValue})
            }
            self.filteredRaceList = self.filteredRaceList.sorted{($0.advertisedStart?.seconds)! < ($1.advertisedStart?.seconds)!}
//            raceList = filteredRaceList
            isFilterApplied = true
        }else{
            isFilterApplied = false
            appliedFiltersList = []
        }
        tableView.reloadData()
    }
}
