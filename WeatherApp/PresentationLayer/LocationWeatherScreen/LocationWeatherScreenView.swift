//
//  LocationWeatherScreenView.swift
//  WeatherApp
//
//  Created by Лаванда on 22.03.2024.
//

import UIKit

protocol LocationWeatherScreenViewProtocol: AnyObject {
    func setup(weather: LocationWeatherModel)
}

final class LocationWeatherScreenView: UIView {
    
    private var weather: LocationWeatherModel?
    private let baseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1")
        return imageView
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        return label
    }()

    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60, weight: .light)
        return label
    }()
    
    private lazy var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var minMaxTemperatureLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private var pressureBox = BoxView(title: "Давление")
    private var humidityBox = BoxView(title: "Влажность")
    private var windSpeedBox = BoxView(title: "Скорость ветра")
    
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
        fiveDaysWeatherTableView.register(WeatherViewCell.self, forCellReuseIdentifier: "Cell")
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
    func setup(weather: LocationWeatherModel) {
        self.weather = weather
        
        DispatchQueue.main.async {
            self.fiveDaysWeatherTableView.reloadData()
            self.cityLabel.text = weather.city
        }
        
        if let max = weather.weathers.first?.maxTemp, let min = weather.weathers.first?.minTemp {
            DispatchQueue.main.async {
                self.minMaxTemperatureLabel.text = "Макс: \(max)°, мин: \(min)°"
            }
        }
        
        if let temp = weather.currentTemp {
            DispatchQueue.main.async {
                self.temperatureLabel.text = "\(temp)°"
            }
        }
        
        if let description = weather.description {
            DispatchQueue.main.async {
                self.weatherDescriptionLabel.text = description.description.description
                print(description.description.description)
            }
        }
        
        if let humidity = weather.humidity {
            humidityBox.setup(text: "\(humidity) %")
        }
        
        if let pressure = weather.pressure {
            pressureBox.setup(text: "\(pressure) ГПа")
        }
        
        if let windSpeed = weather.windSpeed {
            windSpeedBox.setup(text: "\(windSpeed) м/с")
        }
    }
}

extension LocationWeatherScreenView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? WeatherViewCell
        if let weather = weather?.weathers[indexPath.row] {
            cell?.set(model: weather)
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Прогноз на 5 дней"
    }
}
