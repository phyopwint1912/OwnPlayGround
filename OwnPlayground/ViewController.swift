//
//  ViewController.swift
//  OwnPlayground
//
//  Created by Phyo Pwint  on 25/4/16.
//  Copyright © 2016 Phyo Pwint . All rights reserved.
//

import UIKit


class ViewController: UITableViewController, UISearchResultsUpdating {
    var detailViewController: DetailViewController? = nil
    var words = [Word]()
    var filteredWords : [Word]!
   
    let searchController = UISearchController(searchResultsController: nil)
    let mm = ModelManager.getInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        //words = mm.getAllWords()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableFooterView?.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredWords.count
        }
        return words.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? CardTableViewCell
        var candy: Word
        if searchController.active && searchController.searchBar.text != "" {
            candy = filteredWords[indexPath.row]
            cell!.titleLabel?.text = candy.word
            cell!.typeLabel?.text = candy.type
        }
        return cell!
        
    }
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        NSLog("Search text" + searchController.searchBar.text!)
        
        let typingString = searchController.searchBar.text!
        if !(typingString.isEmpty) {
            let tblName = String(typingString[typingString.startIndex]).capitalizedString
            words = mm.getAllWords(tblName)
            tableView.tableFooterView?.hidden = false
            filterContentForSearchText(searchController.searchBar.text!)
        }
        else {
            tableView.tableFooterView?.hidden = true
       }
    }
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
    func filterContentForSearchText(searchText: String) {
        if(searchText != "") {
            filteredWords = self.words.filter({ (w) -> Bool in
                return w.word.lowercaseString.containsString(searchText.lowercaseString)
            })
        }
        else {
            filteredWords = []
            tableView.tableFooterView?.hidden = true
        }
        tableView.reloadData()
    }

     //MARK: - Segues
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "showDetail" {
                let cell = sender as! CardTableViewCell
                if let indexPath = self.tableView!.indexPathForCell(cell) {
                    let candy = filteredWords[indexPath.row]
                    let controller = segue.destinationViewController as! DetailViewController
                    controller.detailWord = candy.word
                    controller.detailType = candy.type
                    controller.detailDesc = candy.desc
                    controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                    controller.navigationItem.leftItemsSupplementBackButton = true
                }
            }
        }
}

