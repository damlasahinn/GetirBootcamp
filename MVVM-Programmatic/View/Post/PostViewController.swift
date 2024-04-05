//
//  PostViewController.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 3.04.2024.
//

import UIKit
import RxSwift

class PostViewController: UIViewController {
    var userId: Int
    private var tableView = UITableView()
    private let postVM = PostVM()
    private var posts: [Post] = []
    private let disposeBag = DisposeBag()
    
    private lazy var postList: PostListPresenter = {
       let config = PostListPresenter(posts: [])
        return config
    }()
    
    init(userId: Int) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureLayout()
    }
    
    private func configureLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        postVM.fetchPosts(for: userId).subscribe { [weak self] posts in
            guard let self else { return }
            self.postList.posts = posts
            self.tableView.reloadData()
        } onError: { error in
            print(error.localizedDescription)
        } onCompleted: {
            print("Completed")
        } onDisposed: {
            print("Completed")
        }.disposed(by: disposeBag)
    }

    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100 
        tableView.delegate = self
        tableView.dataSource = postList
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    

}

extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postId = postList.getPostId(for: indexPath)
        let commentViewController = CommentViewController(postId: postId)
        navigationController?.pushViewController(commentViewController, animated: true)
    }
}
