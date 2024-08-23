import UIKit
import DesignSystem
import ArchitectureTableView

struct BadgeSectionModelService {

    func createSections(from rows: [DSRowModel],
                        height: CGFloat? = nil,
                        cellBackgroundColor: UIColor = .white) -> [SectionModel] {
        return rows.map { row in
            let cell = DSCreationRowsViewService().createViewRowWithBlocks(
                leading: row.leading,
                center: row.center,
                trailing: row.trailing,
                centralBlockAlignment: row.centralBlockAlignment
            )
            let cellModel = CellModel(
                view: cell,
                selectionStyle: .none,
                height: height,
                didTap: nil,
                backgroundColor: cellBackgroundColor
            )
            return SectionModel(cells: [cellModel])
        }
    }
}
