//
//  UITableView.swift
//  BCP-Challenge
//
//  Created by Santi D on 9/04/22.
//

import UIKit

extension UITableView {
    static func getDefault(adjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior = .automatic, contentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.contentInset = contentInset
        tableView.contentInsetAdjustmentBehavior = adjustmentBehavior
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
      return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }

    func scrollToTop(animated: Bool) {
      let indexPath = IndexPath(row: 0, section: 0)
      if self.hasRowAtIndexPath(indexPath: indexPath) {
        DispatchQueue.main.async { [weak self] in
            self?.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
      }
    }

    func restoreBackground() {
        self.backgroundView = nil
    }
}
