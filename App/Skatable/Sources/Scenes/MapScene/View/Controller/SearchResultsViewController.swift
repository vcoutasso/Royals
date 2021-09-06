//
//  SearchResultsViewController.swift
//  Skatable
//
//  Created by Vinícius Couto on 05/09/21.
//

import UIKit

class SearchResultsViewController: UISearchController, UISearchBarDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
        // Do any additional setup after loading the view.
        searchBar.delegate = self
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: {})
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
