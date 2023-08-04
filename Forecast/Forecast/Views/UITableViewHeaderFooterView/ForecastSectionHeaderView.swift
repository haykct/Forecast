//
//  ForecastSectionHeaderView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 04.08.23.
//

import UIKit

final class ForecastSectionHeaderView: UITableViewHeaderFooterView {
    //MARK: Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!

    //MARK: Public methods
    func setupSectionHeader(with data: ForecastViewData, section: Int) {
        var data = data

        dateLabel.text = data.upcomingDate

        switch section {
        case 0:
            dayLabel.text = "Today"
        case 1:
            dayLabel.text = "Tomorrow"
        default:
            dayLabel.text = ""
        }
    }
}