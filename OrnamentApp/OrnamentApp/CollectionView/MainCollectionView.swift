//  MainCollectionView.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 19.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit
import Architecture

final class MainCollectionView: UIView, ViewProtocol {
    
    deinit {
        print("💀 удалился MainCollectionView")
    }
    
    struct ViewProperties {
        var accessibilityId = "MainCollectionView"
        var cellsModels: [MainCellModel]?
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
    
    private let title = UILabel()
    private let collectionView: UICollectionView
    
    // MARK: Initialization
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 44
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: MainCollectionCell.reuseId)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: .zero)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        configureViews()
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Ниже функции от ViewProtocol'а
    // MARK: ViewProtocol
    
    func update(viewProperties: ViewProperties?) {
        guard let viewProperties else { return }
        self.viewProperties = viewProperties
        accessibilityIdentifier = viewProperties.accessibilityId
        collectionView.reloadData()
        // Здесь обновляем все свойства вью
    }
    
    // MARK: Private funcs
    
    private func configureViews() {
        // Здесь настраиваем внутренние свойства - то, что не будет меняться
        backgroundColor = .white
    }
    
    private func setupSubview() {
        // Здесь мы добавляем вьюхи и настраиваем констрейнты
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(36)
            $0.trailing.equalToSuperview().offset(-36)
            $0.bottom.equalToSuperview()
        }
    }
}

extension MainCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewProperties?.cellsModels?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.reuseId, for: indexPath) as? MainCollectionCell else {
            return UICollectionViewCell()
        }

        guard let model = viewProperties?.cellsModels?[indexPath.row] else {
            return cell
        }

        let cellProperty = MainCollectionCell.ViewProperties(
            title: model.title,
            backgroundColor: model.backgroundColor,
            action: model.action)
        cell.create(with: cellProperty)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewProperties?.cellsModels?[indexPath.row].action()
    }
}

extension MainCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width*0.35, height: UIScreen.main.bounds.width*0.34)
    }
}
