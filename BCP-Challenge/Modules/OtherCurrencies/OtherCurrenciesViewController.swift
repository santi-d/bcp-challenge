//
//  OtherCurrenciesViewController.swift
//  BCP-Challenge
//
//  Created by Santi D on 10/04/22.
//

import UIKit

protocol OtherCurrenciesViewDelegate: AnyObject {
    func onSelectNewPairCurrency(_ pairCurrency: TuplePairCurrency)
}

class OtherCurrenciesViewController: UIViewController {
    @IBOutlet weak var currenciesTableView: UITableView!

    private let registeredCellIdentifier = "OtherCurrenciesTableViewCell"
    private var presenter: OtherCurrenciesPresenterProtocol?

    var selectedPairCurrency: PairCurrency?
    weak var delegate: OtherCurrenciesViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupBehaviors()
    }

    // MARK: -- public func

    func setupViewController(selectedPairCurrency: PairCurrency, interactor: OtherCurrencyInteractorProtocol = OtherCurrencyInteractor(), delegate: OtherCurrenciesViewDelegate) {
        self.presenter = OtherCurrenciesPresenter(interactor: interactor)
        self.delegate = delegate
        self.selectedPairCurrency = selectedPairCurrency
        self.presenter?.refreshCurrencies(for: selectedPairCurrency.destination)
    }

    // MARK: -- private func

    private func setupView() {
        // tableView
        currenciesTableView.showsHorizontalScrollIndicator = false
        currenciesTableView.showsVerticalScrollIndicator = false
        currenciesTableView.separatorStyle = .none
    }

    private func setupBehaviors() {
        // tableView
        currenciesTableView.register(UINib(nibName: registeredCellIdentifier, bundle: nil), forCellReuseIdentifier: registeredCellIdentifier)

        currenciesTableView.delegate = self
        currenciesTableView.dataSource = self
    }
}

extension OtherCurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.pairCurrencies.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: registeredCellIdentifier, for: indexPath) as? OtherCurrenciesTableViewCell,
              let viewModel = presenter?.pairCurrencies[indexPath.row] else {
            return UITableViewCell()
        }

        cell.setupCell(pairCurrency: viewModel)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        82
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let destinationPairCurrency = presenter?.pairCurrencies[indexPath.row],
           let originPairCurrency = presenter?.getPairs(originViewModel: destinationPairCurrency) {
            delegate?.onSelectNewPairCurrency((firstPairCurrency: originPairCurrency, secondPairCurrency: destinationPairCurrency))
        }
        
        navigationController?.popViewController(animated: true)
    }
}
