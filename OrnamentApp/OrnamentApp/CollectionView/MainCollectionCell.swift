//
//  MainCollectionCell.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 26.07.2023.
//

import UIKit

final class MainCollectionCell: UICollectionViewCell {
    
    public struct ViewProperties {
        public var title: NSAttributedString
        public var backgroundColor: UIColor
        public let action: () -> Void
        
        public init(title: NSAttributedString,
                    backgroundColor: UIColor,
                    action: @escaping () -> Void) {
            self.title = title
            self.backgroundColor = backgroundColor
            self.action = action
        }
    }
    
    //MARK: - UI
    
    private let textLabel = UILabel()
    
    static let reuseId = "MainCollectionCell"
    
    private var viewProperties: ViewProperties?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //MARK: - public methods
    
    public func create(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        addedViews()
        setupConstraints()
        setupView()
        setData(with: viewProperties)
    }
    
    public func update(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        setData(with: viewProperties)
    }
    
    //MARK: - private methods
    
    private func addBorder(borderWidth: CGFloat = 1.0, borderColor: UIColor = UIColor.black) {
        let layer = CALayer()
        let frame = self.frame
        layer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = 25
        contentView.layer.insertSublayer(layer, at: 0)
    }
    
    private func setupView() {
        addBorder()
        layer.cornerRadius = 25
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
    }
    
    private func setData(with viewProperties: ViewProperties?){
        textLabel.attributedText = viewProperties?.title
        backgroundColor = viewProperties?.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addedViews() {
        contentView.addSubview(textLabel)
    }
    
    private func setupConstraints() {
        textLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(20)
            $0.bottom.right.equalToSuperview().offset(-20)
        }
    }
}
