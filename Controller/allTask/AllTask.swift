//
//  AllTask.swift
//  MainTask
//
//  Created by кирилл корнющенков on 04.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import UIKit

class AllTask: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tableData:[allTaskData] = [allTaskData(color: .red, title: "title", data: "!"),allTaskData(color: .gray, title: "2", data: "3")]
    
    //search
    var filteredTableData = [allTaskData]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewDidLoad()
    }
    
    //добавление searchbar 
    private func searchViewDidLoad(){
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            //controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()

            tableView.tableHeaderView = controller.searchBar

            return controller
        })()

        // Reload the table
        tableView.reloadData()
    }
}

//MARK: tableview
extension AllTask: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return tableData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AllTaskCell
        
        if (resultSearchController.isActive) {
            cell.colorIndicator.backgroundColor = filteredTableData[indexPath.row].color
            cell.dateLabel.text = filteredTableData[indexPath.row].data
            cell.titleLabel.text = filteredTableData[indexPath.row].title
            return cell
        }
        else {
            cell.colorIndicator.backgroundColor = tableData[indexPath.row].color
            cell.dateLabel.text = tableData[indexPath.row].data
            cell.titleLabel.text = tableData[indexPath.row].title
            return cell
        }
    }
}

//MARK: UISearchResultsUpdating
extension AllTask: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll()
        
        let searchText = searchController.searchBar.text!
        let array = tableData.filter { $0.title.range(of: searchText, options: [.caseInsensitive]) != nil || $0.data.range(of: searchText, options: [.caseInsensitive]) != nil }
        filteredTableData = array
        
        self.tableView.reloadData()
    }
}
