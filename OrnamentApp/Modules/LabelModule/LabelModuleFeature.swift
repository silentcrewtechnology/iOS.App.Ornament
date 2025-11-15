import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class LabelModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var labelService: LabelViewService
    private var variantChipsUpdaters: [ChipsViewService] = []
    private var statusCardUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        labelService = .init(
            viewProperties: .init(text: .init(string: "Label")),
            style: .init(variant: .default(customColor: nil))
        )
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        variantChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: [
                "Default", "Disabled", "Row index", "Row amount", "Row status card",
                "Row custom title", "Row custom subtitle"
            ],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.labelService.update(
                    newVariant: [
                        .default(customColor: nil),
                        .disabled(customColor: nil),
                        .rowIndex,
                        .rowAmount,
                        .rowStatusCard(statusCardVariant: .blocked),
                        .rowCustomTitle(customColor: nil, recognizer: nil),
                        .rowCustomSubtitle(customColor: nil)
                    ][index]
                )
                self.chipsCreationService.updateChipsSelection(for: &self.variantChipsUpdaters, selectedIndex: index)
            }
        )
        
        statusCardUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Blocked", "Rerelease", "Expires", "Readiness"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.labelService.update(
                    newVariant: .rowStatusCard(
                        statusCardVariant: [
                            .blocked,
                            .rerelease,
                            .expires,
                            .readiness
                        ][index]
                    )
                )
                self.chipsCreationService.updateChipsSelection(for: &self.statusCardUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let variantChips = variantChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let statucCardChips = statusCardUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                center: .atom(.view(labelService.view)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(variantChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(statucCardChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
