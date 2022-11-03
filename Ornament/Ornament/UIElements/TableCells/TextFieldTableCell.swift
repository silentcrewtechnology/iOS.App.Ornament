//
//  TextFieldTableCell.swift
//  AbbDesign
//
//  Created by Алексей Титов on 24.10.2022.
//

import UIKit

open class TextFieldTableCell: UITableViewCell {
    
    let field = FloatingTextField()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
        setupConstaints()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        contentView.addSubview(field)
    }
    
    func setupConstaints() {
        NSLayoutConstraint.activate([
            field.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            field.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            field.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            field.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)
        ])
    }
}
