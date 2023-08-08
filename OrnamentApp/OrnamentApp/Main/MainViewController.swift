//
//  MainViewController.swift
//  AbbDesignTestApp
//
//  Created by Алексей Титов on 30.10.2022.
//

import UIKit
import SnapKit
import Architecture

class MainViewController: UIViewController, ViewProtocol {
    
    struct ViewProperties {
        let addedSectionMessageView: Closure<UIView>
    }
    
    private let mainCollectionView = UIView()
    
    private var viewProperties: ViewProperties?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addedViews()
        setupConstraints()
    }
    
    func create(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        addedViews()
        setupConstraints()
        viewProperties?.addedSectionMessageView(mainCollectionView)
    }
    
    func update(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
    }
    
    private func addedViews(){
        self.view.addSubview(mainCollectionView)
    }
    
    private func setupConstraints(){
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
