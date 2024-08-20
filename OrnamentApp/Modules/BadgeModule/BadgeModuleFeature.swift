import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class BadgeModuleFeature: NSObject, FeatureCoordinatorProtocol {
    
    // MARK: Properties
    
    var runNewFlow: ((Any) -> Void)?
    
    // MARK: Private properties
    
    private var tableViewVCBuilder: TableViewVCBuilder
    private var tableViewBuilder: TableViewBuilder
    private var navigationBarStyle: NavigationBarStyle
    
    private var tableDataSource: TableDataSource
    private var tableDelegate: TableDelegate
    
    private var badgeUpdater: BadgeViewService
    private var colorChipsUpdaters: [ChipsViewService] = []
    private var sizeChipsUpdaters: [ChipsViewService] = []
    private var setChipsUpdaters: [ChipsViewService] = []
    
    private var selectedColorIndex: Int = 0
    private var selectedSizeIndex: Int = 0
    private var selectedSetIndex: Int = 0
    
    private var chipsCreationService: ChipsCreationService
    private var sectionModelService: BadgeSectionModelService
    
    init(
        screenTitle: String,
        backAction: (() -> Void)?,
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init()
    ) {
        self.tableDataSource = tableDataSource
        self.tableDelegate = tableDelegate
        self.sectionModelService = BadgeSectionModelService()
        self.chipsCreationService = ChipsCreationService()
        
        tableViewBuilder = .init(with: .init(
            backgroundColor: .white,
            dataSources: self.tableDataSource,
            delegate: self.tableDelegate
        ))
        
        var navigationBarVP = NavigationBar.ViewProperties()
        navigationBarStyle = NavigationBarStyle(
            variant: .basic(
                title: screenTitle,
                subtitle: nil,
                margins: nil
            ),
            color: .primary
        )
        navigationBarStyle.update(viewProperties: &navigationBarVP, backAction: backAction)
        
        tableViewVCBuilder = .init(with: .init(
            navigationBarViewProperties: navigationBarVP,
            tableView: tableViewBuilder.view,
            confirmButtonView: nil
        ))
        
        // MARK: Badge
        let badgeStyle = BadgeStyle(color: .neutral, size: .large, set: .full)
        let badgeViewProperties = BadgeView.ViewProperties(text: "23 +".attributed, image: .ic16Tick)
        
        badgeUpdater = BadgeViewService(
            viewProperties: badgeViewProperties,
            style: badgeStyle
        )
        
        super.init()
    }
    
    // MARK: Methods
    
    func runFlow(data: Any?) -> (any Architecture.BuilderProtocol)? {
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
            selectedIndex: selectedColorIndex,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.badgeUpdater.update(newColor: [.neutral, .accent, .accentBrand, .accentInfo][index])
                self.selectedColorIndex = index
                self.updateChipsSelection(for: &self.colorChipsUpdaters, selectedIndex: index)
            }
        )
        
        sizeChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["large", "small"],
            selectedIndex: selectedSizeIndex,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.badgeUpdater.update(newSize: [.large, .small][index])
                self.selectedSizeIndex = index
                self.updateChipsSelection(for: &self.sizeChipsUpdaters, selectedIndex: index)
            }
        )
        
        setChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["full", "basic", "simple"],
            selectedIndex: selectedSetIndex,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.badgeUpdater.update(newSet: [.full, .basic, .simple][index])
                self.selectedSetIndex = index
                self.updateChipsSelection(for: &self.setChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    private func createRowModels() -> [DSRowModel] {
        let colorChips = colorChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let sizeChips = sizeChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let setChips = setChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            DSRowModel(leading: .atom(.view(badgeUpdater.view))),
            DSRowModel(leading: .molecule(.horizontalChipseViews(colorChips))),
            DSRowModel(leading: .molecule(.horizontalChipseViews(sizeChips))),
            DSRowModel(leading: .molecule(.horizontalChipseViews(setChips))),
        ]
        
        return rowModels
    }
    
    private func updateChipsSelection(for updaters: inout [ChipsViewService], selectedIndex: Int) {
        for (index, updater) in updaters.enumerated() {
            let selected: ChipsViewStyle.Selected = selectedIndex == index ? .on : .off
            updater.update(selected: selected)
        }
    }
}
