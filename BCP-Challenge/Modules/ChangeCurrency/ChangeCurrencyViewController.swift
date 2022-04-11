//
//  ChangeCurrencyViewController.swift
//  BCP-Challenge
//
//  Created by Santi D on 10/04/22.
//

import UIKit

protocol ChangeCurrencyDelegate: AnyObject {
    func presentOtherCurrenciesScreen(withDataFromIndex selectedIndex: Int)
    func onEnteredValue(value: Double, onCellRow: Int)
}

class ChangeCurrencyViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var detailCurrencyChangeLabel: UILabel!
    @IBOutlet private weak var startOperationButton: UIButton!
    @IBOutlet private weak var spinContainerView: UIView!

    private let registeredCellIdentifier = "CurrencyChangeTableViewCell"
    
    private var detailCurrencyChangeMessage: String = "" {
        didSet {
            detailCurrencyChangeLabel.text = detailCurrencyChangeMessage
        }
    }

    var presenter: ChangeCurrencyPresenterProtocol? = ChangeCurrencyPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupBehaviors()
    }

    // MARK: -- private funcs

    private func setupView() {
        // spinContainerView
        spinContainerView.layer.cornerRadius = spinContainerView.frame.height / 2.0
        spinContainerView.backgroundColor = .white

        // tableView
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none

        // startOperationButton
        startOperationButton.backgroundColor = .bcpBlue
        startOperationButton.setTitle("Empieza tu operación", for: .normal)
        startOperationButton.setTitleColor(.white, for: .normal)
        startOperationButton.titleLabel?.font = .bcpBold(size: 20.0)
    }

    private func setupBehaviors() {
        // tableView
        tableView.register(UINib(nibName: registeredCellIdentifier, bundle: nil), forCellReuseIdentifier: registeredCellIdentifier)

        tableView.delegate = self
        tableView.dataSource = self

        // spinContainerView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeCurrencies))

        spinContainerView.addGestureRecognizer(tapGesture)

        // startOperationButton
        startOperationButton.addTarget(self, action: #selector(startOperationButtontapped(_:)), for: .touchUpInside)

    }

    @objc private func changeCurrencies() {
        presenter?.reverseCurrencies()
        presenter?.resetValueDataSource()
        tableView.reloadData()
    }

    @objc private func startOperationButtontapped(_ sender: UIButton) {
        presenter?.startOperation()
    }

    // MARK: -- public funcs

    func onFinishFirstLoad() {
        detailCurrencyChangeLabel.text = presenter?.buySellMessage
    }
}

extension ChangeCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        detailCurrencyChangeLabel.text = presenter?.buySellMessage

        guard let cell = tableView.dequeueReusableCell(withIdentifier: registeredCellIdentifier, for: indexPath) as? CurrencyChangeTableViewCell,
              let dataSource = presenter?.dataSource,
              let valueDataSource = presenter?.valueDataSource else {
            return UITableViewCell()
        }

        cell.setupCell(inputValue: valueDataSource[indexPath.row], pairCurrency: dataSource[indexPath.row], index: indexPath.row, delegate: self)

        return cell
    }
}

extension ChangeCurrencyViewController: ChangeCurrencyDelegate {
    func presentOtherCurrenciesScreen(withDataFromIndex selectedIndex: Int) {
        guard let otherCurrenciesViewController = UIStoryboard(name: "OtherCurrencies", bundle: nil).instantiateInitialViewController() as? OtherCurrenciesViewController, let dataSource = presenter?.dataSource else {
            return
        }

        presenter?.selectedCurrencyIndex = selectedIndex

        otherCurrenciesViewController.setupViewController(selectedPairCurrency: dataSource[selectedIndex], interactor: OtherCurrencyInteractor(), delegate: self)
        navigationController?.pushViewController(otherCurrenciesViewController, animated: true)
    }

    func onEnteredValue(value: Double, onCellRow: Int) {
        let otherCellIndex = onCellRow == 0 ? 1 : 0
        if let dataSource = presenter?.dataSource {
            let pairCurrency = dataSource[otherCellIndex]

            presenter?.valueDataSource = ["\(value)", "\(value * pairCurrency.changeValue)"]
            tableView.reloadData()
        }
    }
}

extension ChangeCurrencyViewController: OtherCurrenciesViewDelegate {
    func onSelectNewPairCurrency(_ pairCurrency: TuplePairCurrency) {
        presenter?.updateDataSource(element: pairCurrency)
        detailCurrencyChangeLabel.text = presenter?.buySellMessage
        presenter?.resetValueDataSource()
        tableView.reloadData()
    }
}
