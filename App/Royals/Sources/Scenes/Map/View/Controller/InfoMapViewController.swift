//
//  InfoMapViewController.swift
//  Royals
//
//  Created by Maria Luiza Amaral on 08/09/21.
//

import UIKit

final class InfoMapViewController: UIViewController {
    // MARK: - Private variables

    private weak var optionDelegate: LocationOptionDelegate?

    private var type: MapPinType

    // TODO: Review image handling
    private lazy var spotInfo: SpotInfoMapView = {
        .init(type: type,
              title: "Ambiental",
              distance: "150 m",
              rating: 4.5,
              descriptionStopper: "Skate stopper causado por reformas no local, que atrapalham a possibilidade de skatar no espaço.Skate stopper causado por reformas no local",
              quantityRating: 4,
              address: "Rua Sei Lá Meu, s/n Bairro Alto da Quinze, Curitiba - PR",
              images: [
                  UIImage(asset: Assets.Images.picoAmbiental)!,
                  UIImage(asset: Assets.Images.picoAmbiental)!,
                  UIImage(asset: Assets.Images.picoAmbiental)!,
              ], action: buttonOption)
    }()

    // MARK: - Public methods

    init(type: MapPinType) {
        self.type = type

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        view.addSubview(spotInfo)
    }

    private func setupConstraints() {
        spotInfo.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        view.backgroundColor = Assets.Colors.darkSystemGray6.color
    }

    func buttonOption(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            let alert = UIAlertController(title: "Favoritado",
                                          message: "Ambiental foi adicionado aos seus Picos favoritos",
                                          preferredStyle: UIAlertController.Style.alert)

            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))

            present(alert, animated: true, completion: nil)

        case 2:
            optionDelegate?.sendValue(uid: "", type: .rating)
            dismiss(animated: true, completion: nil)

        default:
            print("quero mimi")
        }
    }

    private enum LayoutMetrics {
        static let topCarosel: CGFloat = 28
        static let topTable: CGFloat = 510
        static let leadingHorizontal: CGFloat = 15
        static let topSeparator: CGFloat = 23
        static let bottomSeparator: CGFloat = -26
        static let topHeaderOffset: CGFloat = 30
        static let leadingOffset: CGFloat = 20
        static let generalTraining: CGFloat = -15
        static let heightTableRow: CGFloat = 50
        static let heightTable: CGFloat = heightTableRow * 4
    }
}
