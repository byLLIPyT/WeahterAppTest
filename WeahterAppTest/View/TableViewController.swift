//
//  TableViewController.swift
//  WeatherAppTest
//
//  Created by Александр Уткин on 05.08.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var emptyCity = Weather()
    var citiesArray = [Weather]()
    var filteredCitiesArray = [Weather]()
    var cities = ["Ставрополь","Екатеринбург","Тюмень","Краснодар","Новороссийск","Уфа","Пермь","Чита","Глазов","Омск","Минеральные воды"]
    
    let networkWeatherManager = NetworkWeatherManager()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarisEmpty: Bool {
        
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarisEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIButton(type: .custom)
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(.blue, for: .normal)
        addButton.addTarget(self, action: #selector(addNewCity), for: .touchUpInside)
        
        let item1 = UIBarButtonItem(customView: addButton)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: CellIdentifier.cellIdentifier)
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: cities.count)
        }
        addCities()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "find"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    @objc func addNewCity(_ sender: Any) {
        
        alertPlusCity(name: "City", placeholder: "Enter city name") { (city) in
            self.cities.append(city)
            self.citiesArray.append(self.emptyCity)
            self.addCities()
        }
    }
    
    
    func addCities() {
        
        getCityWeather(citiesArray: cities) { (index, weather) in
            
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.cities[index]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCitiesArray.count
        }
        return citiesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cellIdentifier, for: indexPath) as! TableViewCell
        
        var weather = Weather()
        if isFiltering {
            weather = filteredCitiesArray[indexPath.row]
        } else {
            weather = citiesArray[indexPath.row]
        }
        cell.configure(weather: weather)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            
            let editionRow = self.cities[indexPath.row]
            if let index = self.cities.firstIndex(of: editionRow) {
                
                if self.isFiltering {
                    self.filteredCitiesArray.remove(at: index)
                } else {
                    self.citiesArray.remove(at: index)
                }
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = DetailViewController()
        if self.isFiltering {
            destination.weatherModel = filteredCitiesArray[indexPath.row]
        } else {
            destination.weatherModel = citiesArray[indexPath.row]
        }
        navigationController?.pushViewController(destination, animated: true)
    }
}

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filterContentForSearchText(text)
        }
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filteredCitiesArray = citiesArray.filter {
            $0.name.contains(searchText)
        }
        tableView.reloadData()
    }
}
