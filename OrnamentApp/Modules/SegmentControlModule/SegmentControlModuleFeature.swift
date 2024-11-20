import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class SegmentControlModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var segmentControlService: SegmentControlViewService
    private var backgroundChipsUpdaters: [ChipsViewService] = []
    private var sizeChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        segmentControlService = .init(
            itemsServices: [
                .init(
                    viewProperties: .init(
                        text: .init(string: "Tab1"),
                        onItemTap: { _ in
                            print("Tab1 tapped!")
                        }
                    ),
                    style: .init()
                ),
                .init(
                    viewProperties: .init(
                        text: .init(string: "Tab2"),
                        onItemTap: { _ in
                            print("Tab2 tapped!")
                        }
                    ),
                    style: .init()
                ),
                .init(
                    viewProperties: .init(
                        text: .init(string: "Tab3"),
                        onItemTap: { _ in
                            print("Tab3 tapped!")
                        }
                    ),
                    style: .init()
                ),
                .init(
                    viewProperties: .init(
                        text: .init(string: "Tab4"),
                        onItemTap: { _ in
                            print("Tab4 tapped!")
                        }
                    ),
                    style: .init()
                )
            ],
            style: .init(background: .primary, size: .small)
        )
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        backgroundChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Primary", "Secondary"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.segmentControlService.update(background: [.primary, .secondary][index])
                self.chipsCreationService.updateChipsSelection(
                    for: &self.backgroundChipsUpdaters,
                    selectedIndex: index
                )
            }
        )
        
        sizeChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Small", "Large"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.tableViewBuilder.view.beginUpdates()
                self.segmentControlService.update(size: [.small, .large][index])
                self.chipsCreationService.updateChipsSelection(for: &self.sizeChipsUpdaters, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let backgroundChips = backgroundChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let sizeChips = sizeChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(segmentControlService.view)),
                margings: .init(leading: 16),
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(backgroundChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(sizeChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
