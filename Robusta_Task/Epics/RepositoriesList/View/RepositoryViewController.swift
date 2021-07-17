//
//  RepositoryViewController.swift
//  Robusta_Task
//
//  Created by Mahmoud ELDemery on 17/07/2021.
//

import UIKit


protocol RepositoryViewProtocol: class {
    func onRecivingRepositories(repositories: [RepositoryResponse])
    func onFailuer(error: WebError<CustomError>)

}


class RepositoryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBtn: UIButton!
    
    var repositoryDataSource = RepositoryDataSource()
    var presenter: RepositoryPresenter?
    
    var repos = [RepositoryResponse]()
    var filterdRepos = [RepositoryResponse]()

    // search bar
    var leftConstraint: NSLayoutConstraint!
    let searchBar = UISearchBar()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        presenter = RepositoryPresenter(view: self)
        activityIndicator.startAnimating()
        presenter?.viewDidLoad()
        addExpandedSearchBar()
        // Do any additional setup after loading the view.
    }

    
    private func intializeCollectionView(items:[RepositoryResponse]) {
        collectionView.register(UINib(nibName: "RepositoryCell", bundle: .main), forCellWithReuseIdentifier: "RepositoryCell")

        repos = items
        filterdRepos = items
        repositoryDataSource.items = filterdRepos
        self.collectionView.delegate = repositoryDataSource
        self.collectionView.dataSource = repositoryDataSource
        self.collectionView.reloadData()
        
        repositoryDataSource.didSelectStoreItemCompletion = {[weak self] in
            
        }
    }
    
    private func addExpandedSearchBar() {
        // Search bar.
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.setShowsCancelButton(false, animated: false)
        searchBar.delegate = self

        searchView.addSubview(searchBar)

        leftConstraint = searchBar.leftAnchor.constraint(equalTo: searchView.leftAnchor)
        leftConstraint.isActive = false
        searchBar.rightAnchor.constraint(equalTo: searchView.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: searchView.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: searchView.bottomAnchor).isActive = true

    }
    
    private func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
    }
    
    private func handleError(_ error: WebError<CustomError>) {
        switch error {
        case .noInternetConnection:
            showErrorAlert(with: "The internet connection is lost")
        case .unauthorized:
            showErrorAlert(with: "Move to login")
        case .other:
            showErrorAlert(with: "Unfortunately something went wrong")
        case .custom(let error):
            showErrorAlert(with: error.message)
        }
    }
    
    private func updateUI(repos:[RepositoryResponse]) {
        repositoryDataSource.items = repos
        collectionView.reloadData()
    }
    
    @IBAction func searchBtnTapped(_ sender: UIButton) {
        
        if searchView.isHidden == false {
            searchBar.text?.removeAll()
            self.updateUI(repos: repos)
            searchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            searchView.isHidden = true
            view.endEditing(true)
        } else {
            searchBtn.setImage(UIImage(systemName: "x.circle"), for: .normal)
            searchBar.becomeFirstResponder()
            searchView.isHidden = false
        }
    
        let isOpen = leftConstraint.isActive == true
        
        // Inactivating the left constraint closes the expandable header.
        leftConstraint.isActive = isOpen ? false : true
        
        // Animate change to visible.
        UIView.animate(withDuration: 0.5, animations: {
            self.searchView.alpha = isOpen ? 0 : 1
            self.searchView.layoutIfNeeded()
        })
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

extension RepositoryViewController: RepositoryViewProtocol{
    func onRecivingRepositories(repositories: [RepositoryResponse]) {
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.intializeCollectionView(items: repositories)        
        }
    }
    
    func onFailuer(error: WebError<CustomError>){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.handleError(error)
        }
     
    }
}


extension RepositoryViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterdRepos = searchText.isEmpty ? repos : repos.filter({(repo: RepositoryResponse) -> Bool in
               // If dataItem matches the searchText, return true to include it
            let result = ((repo.name.range(of: searchText.lowercased(), options: .caseInsensitive) != nil))
            return result
           })
        
        DispatchQueue.main.async {
            self.updateUI(repos: self.filterdRepos)

        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
}
