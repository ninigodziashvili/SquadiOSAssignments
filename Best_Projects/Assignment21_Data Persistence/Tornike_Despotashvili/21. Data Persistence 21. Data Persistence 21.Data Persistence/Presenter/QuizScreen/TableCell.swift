//
//  TableCell.swift
//  21. Data Persistence 21. Data Persistence 21.Data Persistence
//
//  Created by Despo on 03.11.24.
//

import UIKit

final class TableCell: UITableViewCell {
    private let stack = UIStackView()
    private let questLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        setupCell()
        setupLabel()
    }
    
    private func setupCell() {
        contentView.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 21, bottom: 20, right: 21)
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
    }
    
    private func setupLabel() {
        stack.addArrangedSubview(questLabel)

        questLabel.textAlignment = .center
        questLabel.backgroundColor = .white
        questLabel.clipsToBounds = true
        questLabel.layer.cornerRadius = 12
        questLabel.heightAnchor.constraint(equalToConstant: 42).isActive = true
    }
    
    func configureCell(question: QuestionModel) {
        questLabel.configureCustomLabel(text: "Question \(question.questionNumber)", textColor: .mainViolet, fontName: "Sen-Regular", fontSize: 15)
    }
}
