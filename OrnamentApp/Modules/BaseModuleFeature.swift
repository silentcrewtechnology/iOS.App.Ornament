import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

class BaseModuleFeature: NSObject, FeatureCoordinatorProtocol {
    
    // MARK: Properties
    
    var runNewFlow: ((Any) -> Void)?
    var tableViewVCBuilder: TableViewVCBuilder
    var tableViewBuilder: TableViewBuilder
    var tableDataSource: TableDataSource
    var tableDelegate: TableDelegate
    var chipsCreationService: ChipsCreationService
    var sectionModelService: SectionRowModelService
    let navigationBarViewPropertiesService: NavigationBarViewPropertiesService
    
    // MARK: - Init
    
    init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        self.tableDataSource = tableDataSource
        self.tableDelegate = tableDelegate
        self.sectionModelService = SectionRowModelService()
        self.chipsCreationService = ChipsCreationService()
        self.navigationBarViewPropertiesService = navigationBarViewPropertiesService
        
        tableViewBuilder = .init(with: .init(
            backgroundColor: .white,
            dataSources: self.tableDataSource,
            delegate: self.tableDelegate
        ))
        tableViewVCBuilder = .init(with: .init(
            tableView: tableViewBuilder.view
        ))
    }
    
    // MARK: Methods
    
    func runFlow(data: Any?) -> (any Architecture.BuilderProtocol)? {
        guard let screenTitle = data as? String else { return nil }
        
        tableViewVCBuilder.viewUpdater.state = .updateViewProperties(
            .init(
                navigationBarViewProperties: navigationBarViewPropertiesService.createBasicVP(
                    title: screenTitle,
                    backAction: { [weak self] in self?.runNewFlow?(ModuleFlow.back) }
                ),
                tableView: tableViewBuilder.view
            )
        )
        tableViewVCBuilder.view.hidesBottomBarWhenPushed = true
        
        createSections()
        return tableViewVCBuilder
    }
    
    // Override
    func createRowModels() -> [DSRowModel] { [] }
    
    // Override
    func createUpdaters() { }
    
    // MARK: Private methods
    
    private func createSections() {
        createUpdaters()
        
        let section = sectionModelService.createSection(from: createRowModels())
        tableDelegate.update(with: [section])
        tableDataSource.update(with: [section])
    }
}
