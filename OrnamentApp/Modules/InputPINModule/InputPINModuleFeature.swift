import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class InputPINModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var inputPINService: InputPinViewService
    private var stateChipsUpdaters: [ChipsViewService] = []
    private var countChipsUpdaters: [ChipsViewService] = []
    private var currentRange: Int = .zero
    private var currentState: InputPinItemViewStyle.Variant = .default
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        inputPINService = .init(
            itemServices: [
                .init(style: .init(variant: .default)),
                .init(style: .init(variant: .default)),
                .init(style: .init(variant: .default)),
                .init(style: .init(variant: .default))
            ]
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
            chipTitles: ["Default", "Filled", "Success", "Error"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                currentState = [.default, .filled, .success, .error][index]
                self.inputPINService.update(state: currentState, range: 0..<currentRange)
                self.chipsCreationService.updateChipsSelection(for: &self.stateChipsUpdaters, selectedIndex: index)
            }
        )
        
        countChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["0", "1", "2", "3", "4"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                currentRange = [0, 1, 2, 3, 4][index]
                self.inputPINService.update(state: self.currentState, range: 0..<currentRange)
                self.chipsCreationService.updateChipsSelection(for: &self.countChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let stateChips = stateChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let countChips = countChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                center: .atom(.view(inputPINService.view)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(stateChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(countChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
