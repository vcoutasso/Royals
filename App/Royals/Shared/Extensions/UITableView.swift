//
//  UITableView.swift
//  Royals
//
//  Created by Vinícius Couto on 06/09/21.
//

import SnapKit
import UIKit

extension UITableView {
    // Adapted from https://stackoverflow.com/a/28102157
    func setAndLayoutTableHeaderView(header: UIView, constraintMaker: (ConstraintMaker) -> Void) {
        tableHeaderView = header

        header.snp.makeConstraints(constraintMaker)
        header.setNeedsLayout()
        header.layoutIfNeeded()

        sectionHeaderHeight = header.frame.height
        tableHeaderView = header
    }
}
