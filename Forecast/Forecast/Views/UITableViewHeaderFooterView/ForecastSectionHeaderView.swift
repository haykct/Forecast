//
//  ForecastSectionHeaderView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 04.08.23.
//

import UIKit

final class ForecastSectionHeaderView: UITableViewHeaderFooterView {
    // MARK: Outlets

    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var dayLabel: UILabel!

    // MARK: Public methods

    func setupSectionHeader(with data: ForecastViewData, section: Int) {
        var data = data

        dateLabel.text = data.upcomingDate

        switch section {
        case 0:
            dayLabel.text = LocalizationKeys.today
        case 1:
            dayLabel.text = "tomorrow".localized
        default:
            dayLabel.text = ""
        }
    }
}
