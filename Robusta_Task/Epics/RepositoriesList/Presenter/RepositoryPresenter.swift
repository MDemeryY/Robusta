//
//  RepositoryPresenter.swift
//  Robusta_Task
//
//  Created by Mahmoud ELDemery on 17/07/2021.
//

import Foundation

protocol RepositoryPresenterProtocol: class {
    init(view: RepositoryViewProtocol)
    func viewDidLoad()
}

class RepositoryPresenter: RepositoryPresenterProtocol {
    
    weak var view: RepositoryViewProtocol?
    
    private var items: [RepositoryResponse]?

    var dataTask: URLSessionDataTask!
    static let sharedWebClient = WebClient.init(baseUrl: "https://api.github.com")

    required init(view: RepositoryViewProtocol) {
        self.view = view
    }
    
    // MARK: - Protocol methods
    func viewDidLoad() {
        print("View notifies the Presenter that it has loaded.")
        retrieveItems(path: "/repositories")
    }
    
   
    // MARK: - Private methods

     private func retrieveItems(path:String) {
        dataTask?.cancel()
                
        let resources = Resource<[RepositoryResponse], CustomError>(jsonDecoder: JSONDecoder(), path: path)
        
        dataTask = RepositoryPresenter.sharedWebClient.load(resource: resources) {[weak self] response in
            
            if let repositoryResponse = response.value {
                self?.view?.onRecivingRepositories(repositories: repositoryResponse)
            } else if let error = response.error {
                self?.view?.onFailuer(error: error)
            }

        }
    }
    
}
