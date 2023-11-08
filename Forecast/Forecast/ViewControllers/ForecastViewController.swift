//
//  ForecastViewController.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import Combine
import UIKit

class ForecastViewController: UIViewController {
    // MARK: Private properties

    private let forecastCellID = "forecastCell"
    private let forecastSectionHeaderID = "forecastSectionHeader"
    private let viewModel: ForecastViewModel
    private var cancellable: AnyCancellable?
    private var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    // MARK: Outlets

    @IBOutlet private var tableView: UITableView!

    // MARK: Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSpinner()
        registerReusableElements()
        setupBindings()
        requestData()
        setupNavigationBar()
    }

    // MARK: Initializers

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("Use `init(coder:)` to initialize an `ForecastViewController` instance.")
    }

    init?(coder: NSCoder, viewModel: ForecastViewModel) {
        self.viewModel = viewModel

        super.init(coder: coder)
    }

    // MARK: Private methods

    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()

        navigationItem.title = LocalizationKeys.forecast
        navigationController?.navigationBar.prefersLargeTitles = true
        appearance.titleTextAttributes = [.font: UIFont.custom(name: Fonts.Inter.bold, size: 20)]
        appearance.largeTitleTextAttributes = [.font: UIFont.custom(name: Fonts.Inter.bold, size: 20)]
        navigationController?.navigationBar.standardAppearance = appearance
    }

    private func setupBindings() {
        cancellable = viewModel.$viewData
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                // Handle errors
                spinner.stopAnimating()
            } receiveValue: { [unowned self] _ in
                tableView.reloadData()
                spinner.stopAnimating()
            }
    }

    private func setupSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func requestData() {
        spinner.startAnimating()
        viewModel.requestLocationAndNetworkData()
    }

    private func registerReusableElements() {
        let forecastCellNib = UINib(nibName: "ForecastTableViewCell", bundle: nil)
        let sectionHeaderNib = UINib(nibName: "ForecastSectionHeaderView", bundle: nil)

        tableView.register(forecastCellNib, forCellReuseIdentifier: forecastCellID)
        tableView.register(sectionHeaderNib, forHeaderFooterViewReuseIdentifier: forecastSectionHeaderID)
    }
}

// MARK: UITableViewDataSource

extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: forecastCellID,
                                                 for: indexPath) as? ForecastTableViewCell
        let cellData = viewModel.viewData[indexPath.section][indexPath.row]

        cell?.setupCell(with: cellData, indexPath: indexPath)

        return cell ?? UITableViewCell()
    }

    func numberOfSections(in _: UITableView) -> Int {
        viewModel.viewData.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.viewData[section].count
    }
}

// MARK: UITableViewDelegate

extension ForecastViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = tableView
            .dequeueReusableHeaderFooterView(withIdentifier: forecastSectionHeaderID) as? ForecastSectionHeaderView

        let sectionData = viewModel.viewData[section][0]

        sectionHeader?.setupSectionHeader(with: sectionData, section: section)

        return sectionHeader
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        56
    }
}
