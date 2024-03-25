//
//  WeatherViewCell.swift
//  WeatherApp
//
//  Created by Лаванда on 23.03.2024.
//

import UIKit

class WeatherViewCell: UITableViewCell {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor(red: 80.0/255.0, green: 78.0/255.0, blue: 131.0/255.0, alpha: 1.0)
        return imageView
    }()

    let tempLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(model: WeatherViewModel) {
        dateLabel.text = "\(model.date)"
        weatherImageView.image = UIImage(systemName: getConditionName(weatherId: model.descriptionId))
        tempLabel.text = "Макс: \(model.maxTemp)°, мин: \(model.minTemp)°"
    }
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(dateLabel)
        addSubview(weatherImageView)
        addSubview(tempLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            weatherImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            weatherImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            weatherImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120),
            
            tempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            tempLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 180)
        ])
    }
    
    private func getConditionName (weatherId: Int) -> String {
        switch weatherId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }

}
