//
//  PostCell.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 3.04.2024.
//

import UIKit

class PostCell: UITableViewCell {
    
    var onShowMoreTapped: (() -> Void)?
    
    lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        return lbl
    }()
    
    lazy var body: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textColor = .lightGray
        lbl.numberOfLines = 0
        lbl.sizeToFit() 
        return lbl
    }()
    
    var showMoreBtn: UIButton = {
       let btn = UIButton()
        btn.setTitle("Show more", for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(title)
        addSubview(body)
        addSubview(showMoreBtn)
        showMoreBtn.addTarget(self, action: #selector(showMoreTapped), for: .touchUpInside)
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showMoreTapped() {
           onShowMoreTapped?()
       }
    
    func setConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        body.translatesAutoresizingMaskIntoConstraints = false
        showMoreBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            body.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            showMoreBtn.topAnchor.constraint(equalTo: body.bottomAnchor, constant: 8),
            showMoreBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            showMoreBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func configure(post: Post) {
        title.text = post.title
        body.text = post.body
    }
}
