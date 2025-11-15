import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components
import ImagesService
import Kingfisher

final class StoriesModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var mainTileViewService: StoryTileViewService
    private var stateChipsUpdaters: [ChipsViewService] = []
    private lazy var tilesViewService: StoryTileCollectionViewService = .init(
        tileServices: [
            .init(viewProperties: .init(title: "Story #1".attributed)),
            .init(viewProperties: .init(title: "Story #2".attributed)),
            .init(viewProperties: .init(title: "Story #3".attributed)),
            .init(viewProperties: .init(title: "Story #4".attributed)),
            .init(viewProperties: .init(title: "Story #5".attributed)),
        ]
    )
    private lazy var buttonViewService: ButtonViewService = .init(
        viewProperties: .init(
            attributedText: "Reset read state".attributed,
            onTap: { [weak self] in
                guard let self else { return }
                tilesViewService.tileServices.forEach {
                    $0.update(newState: .unread)
                }
            }
        ),
        style: .init(size: .small, color: .accent, variant: .primary, state: .default, icon: .with(.ic16Refresh))
    )
    
    // MARK: - Init
    
    init() {
        mainTileViewService = .init(viewProperties: .init(title: "Multiline story long text".attributed))
        super.init()
        setupTileServices()
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        stateChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Unread", "Read"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                mainTileViewService.update(newState: [.unread, .read][index])
                chipsCreationService.updateChipsSelection(for: &stateChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let stateChips = stateChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(mainTileViewService.view)),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(stateChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .atom(.view(tilesViewService.view)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .atom(.view(buttonViewService.view)),
                cellSelectionStyle: .none
            ),
        ]
        
        return rowModels
    }
    
    private func setupTileServices() {
        for tileService in tilesViewService.tileServices {
            tileService.update(newOnTap: { [weak self, weak tileService] in
                guard let self, let tileService else { return }
                handleStoryTapped(tileService: tileService)
            })
        }
        
        let urls: [URL] = [
            URL(string: "https://life.akbars.ru/upload/iblock/97c/30vuhbt1c87sazwy98wykzq9sjtdtq3o.png")!,
            URL(string: "https://life.akbars.ru")!,
            URL(string: "https://life.akbars.ru/upload/iblock/f35/g2unhb62eok00nw7ndneli4z9fauu3hn.png")!,
            URL(string: "https://life.akbars.ru")!,
            URL(string: "https://life.akbars.ru/upload/iblock/bb7/r90sbo03xjbuhgf2tft62xzfvd6eldme.png")!,
        ]
        for (url, tileService) in zip(urls, tilesViewService.tileServices) {
            KingfisherManager.shared.retrieveImage(with: url) { result in
                guard case .success(let result) = result else { return }
                tileService.update(newImage: result.image)
            }
        }
    }
    
    private func handleStoryTapped(tileService: StoryTileViewService) {
        print("Story tapped")
        let alert = UIAlertController(
            title: "Confirmation",
            message: "Did you read this story fully?",
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "No", style: .default))
        alert.addAction(.init(
            title: "Yes",
            style: .default,
            handler: { _ in tileService.update(newState: .read) }
        ))
        alert.preferredAction = alert.actions.last
        tableViewVCBuilder.view.present(alert, animated: true)
    }
}
