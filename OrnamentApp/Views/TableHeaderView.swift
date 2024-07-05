//
//  TableHeaderView.swift
//  OrnamentApp
//
//  Created by user on 04.07.2024.
//

import UIKit
import SnapKit
import Colors
import DesignSystem

final class TableHeaderView: UIView {
    
    // MARK: - Properties
    
    struct ViewProperties {
        let text: String
    }
    
    // MARK: - Private properties
    
    private let label = UILabel()
    
    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func update(with viewProperties: ViewProperties) {
        label.attributedText = viewProperties.text.textXS(color: .contentSecondary)
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        backgroundColor = .white
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
        }
    }
}
