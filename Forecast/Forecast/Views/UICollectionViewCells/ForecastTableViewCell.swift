//
//  ForecastTableViewCell.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 04.08.23.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {
    //MARK: Outlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!

    //MARK: Lifecycle methods
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        setupCell()
    }

    //MARK: Private methods
    func setupCell(with data: ForecastViewData, indexPath: IndexPath) {
        var data = data

        timeLabel.text = (indexPath.section == 0 && indexPath.row == 0) ? "now".localized : data.upcomingTime
        descriptionLabel.text = data.condition
        iconImageView.image = UIImage(named: data.icon) ?? UIImage(named: data.icon.filter { $0.isNumber })
        temperatureLabel.text = data.temperature
    }

    //MARK: Private methods
    private func setupCell() {
        containerView.layer.cornerRadius = 16
        iconImageView.layer.cornerRadius = 24
    }
}
