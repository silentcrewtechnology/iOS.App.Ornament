import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class BadgeModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var badgeService: BadgeViewService
    private var colorChipsUpdaters: [ChipsViewService] = []
    private var sizeChipsUpdaters: [ChipsViewService] = []
    private var setChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        let badgeStyle = BadgeStyle(color: .neutral, size: .large, set: .full)
        let badgeViewProperties = BadgeView.ViewProperties(text: "23+".attributed, image: .ic16Tick)
        badgeService = BadgeViewService(
            viewProperties: badgeViewProperties,
            style: badgeStyle
        )
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        colorChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Neutral", "Accent", "AccentBrand", "AccentInfo"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.badgeService.update(newColor: [.neutral, .accent, .accentBrand, .accentInfo][index])
                self.chipsCreationService.updateChipsSelection(for: &self.colorChipsUpdaters, selectedIndex: index)
            }
        )
        
        sizeChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Large", "Small"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.badgeService.update(newSize: [.large, .small][index])
                self.chipsCreationService.updateChipsSelection(for: &self.sizeChipsUpdaters, selectedIndex: index)
            }
        )
        
        setChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Full", "Basic", "Simple"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.badgeService.update(newSet: [.full, .basic, .simple][index])
                self.chipsCreationService.updateChipsSelection(for: &self.setChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let colorChips = colorChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let sizeChips = sizeChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let setChips = setChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(badgeService.view)),
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(colorChips)),
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(sizeChips)),
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(setChips)),
                cellSelectionStyle: .none
            ),
        ]
        
        return rowModels
    }
}
