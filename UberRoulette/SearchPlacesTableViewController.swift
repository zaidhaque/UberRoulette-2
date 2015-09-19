//
//  SearchPlacesTableViewController.swift
//  UberRoulette
//
//  Created by Samuel Raudabaugh on 9/19/15.
//  Copyright © 2015 Cornell Tech. All rights reserved.
//

import UIKit

class SearchPlacesTableViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    struct SearchControllerRestorableState {
        var wasActive = false
        var wasFirstResponder = false
    }
    
    var searchController: UISearchController!
    var resultsController: ResultsTableViewController!
    var searchQuery: HNKGooglePlacesAutocompleteQuery!
    var restoredState = SearchControllerRestorableState()
    var savedPlaces: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        resultsController = storyboard?.instantiateViewControllerWithIdentifier("ResultsController") as! ResultsTableViewController
        resultsController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        definesPresentationContext = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        searchQuery = HNKGooglePlacesAutocompleteQuery.sharedQuery()
        
        // Restore the searchController's active state.
        if restoredState.wasActive {
            searchController.active = restoredState.wasActive
            restoredState.wasActive = false
            
            if restoredState.wasFirstResponder {
                searchController.searchBar.becomeFirstResponder()
                restoredState.wasFirstResponder = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPlaces.count
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchQuery.fetchPlacesForSearchQuery(searchController.searchBar.text, completion: {(places: [AnyObject]!, error: NSError!) -> Void in
            if error != nil {
                print(error)
            } else {
                let resultsController = searchController.searchResultsController as! ResultsTableViewController
                resultsController.searchResults = places
                resultsController.tableView.reloadData()
            }
        })
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell", forIndexPath: indexPath)
        
        if let cellPlace = savedPlaces[indexPath.row] as? HNKGooglePlacesAutocompletePlace {
            cell.textLabel?.text = cellPlace.name
        }
        
        return cell
    }

    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Check to see which table view cell was selected.
        if tableView != self.tableView {
            let selectedPlace = resultsController.searchResults[indexPath.row]
            savedPlaces.insertObject(selectedPlace, atIndex: savedPlaces.count)
            resultsController.dismissViewControllerAnimated(true, completion: nil)
            self.tableView.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
