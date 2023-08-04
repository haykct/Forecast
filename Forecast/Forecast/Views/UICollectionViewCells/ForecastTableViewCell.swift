//
//  ForecastTableViewCell.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 04.08.23.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {
    //MARK: Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!

    //MARK: Lifecycle methods
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        setupCell()
    }

    //MARK: Private methods
    func setupCell(with data: ForecastViewData, row: Int) {
        var data = data

        timeLabel.text = row == 0 ? "Now" : data.upcomingTime
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
