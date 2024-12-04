import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class StepperModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var stepperService: StepperViewService
    private var countUpdaters: [ChipsViewService] = []
    private var selectedUpdates: [ChipsViewService] = []
    private var currentCount: Int = 3
  
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        stepperService = .init(
            itemsServices: [
                .init(style: .init(state: .current)),
                .init(style: .init(state: .current)),
                .init(style: .init(state: .current))
            ],
            style: .init()
        )
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
    
    override func createUpdaters() {
        countUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["3", "4", "5", "6", "7", "8"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.currentCount = [3, 4, 5, 6, 7, 8][index]
                self.stepperService.update(
                    newItemsServices: self.createStepperItemServices(count: self.currentCount)
                )
                self.chipsCreationService.updateChipsSelection(for: &self.countUpdaters, selectedIndex: index)
            }
        )
        
        let chipTitles = Array(1...8).map(\.description)
        selectedUpdates = chipsCreationService.createChipsUpdaters(
            chipTitles: chipTitles,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                var selectedIndex = Array(1...8)[index] - 1
                if selectedIndex > self.currentCount - 1 {
                    selectedIndex = self.currentCount - 1
                }
                self.stepperService.update(newSelectedIndex: selectedIndex)
                self.chipsCreationService.updateChipsSelection(for: &self.selectedUpdates, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let countChips = countUpdaters.map { updater -> (ChipsView) in updater.view }
        let selectedChips = selectedUpdates.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                center: .atom(.view(stepperService.view)),
                centralBlockAlignment: .fill,
                margings: .init(),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(countChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(selectedChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
    
    // MARK: - Private methods
    
    private func createStepperItemServices(count: Int) -> [StepperItemViewService] {
        var services = [StepperItemViewService]()
        for _ in 0..<count {
            services.append(
                .init(style: .init(state: .current))
            )
        }
        
        return services
    }
}
