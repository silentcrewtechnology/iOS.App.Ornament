import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class TileModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var tileService: TileViewService
    private var backgroundUpdaters: [ChipsViewService] = []
    private var sizeUpdaters: [ChipsViewService] = []
    private var currentSize: TileViewStyle.Size = .s
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        tileService = .init(
            viewProperties: .init(
                text: .init(string: "Label"),
                onTap: { print("Tile tapped!") }
            ),
            style: .init(background: .primary, size: .s)
        )
        tileService.imageViewService.update(newType: .icon(.ic24UserFilled))
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
    
    override func createUpdaters() {
        backgroundUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Primary", "Main", "Transparency", "Square"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.tableViewBuilder.view.beginUpdates()
                self.tileService.update(
                    newBackground: [
                        .primary,
                        .main,
                        .transparency,
                        .square(.init())
                    ][index],
                    newSize: [
                        self.currentSize,
                        self.currentSize,
                        .m,
                        .m
                    ][index]
                )
                self.chipsCreationService.updateChipsSelection(for: &self.backgroundUpdaters, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )
        
        sizeUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["S", "M"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.tableViewBuilder.view.beginUpdates()
                self.currentSize = [.s, .m][index]
                self.tileService.update(newSize: self.currentSize, newText: ["Label".attributed, "LabelLabelLabelLabel".attributed][index])
                self.chipsCreationService.updateChipsSelection(for: &self.sizeUpdaters, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let backgroundChips = backgroundUpdaters.map { updater -> (ChipsView) in updater.view }
        let sizeChips = sizeUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(tileService.view)),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(backgroundChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(sizeChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
