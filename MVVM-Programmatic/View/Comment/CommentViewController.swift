//
//  CommentViewController.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 3.04.2024.
//

import UIKit
import RxSwift

class CommentViewController: UIViewController {

    var postId: Int
    private var tableView = UITableView()
    private let commentVM = CommentVM()
    private let comments: [Comment] = []
    private let disposeBag = DisposeBag()
    
    private lazy var commentList: CommentListPresenter = {
        let config = CommentListPresenter(comments: [])
        return config
    }()
    
    init(postId: Int) {
        self.postId = postId
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
        
        commentVM.fetchComments(for: postId).subscribe { [weak self] comments in
            guard let self else { return }
            self.commentList.comments = comments
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
        tableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = commentList
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}
