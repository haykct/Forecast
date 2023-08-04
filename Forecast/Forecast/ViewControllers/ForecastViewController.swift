//
//  ForecastViewController.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import UIKit
import Combine

class ForecastViewController: UIViewController {
    //MARK: Private properties
    private let forecastCellID = "forecastCell"
    private let forecastSectionHeaderID = "forecastSectionHeader"
    private let viewModel: ForecastViewModel
    private var cancellable: AnyCancellable?

    //MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!

    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        registerReusableElements()
        setupBindings()
        requestData()
        setupNavigationBar()
    }

    //MARK: Initializers
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:)` to initialize an `ForecastViewController` instance.")
    }

    init?(coder: NSCoder, viewModel: ForecastViewModel) {
        self.viewModel = viewModel

        super.init(coder: coder)
    }

    //MARK: Private methods
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        let Inter = Constants.Fonts.Inter.self

        navigationItem.title = "Forecast"
        navigationController?.navigationBar.prefersLargeTitles = true
        appearance.titleTextAttributes = [.font: UIFont(name: Inter.bold, size: 20) as Any]
        appearance.largeTitleTextAttributes = [.font: UIFont(name: Inter.bold, size: 40) as Any]
        navigationController?.navigationBar.standardAppearance = appearance
    }

    private func setupBindings() {
        cancellable = viewModel.viewData
            .sink { _ in
                //Handle error
            } receiveValue: { [unowned self] forecasts in
                tableView.reloadData()
            }
    }

    private func requestData() {
        viewModel.requestLocationAndNetworkData()
    }

    private func registerReusableElements() {
        let forecastCellNib = UINib(nibName: "ForecastTableViewCell", bundle: nil)
        let sectionHeaderNib = UINib(nibName: "ForecastSectionHeaderView", bundle: nil)

        tableView.register(forecastCellNib, forCellReuseIdentifier: forecastCellID)
        tableView.register(sectionHeaderNib, forHeaderFooterViewReuseIdentifier: forecastSectionHeaderID)
    }

}

//MARK: UITableViewDataSource
extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: forecastCellID,
                                                      for: indexPath) as! ForecastTableViewCell
        let cellData = viewModel.viewData.value[indexPath.section][indexPath.row]

        cell.setupCell(with: cellData, row: indexPath.row)

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.viewData.value.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.viewData.value[section].count
    }
}

//MARK: UITableViewDelegate
extension ForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = tableView
            .dequeueReusableHeaderFooterView(withIdentifier: forecastSectionHeaderID) as! ForecastSectionHeaderView

        let sectionData = viewModel.viewData.value[section][0]

        sectionHeader.setupSectionHeader(with: sectionData, section: section)

        return sectionHeader
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        56
    }
}
