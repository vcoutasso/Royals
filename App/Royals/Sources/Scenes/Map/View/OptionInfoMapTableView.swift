//
//  OptionInfoMapTableView.swift
//  Royals
//
//  Created by Maria Luiza Amaral on 15/09/21.
//

import UIKit

// TODO: Fix separator style
class OptionInfoMapTableView: UIView {
    // MARK: - Overridden methods

    var tableView = UITableView()
    var listOptions: [Option] = []
    var action: ((UIButton) -> Void)?

    // MARK: - Table view data source

    init(type: MapPinType, action: @escaping (UIButton) -> Void) {
        super.init(frame: .zero)
        self.action = action
        // passar pelo init o tipo de view que precisa ( as opcoes da table)
        self.listOptions = fetchData(type: type)
        configureTableView()
        setupHierarchy()
        setupConstraints()
    }

    init() {
        super.init(frame: .zero)
        // passar pelo init o tipo de view que precisa ( as opcoes da table)
        configureTableView()
        setupHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureTableView() {
        setTableViewDelegates()
        tableView.register(OptionMapInfoCell.self, forCellReuseIdentifier: OptionMapInfoCell.cellId)
        tableView.rowHeight = LayoutMetrics.heightTableRow
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = Assets.Colors.darkSystemGray5.color
    }

    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupHierarchy() {
        addSubview(tableView)
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let topHeaderOffset: CGFloat = 30
        static let leadingOffset: CGFloat = 20
        static let heightTableRow: CGFloat = 50
    }
}

extension OptionInfoMapTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionMapInfoCell.cellId) as? OptionMapInfoCell
        let option = listOptions[indexPath.row]

        let spotIdentifier: Int = option.type == MapPinType.skateSpot ? 0 : 4
        cell?.set(option: option)
        cell?.action = action
        cell?.button.tag = indexPath.row + spotIdentifier

        return cell!
    }
}

extension OptionInfoMapTableView {
    func fetchData(type: MapPinType) -> [Option] {
        switch type {
        case .skateSpot:
            let option1 = Option(nameButton: "Ver feed", icon: UIImage(systemName: Strings.Names.Icons.houseCircle)!,
                                 type: .skateSpot)
            let option2 = Option(nameButton: "Adicionar aos favoritos",
                                 icon: UIImage(systemName: Strings.Names.Icons.starCircle)!, type: .skateSpot)
            let option3 = Option(nameButton: "Avaliação do Pico",
                                 icon: UIImage(systemName: Strings.Names.Icons.heartCircle)!, type: .skateSpot)
            let option4 = Option(nameButton: "Reportar Problema",
                                 icon: UIImage(systemName: Strings.Names.Icons.exclamationMark)!, type: .skateSpot)

            return [option1, option2, option3, option4]

        case .skateStopper:
            let option5 = Option(nameButton: "Descrição do Stopper",
                                 icon: UIImage(systemName: Strings.Names.Icons.xMark)!, type: .skateStopper)
            let option6 = Option(nameButton: "Reportar Problema",
                                 icon: UIImage(systemName: Strings.Names.Icons.exclamationMark)!, type: .skateStopper)
            return [option5, option6]
        }
    }
}
