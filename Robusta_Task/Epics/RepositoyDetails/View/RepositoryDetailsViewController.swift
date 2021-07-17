//
//  RepositoryDetailsViewController.swift
//  Robusta_Task
//
//  Created by Mahmoud ELDemery on 17/07/2021.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var teamsUrlLabel: UILabel!
    @IBOutlet weak var commitsUrlLabel: UILabel!
    @IBOutlet weak var issuesUrlLabel: UILabel!
    @IBOutlet weak var branchUrlLabel: UILabel!
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var ownerameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    
    var repo:RepositoryResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    
    private func setupUI() {
        descLabel.text = repo?.descriptionString ?? ""
        teamsUrlLabel.text = repo?.teams_url ?? ""
        commitsUrlLabel.text = repo?.commits_url ?? ""
        issuesUrlLabel.text = repo?.issues_url ?? ""
        branchUrlLabel.text = repo?.branches_url ?? ""
        userTypeLabel.text = repo?.owner?.type ?? ""
        ownerameLabel.text = repo?.full_name ?? ""
        repoNameLabel.text = repo?.name ?? ""
        ownerAvatarImageView.downloaded(from: repo?.owner?.avatar_url ?? "" )
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
