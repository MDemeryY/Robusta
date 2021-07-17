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

    var repositoryDataSource = RepositoryDataSource()
    var presenter: RepositoryPresenter?


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        presenter = RepositoryPresenter(view: self)
        activityIndicator.startAnimating()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override class func awakeFromNib() {
    
    }
    
    private func intializeCollectionView(items:[RepositoryResponse]) {
        collectionView.register(UINib(nibName: "RepositoryCell", bundle: .main), forCellWithReuseIdentifier: "RepositoryCell")

        
        repositoryDataSource.items = items
        self.collectionView.delegate = repositoryDataSource
        self.collectionView.dataSource = repositoryDataSource
        self.collectionView.reloadData()
        
        repositoryDataSource.didSelectStoreItemCompletion = {[weak self] in
            
        }
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
    
    private func updateUI() {
        collectionView.reloadData()
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
