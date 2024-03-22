//
//  LocationWeatherScreenView.swift
//  WeatherApp
//
//  Created by Лаванда on 22.03.2024.
//

import UIKit

final class LocationWeatherScreenView: UIView {
    
    private let baseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1")
        return imageView
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Москва"
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        return label
    }()

    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "22°"
        label.font = UIFont.systemFont(ofSize: 60, weight: .light)
        return label
    }()
    
    private lazy var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Облачно"
        return label
    }()
    
    private lazy var minMaxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Макс: 5°, мин: -3°"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private var pressureBox = BoxView(title: "Давление", value: "755 мм.рт.ст")
    private var humidityBox = BoxView(title: "Влажность", value: "760 МПа")
    private var windSpeedBox = BoxView(title: "Скорость ветра", value: "3-5 м/с")
    
    private lazy var boxStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let fiveDaysWeatherTableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit() {
        fiveDaysWeatherTableView.delegate = self
        fiveDaysWeatherTableView.dataSource = self
        fiveDaysWeatherTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        fiveDaysWeatherTableView.layer.cornerRadius = 10
        fiveDaysWeatherTableView.rowHeight = 46
        fiveDaysWeatherTableView.backgroundColor = .white.withAlphaComponent(0.3)
        fiveDaysWeatherTableView.isScrollEnabled = false
        
        addSubview(baseImageView)
        baseImageView.addSubview(stackView)
        baseImageView.addSubview(fiveDaysWeatherTableView)
        
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(weatherDescriptionLabel)
        stackView.addArrangedSubview(minMaxTemperatureLabel)
        stackView.addArrangedSubview(boxStackView)
        boxStackView.addArrangedSubview(pressureBox)
        boxStackView.addArrangedSubview(humidityBox)
        boxStackView.addArrangedSubview(windSpeedBox)
        
        baseImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        fiveDaysWeatherTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            baseImageView.topAnchor.constraint(equalTo: topAnchor),
            baseImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            baseImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            baseImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: baseImageView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            fiveDaysWeatherTableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            fiveDaysWeatherTableView.leadingAnchor.constraint(equalTo: baseImageView.leadingAnchor, constant: 16),
            fiveDaysWeatherTableView.trailingAnchor.constraint(equalTo: baseImageView.trailingAnchor, constant: -16),
            fiveDaysWeatherTableView.heightAnchor.constraint(equalToConstant: 280),
            fiveDaysWeatherTableView.bottomAnchor.constraint(equalTo: baseImageView.bottomAnchor, constant: -16)
        ])
    }
}

extension LocationWeatherScreenView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        var content = cell.defaultContentConfiguration()
        content.text = "Погода"
        cell.contentConfiguration = content
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Прогноз на 5 дней"
    }
    
}


//func getConditionName (weatherId: Int) -> String {
//    switch weatherId {
//    case 200...232:
//        return "cloud.bolt"
//    case 300...321:
//        return "cloud.drizzle"
//    case 500...531:
//        return "cloud.rain"
//    case 600...622:
//        return "cloud.snow"
//    case 701...781:
//        return "cloud.fog"
//    case 800:
//        return "sun.max"
//    case 801...804:
//        return "cloud.bolt"
//    default:
//        return "cloud"
//    }
//}
