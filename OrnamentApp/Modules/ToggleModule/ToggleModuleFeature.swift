import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class ToggleModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var toggleService: ToggleViewService
    private var stateChipsUpdaters: [ChipsViewService] = []
    private var checkedChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        toggleService = .init(
            viewProperties: .init(
                checkAction: { isOn in print("Toggle is \(isOn)") }
            ),
            style: .init(state: .default)
        )
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        stateChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Default", "Pressed", "Disabled"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.toggleService.update(newState: [.default, .pressed, .disabled][index])
                self.chipsCreationService.updateChipsSelection(for: &self.stateChipsUpdaters, selectedIndex: index)
            }
        )
        
        checkedChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Off", "On"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.toggleService.update(newChecked: [.off, .on][index])
                self.chipsCreationService.updateChipsSelection(for: &self.checkedChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let stateChips = stateChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let checkedChips = checkedChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(toggleService.view)),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(stateChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(checkedChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
