import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class CheckboxModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var checkboxService: CheckboxViewService
    private var selectionChipsUpdaters: [ChipsViewService] = []
    private var stateChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        checkboxService = .init(
            viewProperties: .init(
                onTap: { _ in print("Checkbox tapped!") }
            ),
            style: .init(selection: .default, state: .default)
        )
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        selectionChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Default", "Checked"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.checkboxService.update(newSelection: [.default, .checked][index])
                self.chipsCreationService.updateChipsSelection(for: &self.selectionChipsUpdaters, selectedIndex: index)
            }
        )
        
        stateChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Default", "Pressed", "Disabled"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.checkboxService.update(newState: [.default, .pressed, .disabled][index])
                self.chipsCreationService.updateChipsSelection(for: &self.stateChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let selectionChips = selectionChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let stateChips = stateChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(checkboxService.view)),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(selectionChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(stateChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
