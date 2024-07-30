//
//  PageControlExample.swift
//  OrnamentApp
//
//  Created by user on 30.07.2024.
//

import UIKit
import Components
import SnapKit
import DesignSystem

private final class PageControlExampleVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Private properties
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: PageControl с коллекцией
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(250, 150)
        layout.scrollDirection = .horizontal

       let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        return collection
    }()
    
    private lazy var collectionPageControl = PageControl()
    private lazy var collectionPageControlProperties: PageControl.ViewProperties = {
        var vp = PageControl.ViewProperties.init(numberOfPages: self.numberOfPagesInCollection)
        PageControlStyle(size: .big).update(viewProperties: &vp)
        return vp
    }()

    // MARK: PageControl с управлением страниц напрямую
    private lazy var buttonPlus: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(tapPlus), for: .touchUpInside)
        return button
    }()
    private lazy var buttonMinus: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("-", for: .normal)
        button.addTarget(self, action: #selector(tapMinus), for: .touchUpInside)
        return button
    }()
    
    private lazy var customPageControl = PageControl()
    private lazy var customPageControlProperties: PageControl.ViewProperties = {
        var vp = PageControl.ViewProperties.init(numberOfPages: self.numberOfPagesInCustomControl)
        PageControlStyle(size: .normal).update(viewProperties: &vp)
        vp.dotView.selectedBackgroundColor = .red
        vp.dotView.notSelectedBackgroundColor = .blue
        return vp
    }()
    
    private var numberOfPagesInCollection = 5
    private var numberOfPagesInCustomControl = 10
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(100)
            make.width.equalTo(250)
            make.centerX.equalToSuperview()
        }

        let labelCollection =  UILabel()
        labelCollection.numberOfLines = 0
        labelCollection.text = "PageControl с зависимостью от коллекции"
        stack.addArrangedSubview(labelCollection)

        stack.addArrangedSubview(collection)
        
        collection.snp.makeConstraints { make in
            make.size.equalTo(200)
        }

        stack.addArrangedSubview(collectionPageControl)
        collectionPageControl.update(with: collectionPageControlProperties)
        
        let label =  UILabel()
        label.numberOfLines = 0
        label.text = "PageControl с управлением страниц напрямую"
        stack.addArrangedSubview(label)

        stack.addArrangedSubview(buttonPlus)
        buttonPlus.snp.makeConstraints { make in
            make.height.width.equalTo(50)
        }
        
        stack.addArrangedSubview(buttonMinus)
        buttonMinus.snp.makeConstraints { make in
            make.height.width.equalTo(50)
        }
        
        stack.addArrangedSubview(customPageControl)
        customPageControl.update(with: customPageControlProperties)

        stack.addArrangedSubview(UIView())
    }
    
    // MARK: - Methods

    @objc func tapPlus() {
        if  Int(self.customPageControlProperties.currentPage) + 1 <= self.numberOfPagesInCustomControl {
            self.customPageControlProperties.currentPage += 1
            customPageControl.update(with: self.customPageControlProperties)
        }
    }

    @objc func tapMinus() {
        if  Int(self.customPageControlProperties.currentPage) > 0 {
            self.customPageControlProperties.currentPage -= 1
            customPageControl.update(with: self.customPageControlProperties)
        }
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPagesInCollection
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath.self) as UICollectionViewCell
        cell.backgroundColor = .gray
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Float(scrollView.contentOffset.x / scrollView.contentSize.width * CGFloat(numberOfPagesInCollection))
        self.collectionPageControlProperties.currentPage = currentPage
        collectionPageControl.update(with: self.collectionPageControlProperties)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
