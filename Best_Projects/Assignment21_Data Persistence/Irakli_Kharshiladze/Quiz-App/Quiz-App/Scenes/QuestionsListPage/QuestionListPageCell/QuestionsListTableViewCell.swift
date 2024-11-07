//
//  QuestionsListTableViewCell.swift
//  Quiz-App
//
//  Created by irakli kharshiladze on 03.11.24.
//

import UIKit

final class QuestionsListTableViewCell: UITableViewCell {
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "Question", font: UIFont(name: "Sen-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16), textColor: UIColor(hexString: "2B0063"), alignment: .center)
        
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        
        setupQuestionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupQuestionLabel() {
        contentView.addSubview(questionLabel)
        
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            questionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configureCell(with index: String) {
        questionLabel.text = "Question \(index)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
    }
    
}
