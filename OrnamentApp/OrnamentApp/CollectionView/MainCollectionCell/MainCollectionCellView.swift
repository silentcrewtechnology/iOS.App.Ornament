//  MainCollectionCell.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 19.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit
import Architecture

final class MainCollectionCell: UICollectionViewCell, ViewProtocol {
    
    deinit {
        print("💀 удалился MainCollectionCell")
    }
    
    struct ViewProperties {
        var accessibilityId = "MainCollectionCell"
        public var title: NSAttributedString
        public var backgroundColor: UIColor
        public let action: () -> Void
        // Здесь описываются свойства вью
    }
    
    enum State {
        case create(ViewProperties?)
        // Здесь описываются состояния вью
    }
    
    // Здесь хранятся свойства вью, чтобы вызывать экшены
    var viewProperties: ViewProperties?
    
    // Ниже создаем внутренние вью элементы
    // MARK: UI Elements
    
    private let textLabel = UILabel()
    static let reuseId = "MainCollectionCell"
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func create(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        configureViews()
        setupSubview()
        setData(with: viewProperties)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Ниже функции от ViewProtocol'а
    // MARK: ViewProtocol
    
    func update(viewProperties: ViewProperties?) {
        guard let viewProperties else { return }
        self.viewProperties = viewProperties
        // Здесь обновляем все свойства вью
        setData(with: viewProperties)
    }
    
    // MARK: Private funcs
    
    private func setData(with viewProperties: ViewProperties?){
        textLabel.attributedText = viewProperties?.title
        accessibilityIdentifier = "\(viewProperties?.title)"
        backgroundColor = viewProperties?.backgroundColor
    }
    
    private func configureViews() {
        // Здесь настраиваем внутренние свойства - то, что не будет меняться
        addBorder()
        layer.cornerRadius = 25
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
    }
    
    private func setupSubview() {
        // Здесь мы добавляем вьюхи и настраиваем констрейнты
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(20)
            $0.bottom.right.equalToSuperview().offset(-20)
        }
    }
    private func addBorder(borderWidth: CGFloat = 1.0, borderColor: UIColor = UIColor.black) {
        let layer = CALayer()
        let frame = self.frame
        layer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = 25
        contentView.layer.insertSublayer(layer, at: 0)
    }
}
