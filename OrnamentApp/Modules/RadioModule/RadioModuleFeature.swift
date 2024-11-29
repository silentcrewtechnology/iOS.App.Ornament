import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class RadioModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var radioService: RadioViewService
    private var stateChipsUpdaters: [ChipsViewService] = []
    private var selectionChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        radioService = .init(
            viewProperties: .init(
                onTap: { _ in print("Radio tapped!") }
            ),
            style: .init(state: .default, selection: .off)
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
                self.radioService.update(newState: [.default, .pressed, .disabled][index])
                self.chipsCreationService.updateChipsSelection(for: &self.stateChipsUpdaters, selectedIndex: index)
            }
        )
        
        selectionChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Off", "On"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.radioService.update(newSelection: [.off, .on][index])
                self.chipsCreationService.updateChipsSelection(for: &self.selectionChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let stateChips = stateChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let selectionChips = selectionChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(radioService.view)),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(stateChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(selectionChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
