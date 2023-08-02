//
//  MainCollectionView.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 26.07.2023.
//

import UIKit
import Architecture

final class MainCollectionView: UIView, ViewProtocol {
    
    struct ViewProperties {
        var cellsModels: [MainCellModel]?
    }
    
    private var viewProperties: ViewProperties?
    
    private let title = UILabel()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 44
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: MainCollectionCell.reuseId)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func create(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        addedViews()
        setupConstraints()
        collectionView.reloadData()
    }
    
    func update(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        collectionView.reloadData()
    }
    
    private func addedViews() {
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
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
