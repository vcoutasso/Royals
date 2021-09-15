//
//  ListOptionsMapInfo.swift
//  Skatable
//
//  Created by Maria Luiza Amaral on 13/09/21.
//

import Foundation

import UIKit

class ListOptionsMapInfoView: UIViewController {
    // MARK: - Overridden methods

    var tableView = UITableView()
    var listOptions: [Option] = []

    // MARK: - Table view data source

    override func viewDidLoad() {
        super.viewDidLoad()
        listOptions = fetchData()
        configureTableView()
        setupHierarchy()
        setupConstraints()
    }

    func configureTableView() {
        setTableViewDelegates()
        tableView.register(OptionMapInfoCell.self, forCellReuseIdentifier: OptionMapInfoCell.cellId)
        tableView.rowHeight = 56
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
        view.addSubview(tableView)
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let topHeaderOffset: CGFloat = 30
        static let leadingOffset: CGFloat = 20
    }
}

extension ListOptionsMapInfoView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionMapInfoCell.cellId,
                                                 for: indexPath) as! OptionMapInfoCell
        let option = listOptions[indexPath.row]
        cell.set(option: option)
        return cell
    }
}

extension ListOptionsMapInfoView {
    func fetchData() -> [Option] {
        let option1 = Option(nameButton: "Ver feed", icon: UIImage(systemName: Strings.Names.Icons.houseCircle)!)
        let option2 = Option(nameButton: "Adicionar aos favoritos",
                             icon: UIImage(systemName: Strings.Names.Icons.starCircle)!)
        let option3 = Option(nameButton: "Avaliação do Pico", icon: UIImage(asset: Assets.Images.spotCircle)!)
        let option4 = Option(nameButton: "Reportar Problema",
                             icon: UIImage(systemName: Strings.Names.Icons.exclamationMark)!)
        let option5 = Option(nameButton: "Descrição do Stopper", icon: UIImage(systemName: Strings.Names.Icons.xMark)!)
        let option6 = Option(nameButton: "Reportar Problema",
                             icon: UIImage(systemName: Strings.Names.Icons.exclamationMark)!)

        return [option1, option2, option3, option4, option5, option6]
    }
}

#if DEBUG
    import SwiftUI
    struct ListOptionsMapInfoViewPreview: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12")
                .preferredColorScheme(.dark)
        }

        struct ContentView: UIViewControllerRepresentable {
            func makeUIViewController(context: Context) -> UIViewController {
                return ListOptionsMapInfoView()
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        }
    }
#endif
