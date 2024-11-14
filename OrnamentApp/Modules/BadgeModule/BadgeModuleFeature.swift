import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class BadgeModuleFeature: FeatureCoordinatorProtocol {
    
    // MARK: Properties
    
    var runNewFlow: ((Any) -> Void)?
    
    // MARK: Private properties
    
    private var tableViewVCBuilder: TableViewVCBuilder
    private var tableViewBuilder: TableViewBuilder
    
    private var tableDataSource: TableDataSource
    private var tableDelegate: TableDelegate
    
    private var badgeService: BadgeViewService
    private var colorChipsUpdaters: [ChipsViewService] = []
    private var sizeChipsUpdaters: [ChipsViewService] = []
    private var setChipsUpdaters: [ChipsViewService] = []
    
    private var chipsCreationService: ChipsCreationService
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
    
        let badgeStyle = BadgeStyle(color: .neutral, size: .large, set: .full)
        let badgeViewProperties = BadgeView.ViewProperties(text: "23+".attributed, image: .ic16Tick)
        badgeService = BadgeViewService(
            viewProperties: badgeViewProperties,
            style: badgeStyle
        )
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
        
        setCell()
        return tableViewVCBuilder
    }
    
    // MARK: Private methods
    
    private func setCell() {
        createUpdaters()
        
        let cells = createRowModels()
        let sections = sectionModelService.createSections(from: cells)
        tableDelegate.update(with: sections)
        tableDataSource.update(with: sections)
    }
    
    private func createUpdaters() {
        colorChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["neutral", "accent", "accentBrand", "accentInfo"],
            selectedIndex: 0,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.badgeService.update(newColor: [.neutral, .accent, .accentBrand, .accentInfo][index])
                self.chipsCreationService.updateChipsSelection(for: &self.colorChipsUpdaters, selectedIndex: index)
            }
        )
        
        sizeChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["large", "small"],
            selectedIndex: 0,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.badgeService.update(newSize: [.large, .small][index])
                self.chipsCreationService.updateChipsSelection(for: &self.sizeChipsUpdaters, selectedIndex: index)
            }
        )
        
        setChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["full", "basic", "simple"],
            selectedIndex: 0,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.badgeService.update(newSet: [.full, .basic, .simple][index])
                self.chipsCreationService.updateChipsSelection(for: &self.setChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    private func createRowModels() -> [DSRowModel] {
        let colorChips = colorChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let sizeChips = sizeChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let setChips = setChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            DSRowModel(leading: .atom(.view(badgeService.view))),
            DSRowModel(leading: .molecule(.horizontalChipseViews(colorChips))),
            DSRowModel(leading: .molecule(.horizontalChipseViews(sizeChips))),
            DSRowModel(leading: .molecule(.horizontalChipseViews(setChips))),
        ]
        
        return rowModels
    }
}
