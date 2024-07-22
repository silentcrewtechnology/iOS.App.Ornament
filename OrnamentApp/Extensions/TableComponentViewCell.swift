//
//  TableComponentViewCell.swift
//  OrnamentApp
//
//  Created by user on 03.07.2024.
//

import UIKit
import SnapKit
import Colors
import DesignSystem

final class TableComponentViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    struct ViewProperties {
        let text: String
    }
    
    // MARK: - Private properties
    
    private let label = UILabel()
    
    // MARK: - Life cycle

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func prepareForReuse() {
        label.attributedText = nil
    }
    
    // MARK: - Methods
    
    func update(with viewProperties: ViewProperties) {
        label.attributedText = viewProperties.text.textL(color: .contentPrimary)
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        backgroundColor = .white
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
    }
}
