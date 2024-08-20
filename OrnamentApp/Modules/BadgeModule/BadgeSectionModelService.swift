import DesignSystem
import ArchitectureTableView

struct BadgeSectionModelService {

    func createSections(from rows: [DSRowModel]) -> [SectionModel] {
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
                height: nil,
                didTap: nil
            )
            return SectionModel(cells: [cellModel])
        }
    }
}
