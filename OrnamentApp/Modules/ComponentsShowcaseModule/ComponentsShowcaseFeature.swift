import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class ComponentsShowcaseFeature: FeatureCoordinatorProtocol {
    
    // MARK: Properties
    
    var runNewFlow: ((Any) -> Void)?
    
    // MARK: Private properties
    
    private var tableViewVCBuilder: TableViewVCBuilder
    private var tableViewBuilder: TableViewBuilder
    private var tableDataSource: TableDataSource
    private var tableDelegate: TableDelegate
    private var sectionModelService: SectionRowModelService
    private let navigationBarViewPropertiesService: NavigationBarViewPropertiesService
    
    // MARK: - Init
    
    init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        self.tableDataSource = tableDataSource
        self.tableDelegate = tableDelegate
        self.sectionModelService = SectionRowModelService()
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
                    title: screenTitle
                ),
                tableView: tableViewBuilder.view
            )
        )
        tableViewVCBuilder.view.hidesBottomBarWhenPushed = true
        
        createSections()
        return tableViewVCBuilder
    }
    
    // MARK: Private methods
    
    private func createSections() {
        let section = sectionModelService.createSection(
            from: createRowModels(),
            rowsHeight: 52
        )
        tableDelegate.update(with: [section])
        tableDataSource.update(with: [section])
    }
    
    private func createRowModels() -> [DSRowModel] {
        var rowModels = [DSRowModel]()
        
        for component in Components.allCases {
            let atom = AtomDSElement.title(component.rawValue, nil, nil)
            let leadingBlock = DSRowBlocks.atom(atom)
            let dSRowModel = DSRowModel(leading: leadingBlock)
            rowModels.append(dSRowModel)
        }
        
        return rowModels
    }
}
