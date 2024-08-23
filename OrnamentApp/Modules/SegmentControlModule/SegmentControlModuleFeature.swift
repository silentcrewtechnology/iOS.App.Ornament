import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class SegmentControlModuleFeature: NSObject, FeatureCoordinatorProtocol {
    
    // MARK: Properties
    
    var runNewFlow: ((Any) -> Void)?
    
    // MARK: Private properties
    
    private var tableViewVCBuilder: TableViewVCBuilder?
    private var tableViewBuilder: TableViewBuilder?
    private var navigationBarStyle: NavigationBarStyle?
    
    private var tableDataSource: TableDataSource
    private var tableDelegate: TableDelegate
    
    private var segmentControlService: SegmentControlViewService
    private var backgroundChipsServices: [ChipsViewService] = []
    private var sizeChipsServices: [ChipsViewService] = []
    private var countChipsServices: [ChipsViewService] = []
    
    private var chipsCreationService: ChipsCreationService
    private var sectionModelService: BadgeSectionModelService
    private var navigationBarVP = NavigationBar.ViewProperties()
    
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
        
        // MARK: segmentControl
        
        let firstSegmentItem = SegmentItemView.ViewProperties(
            text: "first".attributed,
            onItemTap: { isSelected in
                print("first \(isSelected)")
            })
        let secondSegmentItem = SegmentItemView.ViewProperties(
            text: "second".attributed,
            onItemTap: { isSelected in
                print("second \(isSelected)")
            })
        let thirdSegmentItem = SegmentItemView.ViewProperties(
            text: "third".attributed,
            onItemTap: { isSelected in
                print("third \(isSelected)")
        })
        
        segmentControlService = SegmentControlViewService(
            itemsProperties: [firstSegmentItem, secondSegmentItem, thirdSegmentItem]
        )
        
        super.init()
        self.setupTableViewBuilder()
        self.setupNavigation(screenTitle: screenTitle, backAction: backAction)
        self.setupTableViewVCBuilder()
    }
    
    // MARK: Methods
    
    func runFlow(data: Any?) -> (any Architecture.BuilderProtocol)? {
        setCell()
        return tableViewVCBuilder
    }
    
    // MARK: Private methods
    
    private func setCell() {
        
        createUpdaters()
        
        let segmentControlView = segmentControlService.view
        let controlContainer = UIView()
        controlContainer.addSubview(segmentControlView)
        segmentControlView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
            $0.top.greaterThanOrEqualToSuperview()
        }
        
        let segmentControlCell = CellModel(view: controlContainer,
                                           selectionStyle: .none,
                                           height: 72,
                                           backgroundColor: .lightGray)
        let segmentControlSection = SectionModel(cells: [segmentControlCell])
        
        let chipsCells = createRowModels()
        let chipsSections = sectionModelService.createSections(
            from: chipsCells,
            height: 72,
            cellBackgroundColor: .lightGray
        )
        
        let sections = [segmentControlSection] + chipsSections
        
        tableDelegate.update(with: sections)
        tableDataSource.update(with: sections)
    }
    
    private func createUpdaters() {
        backgroundChipsServices = chipsCreationService.createChipsUpdaters(
            chipTitles: ["primary", "secondary"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.segmentControlService.update(background: [.primary, .secondary][index])
                self.updateChipsSelection(for: &self.backgroundChipsServices, selectedIndex: index)
            }
        )
        
        sizeChipsServices = chipsCreationService.createChipsUpdaters(
            chipTitles: ["small", "large"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.segmentControlService.update(size: [.small, .large][index])
                self.updateChipsSelection(for: &self.sizeChipsServices, selectedIndex: index)
            }
        )
    }
    
    private func createRowModels() -> [DSRowModel] {
                let backgroundChips = backgroundChipsServices.map { updater -> (ChipsView) in updater.view }
                let sizeChips = sizeChipsServices.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            DSRowModel(leading: .molecule(.horizontalChipseViews(backgroundChips))),
            DSRowModel(leading: .molecule(.horizontalChipseViews(sizeChips))),
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

// MARK: Init
extension SegmentControlModuleFeature {
    private func setupTableViewVCBuilder() {
        if let tableView = tableViewBuilder?.view {
            tableViewVCBuilder = .init(with: .init(
                navigationBarViewProperties: navigationBarVP,
                tableView: tableView,
                confirmButtonView: nil
            ))
        }
    }
    
    private func setupTableViewBuilder() {
        tableViewBuilder = .init(with: .init(
            backgroundColor: .lightGray,
            dataSources: self.tableDataSource,
            delegate: self.tableDelegate
        ))
    }
    
    private func setupNavigation(screenTitle: String,
                                 backAction: (() -> Void)?) {
        navigationBarStyle = NavigationBarStyle(
            variant: .basic(
                title: screenTitle,
                subtitle: nil,
                margins: nil
            ),
            color: .primary
        )
        navigationBarStyle?.update(viewProperties: &navigationBarVP, backAction: backAction)
    }
}
