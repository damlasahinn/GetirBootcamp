//
//  CommentCell.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 3.04.2024.
//

import UIKit

class CommentCell: UITableViewCell {
    lazy var name: UILabel = {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(name)
        addSubview(body)
        setConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    func setConstraints() {
        name.translatesAutoresizingMaskIntoConstraints = false
        body.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            name.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            name.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            body.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8),
            body.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            body.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            body.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8) 
        ])
    }

    
    func configure(comment: Comment) {
        name.text = comment.name
        body.text = comment.body
    }
}
