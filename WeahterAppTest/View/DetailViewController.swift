//
//  DetailViewController.swift
//  WeatherAppTest
//
//  Created by Александр Уткин on 05.08.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var weatherModel: Weather?
    
    let cityNameLabel: UILabel = {
        let cityNameLabel = UILabel()
        cityNameLabel.text = ""
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        cityNameLabel.textAlignment = .center
        cityNameLabel.textColor = .black
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return cityNameLabel
    }()
    
    let conditionLabel: UILabel = {
        let conditionLabel = UILabel()
        conditionLabel.text = ""
        conditionLabel.textAlignment = .center
        conditionLabel.textColor = .black
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return conditionLabel
    }()
    
    let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.text = ""
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .black
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return temperatureLabel
    }()
    
    let pressureValueLabel: UILabel = {
        let pressureValueLabel = UILabel()
        pressureValueLabel.text = ""
        pressureValueLabel.textAlignment = .right
        pressureValueLabel.textColor = .black
        pressureValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return pressureValueLabel
    }()
    
    let windSpeedValueLabel: UILabel = {
        let windSpeedValueLabel = UILabel()
        windSpeedValueLabel.text = ""
        windSpeedValueLabel.textAlignment = .right
        windSpeedValueLabel.textColor = .black
        windSpeedValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return windSpeedValueLabel
    }()
    
    let minTempValueLabel: UILabel = {
        let minTempValueLabel = UILabel()
        minTempValueLabel.text = ""
        minTempValueLabel.textAlignment = .right
        minTempValueLabel.textColor = .black
        minTempValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return minTempValueLabel
    }()
    
    let maxTempValueLabel: UILabel = {
        let maxTempValueLabel = UILabel()
        maxTempValueLabel.text = ""
        maxTempValueLabel.textAlignment = .right
        maxTempValueLabel.textColor = .black
        maxTempValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return maxTempValueLabel
    }()
    
    let maxTempLabel: UILabel = {
        let maxTempLabel = UILabel()
        maxTempLabel.text = ""
        maxTempLabel.textAlignment = .left
        maxTempLabel.textColor = .black
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return maxTempLabel
    }()
    
    let minTempLabel: UILabel = {
        let minTempLabel = UILabel()
        minTempLabel.text = ""
        minTempLabel.textAlignment = .left
        minTempLabel.textColor = .black
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return minTempLabel
    }()
    
    let pressureLabel: UILabel = {
        let pressureLabel = UILabel()
        pressureLabel.text = ""
        pressureLabel.textAlignment = .left
        pressureLabel.textColor = .black
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return pressureLabel
    }()
    
    let windSpeedLabel: UILabel = {
        let windSpeedLabel = UILabel()
        windSpeedLabel.text = ""
        windSpeedLabel.textAlignment = .left
        windSpeedLabel.textColor = .black
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return windSpeedLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(cityNameLabel)
        view.addSubview(conditionLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(pressureValueLabel)
        view.addSubview(windSpeedValueLabel)
        view.addSubview(minTempValueLabel)
        view.addSubview(maxTempValueLabel)
        view.addSubview(pressureLabel)
        view.addSubview(windSpeedLabel)
        view.addSubview(minTempLabel)
        view.addSubview(maxTempLabel)
        
        let topStack = UIStackView(arrangedSubviews: [cityNameLabel, conditionLabel, temperatureLabel])
        
        topStack.distribution = .equalSpacing
        topStack.axis = .vertical
        topStack.spacing = 10
        topStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topStack)
        
        let leftStack = UIStackView(arrangedSubviews: [pressureLabel, windSpeedLabel, minTempLabel, maxTempLabel])
        
        leftStack.distribution = .equalSpacing
        leftStack.axis = .vertical
        leftStack.spacing = 2
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftStack)
        
        let rightStack = UIStackView(arrangedSubviews: [pressureValueLabel, windSpeedValueLabel, minTempValueLabel, maxTempValueLabel])
        
        rightStack.distribution = .equalSpacing
        rightStack.axis = .vertical
        rightStack.spacing = 2
        rightStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightStack)
        
        let bottomStack = UIStackView(arrangedSubviews: [leftStack, rightStack])
        bottomStack.distribution = .equalSpacing
        bottomStack.axis = .horizontal
        bottomStack.spacing = 2
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomStack)
        
        let totalStack = UIStackView(arrangedSubviews: [topStack, bottomStack])
        totalStack.distribution = .equalSpacing
        totalStack.axis = .vertical
        totalStack.spacing = 2
        totalStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalStack)
        
        print(view.topAnchor)
        
        
        NSLayoutConstraint.activate([
            totalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            totalStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ])
        refreshLabels()
    }
    
    func refreshLabels() {
        cityNameLabel.text = weatherModel?.name
        conditionLabel.text = weatherModel?.conditionString
        
        pressureLabel.text = "Давление: "
        windSpeedLabel.text = "Скорость ветра: "
        minTempLabel.text = "Минимальная температура: "
        maxTempLabel.text = "Максимальная температура: "
        
        if let temp = weatherModel?.temperature {
            temperatureLabel.text = "\(temp) °C"
        }
        if let pressureMm = weatherModel?.pressureMm {
            pressureValueLabel.text = "\(pressureMm) мм.рт.с"
        }
        if let windSpeed = weatherModel?.windSpeed {
            windSpeedValueLabel.text = "\(windSpeed) м/с"
        }
        if let tempMin = weatherModel?.tempMin {
            minTempValueLabel.text = "\(tempMin) °C"
        }
        if let tempMax = weatherModel?.tempMax {
            maxTempValueLabel.text = "\(tempMax)°C"
        }
    }
}
