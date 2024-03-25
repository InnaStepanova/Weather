//
//  LocationWeatherScreenView.swift
//  WeatherApp
//
//  Created by Лаванда on 22.03.2024.
//

import UIKit

protocol LocationWeatherScreenViewProtocol: AnyObject {
    func setup(weather: CityWeatherViewModel)
}

final class LocationWeatherScreenView: UIView {
    
    private var weather: CityWeatherViewModel?
    private lazy var baseImageView: UIImageView = {
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
    
    private lazy var pressureBox = BoxView(title: "Давление")
    private lazy var humidityBox = BoxView(title: "Влажность")
    private lazy var windSpeedBox = BoxView(title: "Скорость ветра")
    private lazy var fiveDaysWeatherTableView = UITableView()
    private lazy var activityIndicator = UIActivityIndicatorView()
    
    private lazy var boxStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        commonInit()
        hideAllView()
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
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        
        addSubview(baseImageView)
        baseImageView.addSubview(stackView)
        baseImageView.addSubview(fiveDaysWeatherTableView)
        baseImageView.addSubview(activityIndicator)
        
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
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
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
            fiveDaysWeatherTableView.bottomAnchor.constraint(equalTo: baseImageView.bottomAnchor, constant: -16),
            activityIndicator.centerXAnchor.constraint(equalTo: baseImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: baseImageView.centerYAnchor)
        ])
    }
    func setup(weather: CityWeatherViewModel) {
        self.weather = weather
        
        DispatchQueue.main.async {
            self.fiveDaysWeatherTableView.reloadData()
            self.cityLabel.text = weather.city
            self.temperatureLabel.text = "\(weather.temperature)°"
            self.weatherDescriptionLabel.text = weather.description
            self.humidityBox.setup(text: "\(weather.humidity) %")
            self.pressureBox.setup(text: "\(weather.pressure) ГПа")
            self.windSpeedBox.setup(text: "\(weather.windSpeed) м/с")
            self.minMaxTemperatureLabel.text = "Макс: \(weather.weather.first?.maxTemp ?? 0)°, мин: \(weather.weather.first?.minTemp ?? 0)°"
        }
        showAllView()
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func hideAllView() {
        DispatchQueue.main.async { [weak self] in
            self?.boxStackView.isHidden = true
            self?.fiveDaysWeatherTableView.isHidden = true
        }
    }
    
    func showAllView() {
        DispatchQueue.main.async { [weak self] in
            self?.boxStackView.isHidden = false
            self?.fiveDaysWeatherTableView.isHidden = false
        }
    }
}

extension LocationWeatherScreenView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weather?.weather.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? WeatherViewCell
        if let weather = weather?.weather[indexPath.row] {
            cell?.set(model: weather)
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Прогноз на 5 дней"
    }
}
