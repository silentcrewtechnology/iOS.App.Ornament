//  MainViewController.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 19.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit
import Architecture

final class MainViewController: ViewController<MainFeature>, ViewProtocol {
    
    deinit {
        print("💀 удалился MainScreenController")
    }
    
    struct ViewProperties {
        var accessibilityId = "MainScreenController"
        var mainCollectionViewProperty: MainCollectionView.ViewProperties = .init()
        // Здесь описываются свойства вью
        // нужно заменить SomeView на твою View
    }
    
    enum State {
        case create(ViewProperties)
        // Здесь описываются состояния вью
    }
    
    // Здесь хранятся свойства вью, чтобы вызывать экшены
    private var viewProperties: ViewProperties = .init()
    
    // Ниже создаем внутренние вью элементы
    // MARK: UI Elements
    
    var mainCollectionView: MainCollectionView?
    
    // нужно заменить SomeView на твою View
    // var someView: SomeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupSubview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // Ниже функции от ViewProtocol'а
    // MARK: ViewProtocol
    
    func update(with viewProperties: ViewProperties) {
        view.accessibilityIdentifier = viewProperties.accessibilityId
        // Здесь обновляем все свойства вью
        self.viewProperties = viewProperties
    }
    
    // MARK: Private funcs
    
    private func configureViews() {
        // Здесь настраиваем внутренние свойства - то, что не будет меняться
    }
    
    private func setupSubview() {
        guard let mainCollectionView else { return }
        // Здесь мы добавляем вьюхи и настраиваем констрейнты
        view.addSubview(mainCollectionView)
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
