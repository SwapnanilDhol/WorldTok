//
//  Seaching Cities.swift
//  WorldTok
//
//  Created by Swapnanil Dhol on 10/18/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.
//

import UIKit

class SeachingCities: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredTimeZones = [TimeModelz]()
    var listOfTimeZones = [TimeModelz]()
    
    var asiaTimes = UserDefaults.standard.value(forKey: "asiaTimes") as? [String]
    var africaTimes = UserDefaults.standard.value(forKey: "africaTimes") as? [String]
    var americaTimes = UserDefaults.standard.value(forKey: "americaTimes") as? [String]
    var usCommonTimes = UserDefaults.standard.value(forKey: "usCommonTimes") as? [String]
    var australiaTimes = UserDefaults.standard.value(forKey: "australiaTimes") as? [String]
    var indianTimes = UserDefaults.standard.value(forKey: "indianTimes") as? [String]
    var pacificTimes = UserDefaults.standard.value(forKey: "pacificTimes") as? [String]
    var europeTimes = UserDefaults.standard.value(forKey: "europeTimes") as? [String]
    var articTimes = UserDefaults.standard.value(forKey: "articTimes") as? [String]
    var atlanticTimes = UserDefaults.standard.value(forKey: "atlanticTimes") as? [String]
    var antarticaTimes = UserDefaults.standard.value(forKey: "antarticaTimes") as? [String]
    
    

    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search a City"
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Cities"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        list()

    }
    
    func list()
    {
        listOfTimeZones = [
        
            TimeModelz(region: "US (Common)", timeZoneCode: "America/Puerto_Rico", cityName: "Puerto Rico (Atlantic)"),
            TimeModelz(region: "US (Common)", timeZoneCode: "America/New_York", cityName: "New York (Eastern)"),
            TimeModelz(region: "US (Common)", timeZoneCode: "America/Chicago", cityName: "Chicago (Central)"),
            TimeModelz(region: "US (Common)", timeZoneCode: "America/Denver", cityName: "Denver (Mountain)"),
            TimeModelz(region: "US (Common)", timeZoneCode: "America/Phoenix", cityName: "Phoenix (MST)"),
            TimeModelz(region: "US (Common)", timeZoneCode: "America/Los_Angeles", cityName: "Los Angeles (Pacific)"),
            TimeModelz(region: "US (Common)", timeZoneCode: "America/Anchorage", cityName: "Anchorage (Alaska)"),
            TimeModelz(region: "US (Common)", timeZoneCode: "Pacific/Honolulu", cityName: "Honolulu (Hawaii)"),
            TimeModelz(region: "America", timeZoneCode: "America/Adak", cityName: "Adak"),
            TimeModelz(region: "America", timeZoneCode: "America/Anchorage", cityName: "Anchorage"),
            TimeModelz(region: "America", timeZoneCode: "America/Anguilla", cityName: "Anguilla"),
            TimeModelz(region: "America", timeZoneCode: "America/Antigua", cityName: "Antigua"),
            TimeModelz(region: "America", timeZoneCode: "America/Araguaina", cityName: "Araguaina"),
            TimeModelz(region: "America", timeZoneCode: "America/Argentina/Buenos_Aires", cityName: "Argentina - Buenos Aires"),
            TimeModelz(region: "America", timeZoneCode: "America/Argentina/Catamarca", cityName: "Argentina - Catamarca"),
            TimeModelz(region: "America", timeZoneCode: "America/Argentina/ComodRivadavia", cityName: "Argentina - ComodRivadavia"),
            TimeModelz(region: "America", timeZoneCode: "America/Argentina/Cordoba", cityName: "Argentina - Cordoba"),
            TimeModelz(region: "America", timeZoneCode: "America/Argentina/Jujuy", cityName: "Argentina - Jujuy"),
            TimeModelz(region: "America", timeZoneCode: "America/Argentina/La_Rioja", cityName: "Argentina - La Rioja"),
            TimeModelz(region: "America", timeZoneCode: "America/Argentina/Mendoza", cityName: "Argentina - Mendoza"),
            TimeModelz(region: "America", timeZoneCode: "America/Argentina/Rio_Gallegos", cityName: "Argentina - Rio Gallegos"),
            TimeModelz(region: "America", timeZoneCode: "America/Argentina/Salta", cityName: "Argentina - Salta"),
            TimeModelz(region: "America", timeZoneCode: "America/Argentina/San_Juan", cityName: "Argentina - San Juan"),
            TimeModelz(region: "America", timeZoneCode: "America/Argentina/San_Luis", cityName: "Argentina - San Luis"),
            TimeModelz(region: "America", timeZoneCode: "America/Argentina/Tucuman", cityName: "Argentina - Tucuman"),
            TimeModelz(region: "America", timeZoneCode: "America/Argentina/Ushuaia", cityName: "Argentina - Ushuaia"),
            TimeModelz(region: "America", timeZoneCode: "America/Aruba", cityName: "Aruba"),
            TimeModelz(region: "America", timeZoneCode: "America/Asuncion", cityName: "Asuncion"),
            TimeModelz(region: "America", timeZoneCode: "America/Atikokan", cityName: "Atikokan"),
            TimeModelz(region: "America", timeZoneCode: "America/Atka", cityName: "Atka"),
            TimeModelz(region: "America", timeZoneCode: "America/Bahia", cityName: "Bahia"),
            TimeModelz(region: "America", timeZoneCode: "America/Barbados", cityName: "Barbados"),
            TimeModelz(region: "America", timeZoneCode: "America/Belem", cityName: "Belem"),
            TimeModelz(region: "America", timeZoneCode: "America/Belize", cityName: "Belize"),
            TimeModelz(region: "America", timeZoneCode: "America/Blanc-Sablon", cityName: "Blanc-Sablon"),
            TimeModelz(region: "America", timeZoneCode: "America/Boa_Vista", cityName: "Boa Vista"),
            TimeModelz(region: "America", timeZoneCode: "America/Bogota", cityName: "Bogota"),
            TimeModelz(region: "America", timeZoneCode: "America/Boise", cityName: "Boise"),
            TimeModelz(region: "America", timeZoneCode: "America/Buenos_Aires", cityName: "Buenos Aires"),
            TimeModelz(region: "America", timeZoneCode: "America/Cambridge_Bay", cityName: "Cambridge Bay"),
            TimeModelz(region: "America", timeZoneCode: "America/Campo_Grande", cityName: "Campo Grande"),
            TimeModelz(region: "America", timeZoneCode: "America/Cancun", cityName: "Cancun"),
            TimeModelz(region: "America", timeZoneCode: "America/Caracas", cityName: "Caracas"),
            TimeModelz(region: "America", timeZoneCode: "America/Catamarca", cityName: "Catamarca"),
            TimeModelz(region: "America", timeZoneCode: "America/Cayenne", cityName: "Cayenne"),
            TimeModelz(region: "America", timeZoneCode: "America/Cayman", cityName: "Cayman"),
            TimeModelz(region: "America", timeZoneCode: "America/Chicago", cityName: "Chicago"),
            TimeModelz(region: "America", timeZoneCode: "America/Chihuahua", cityName: "Chihuahua"),
            TimeModelz(region: "America", timeZoneCode: "America/Coral_Harbour", cityName: "Coral Harbour"),
            TimeModelz(region: "America", timeZoneCode: "America/Cordoba", cityName: "Cordoba"),
            TimeModelz(region: "America", timeZoneCode: "America/Costa_Rica", cityName: "Costa Rica"),
            TimeModelz(region: "America", timeZoneCode: "America/Cuiaba", cityName: "Cuiaba"),
            TimeModelz(region: "America", timeZoneCode: "America/Curacao", cityName: "Curacao"),
            TimeModelz(region: "America", timeZoneCode: "America/Danmarkshavn", cityName: "Danmarkshavn"),
            TimeModelz(region: "America", timeZoneCode: "America/Dawson", cityName: "Dawson"),
            TimeModelz(region: "America", timeZoneCode: "America/Dawson_Creek", cityName: "Dawson Creek"),
            TimeModelz(region: "America", timeZoneCode: "America/Denver", cityName: "Denver"),
            TimeModelz(region: "America", timeZoneCode: "America/Detroit", cityName: "Detroit"),
            TimeModelz(region: "America", timeZoneCode: "America/Dominica", cityName: "Dominica"),
            TimeModelz(region: "America", timeZoneCode: "America/Edmonton", cityName: "Edmonton"),
            TimeModelz(region: "America", timeZoneCode: "America/Eirunepe", cityName: "Eirunepe"),
            TimeModelz(region: "America", timeZoneCode: "America/El_Salvador", cityName: "El Salvador"),
            TimeModelz(region: "America", timeZoneCode: "America/Ensenada", cityName: "Ensenada"),
            TimeModelz(region: "America", timeZoneCode: "America/Fortaleza", cityName: "Fortaleza"),
            TimeModelz(region: "America", timeZoneCode: "America/Fort_Wayne", cityName: "Fort Wayne"),
            TimeModelz(region: "America", timeZoneCode: "America/Glace_Bay", cityName: "Glace Bay"),
            TimeModelz(region: "America", timeZoneCode: "America/Godthab", cityName: "Godthab"),
            TimeModelz(region: "America", timeZoneCode: "America/Goose_Bay", cityName: "Goose Bay"),
            TimeModelz(region: "America", timeZoneCode: "America/Grand_Turk", cityName: "Grand Turk"),
            TimeModelz(region: "America", timeZoneCode: "America/Grenada", cityName: "Grenada"),
            TimeModelz(region: "America", timeZoneCode: "America/Guadeloupe", cityName: "Guadeloupe"),
            TimeModelz(region: "America", timeZoneCode: "America/Guatemala", cityName: "Guatemala"),
            TimeModelz(region: "America", timeZoneCode: "America/Guayaquil", cityName: "Guayaquil"),
            TimeModelz(region: "America", timeZoneCode: "America/Guyana", cityName: "Guyana"),
            TimeModelz(region: "America", timeZoneCode: "America/Halifax", cityName: "Halifax"),
            TimeModelz(region: "America", timeZoneCode: "America/Havana", cityName: "Havana"),
            TimeModelz(region: "America", timeZoneCode: "America/Hermosillo", cityName: "Hermosillo"),
            TimeModelz(region: "America", timeZoneCode: "America/Indiana/Indianapolis", cityName: "Indiana - Indianapolis"),
            TimeModelz(region: "America", timeZoneCode: "America/Indiana/Knox", cityName: "Indiana - Knox"),
            TimeModelz(region: "America", timeZoneCode: "America/Indiana/Marengo", cityName: "Indiana - Marengo"),
            TimeModelz(region: "America", timeZoneCode: "America/Indiana/Petersburg", cityName: "Indiana - Petersburg"),
            TimeModelz(region: "America", timeZoneCode: "America/Indiana/Tell_City", cityName: "Indiana - Tell City"),
            TimeModelz(region: "America", timeZoneCode: "America/Indiana/Vevay", cityName: "Indiana - Vevay"),
            TimeModelz(region: "America", timeZoneCode: "America/Indiana/Vincennes", cityName: "Indiana - Vincennes"),
            TimeModelz(region: "America", timeZoneCode: "America/Indiana/Winamac", cityName: "Indiana - Winamac"),
            TimeModelz(region: "America", timeZoneCode: "America/Indianapolis", cityName: "Indianapolis"),
            TimeModelz(region: "America", timeZoneCode: "America/Inuvik", cityName: "Inuvik"),
            TimeModelz(region: "America", timeZoneCode: "America/Iqaluit", cityName: "Iqaluit"),
            TimeModelz(region: "America", timeZoneCode: "America/Jamaica", cityName: "Jamaica"),
            TimeModelz(region: "America", timeZoneCode: "America/Jujuy", cityName: "Jujuy"),
            TimeModelz(region: "America", timeZoneCode: "America/Juneau", cityName: "Juneau"),
            TimeModelz(region: "America", timeZoneCode: "America/Kentucky/Louisville", cityName: "Kentucky - Louisville"),
            TimeModelz(region: "America", timeZoneCode: "America/Kentucky/Monticello", cityName: "Kentucky - Monticello"),
            TimeModelz(region: "America", timeZoneCode: "America/Knox_IN", cityName: "Knox IN"),
            TimeModelz(region: "America", timeZoneCode: "America/La_Paz", cityName: "La Paz"),
            TimeModelz(region: "America", timeZoneCode: "America/Lima", cityName: "Lima"),
            TimeModelz(region: "America", timeZoneCode: "America/Los_Angeles", cityName: "Los Angeles"),
            TimeModelz(region: "America", timeZoneCode: "America/Louisville", cityName: "Louisville"),
            TimeModelz(region: "America", timeZoneCode: "America/Maceio", cityName: "Maceio"),
            TimeModelz(region: "America", timeZoneCode: "America/Managua", cityName: "Managua"),
            TimeModelz(region: "America", timeZoneCode: "America/Manaus", cityName: "Manaus"),
            TimeModelz(region: "America", timeZoneCode: "America/Marigot", cityName: "Marigot"),
            TimeModelz(region: "America", timeZoneCode: "America/Martinique", cityName: "Martinique"),
            TimeModelz(region: "America", timeZoneCode: "America/Matamoros", cityName: "Matamoros"),
            TimeModelz(region: "America", timeZoneCode: "America/Mazatlan", cityName: "Mazatlan"),
            TimeModelz(region: "America", timeZoneCode: "America/Mendoza", cityName: "Mendoza"),
            TimeModelz(region: "America", timeZoneCode: "America/Menominee", cityName: "Menominee"),
            TimeModelz(region: "America", timeZoneCode: "America/Merida", cityName: "Merida"),
            TimeModelz(region: "America", timeZoneCode: "America/Mexico_City", cityName: "Mexico City"),
            TimeModelz(region: "America", timeZoneCode: "America/Miquelon", cityName: "Miquelon"),
            TimeModelz(region: "America", timeZoneCode: "America/Moncton", cityName: "Moncton"),
            TimeModelz(region: "America", timeZoneCode: "America/Monterrey", cityName: "Monterrey"),
            TimeModelz(region: "America", timeZoneCode: "America/Montevideo", cityName: "Montevideo"),
            TimeModelz(region: "America", timeZoneCode: "America/Montreal", cityName: "Montreal"),
            TimeModelz(region: "America", timeZoneCode: "America/Montserrat", cityName: "Montserrat"),
            TimeModelz(region: "America", timeZoneCode: "America/Nassau", cityName: "Nassau"),
            TimeModelz(region: "America", timeZoneCode: "America/New_York", cityName: "New York"),
            TimeModelz(region: "America", timeZoneCode: "America/Nipigon", cityName: "Nipigon"),
            TimeModelz(region: "America", timeZoneCode: "America/Nome", cityName: "Nome"),
            TimeModelz(region: "America", timeZoneCode: "America/Noronha", cityName: "Noronha"),
            TimeModelz(region: "America", timeZoneCode: "America/North_Dakota/Center", cityName: "North Dakota - Center"),
            TimeModelz(region: "America", timeZoneCode: "America/North_Dakota/New_Salem", cityName: "North Dakota - New Salem"),
            TimeModelz(region: "America", timeZoneCode: "America/Ojinaga", cityName: "Ojinaga"),
            TimeModelz(region: "America", timeZoneCode: "America/Panama", cityName: "Panama"),
            TimeModelz(region: "America", timeZoneCode: "America/Pangnirtung", cityName: "Pangnirtung"),
            TimeModelz(region: "America", timeZoneCode: "America/Paramaribo", cityName: "Paramaribo"),
            TimeModelz(region: "America", timeZoneCode: "America/Phoenix", cityName: "Phoenix"),
            TimeModelz(region: "America", timeZoneCode: "America/Port-au-Prince", cityName: "Port-au-Prince"),
            TimeModelz(region: "America", timeZoneCode: "America/Porto_Acre", cityName: "Porto Acre"),
            TimeModelz(region: "America", timeZoneCode: "America/Port_of_Spain", cityName: "Port of Spain"),
            TimeModelz(region: "America", timeZoneCode: "America/Porto_Velho", cityName: "Porto Velho"),
            TimeModelz(region: "America", timeZoneCode: "America/Puerto_Rico", cityName: "Puerto Rico"),
            TimeModelz(region: "America", timeZoneCode: "America/Rainy_River", cityName: "Rainy River"),
            TimeModelz(region: "America", timeZoneCode: "America/Rankin_Inlet", cityName: "Rankin Inlet"),
            TimeModelz(region: "America", timeZoneCode: "America/Recife", cityName: "Recife"),
            TimeModelz(region: "America", timeZoneCode: "America/Regina", cityName: "Regina"),
            TimeModelz(region: "America", timeZoneCode: "America/Resolute", cityName: "Resolute"),
            TimeModelz(region: "America", timeZoneCode: "America/Rio_Branco", cityName: "Rio Branco"),
            TimeModelz(region: "America", timeZoneCode: "America/Rosario", cityName: "Rosario"),
            TimeModelz(region: "America", timeZoneCode: "America/Santa_Isabel", cityName: "Santa Isabel"),
            TimeModelz(region: "America", timeZoneCode: "America/Santarem", cityName: "Santarem"),
            TimeModelz(region: "America", timeZoneCode: "America/Santiago", cityName: "Santiago"),
            TimeModelz(region: "America", timeZoneCode: "America/Santo_Domingo", cityName: "Santo Domingo"),
            TimeModelz(region: "America", timeZoneCode: "America/Sao_Paulo", cityName: "Sao Paulo"),
            TimeModelz(region: "America", timeZoneCode: "America/Scoresbysund", cityName: "Scoresbysund"),
            TimeModelz(region: "America", timeZoneCode: "America/Shiprock", cityName: "Shiprock"),
            TimeModelz(region: "America", timeZoneCode: "America/St_Barthelemy", cityName: "St Barthelemy"),
            TimeModelz(region: "America", timeZoneCode: "America/St_Johns", cityName: "St Johns"),
            TimeModelz(region: "America", timeZoneCode: "America/St_Kitts", cityName: "St Kitts"),
            TimeModelz(region: "America", timeZoneCode: "America/St_Lucia", cityName: "St Lucia"),
            TimeModelz(region: "America", timeZoneCode: "America/St_Thomas", cityName: "St Thomas"),
            TimeModelz(region: "America", timeZoneCode: "America/St_Vincent", cityName: "St Vincent"),
            TimeModelz(region: "America", timeZoneCode: "America/Swift_Current", cityName: "Swift Current"),
            TimeModelz(region: "America", timeZoneCode: "America/Tegucigalpa", cityName: "Tegucigalpa"),
            TimeModelz(region: "America", timeZoneCode: "America/Thule", cityName: "Thule"),
            TimeModelz(region: "America", timeZoneCode: "America/Thunder_Bay", cityName: "Thunder Bay"),
            TimeModelz(region: "America", timeZoneCode: "America/Tijuana", cityName: "Tijuana"),
            TimeModelz(region: "America", timeZoneCode: "America/Toronto", cityName: "Toronto"),
            TimeModelz(region: "America", timeZoneCode: "America/Tortola", cityName: "Tortola"),
            TimeModelz(region: "America", timeZoneCode: "America/Vancouver", cityName: "Vancouver"),
            TimeModelz(region: "America", timeZoneCode: "America/Virgin", cityName: "Virgin"),
            TimeModelz(region: "America", timeZoneCode: "America/Whitehorse", cityName: "Whitehorse"),
            TimeModelz(region: "America", timeZoneCode: "America/Winnipeg", cityName: "Winnipeg"),
            TimeModelz(region: "America", timeZoneCode: "America/Yakutat", cityName: "Yakutat"),
            TimeModelz(region: "America", timeZoneCode: "America/Yellowknife", cityName: "Yellowknife"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Amsterdam", cityName: "Amsterdam"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Andorra", cityName: "Andorra"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Athens", cityName: "Athens"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Belfast", cityName: "Belfast"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Belgrade", cityName: "Belgrade"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Berlin", cityName: "Berlin"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Bratislava", cityName: "Bratislava"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Brussels", cityName: "Brussels"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Bucharest", cityName: "Bucharest"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Budapest", cityName: "Budapest"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Chisinau", cityName: "Chisinau"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Copenhagen", cityName: "Copenhagen"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Dublin", cityName: "Dublin"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Gibraltar", cityName: "Gibraltar"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Guernsey", cityName: "Guernsey"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Helsinki", cityName: "Helsinki"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Isle_of_Man", cityName: "Isle of Man"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Istanbul", cityName: "Istanbul"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Jersey", cityName: "Jersey"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Kaliningrad", cityName: "Kaliningrad"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Kiev", cityName: "Kiev"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Lisbon", cityName: "Lisbon"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Ljubljana", cityName: "Ljubljana"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/London", cityName: "London"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Luxembourg", cityName: "Luxembourg"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Madrid", cityName: "Madrid"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Malta", cityName: "Malta"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Mariehamn", cityName: "Mariehamn"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Minsk", cityName: "Minsk"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Monaco", cityName: "Monaco"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Moscow", cityName: "Moscow"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Nicosia", cityName: "Nicosia"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Oslo", cityName: "Oslo"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Paris", cityName: "Paris"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Podgorica", cityName: "Podgorica"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Prague", cityName: "Prague"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Riga", cityName: "Riga"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Rome", cityName: "Rome"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Samara", cityName: "Samara"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/San_Marino", cityName: "San Marino"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Sarajevo", cityName: "Sarajevo"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Simferopol", cityName: "Simferopol"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Skopje", cityName: "Skopje"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Sofia", cityName: "Sofia"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Stockholm", cityName: "Stockholm"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Tallinn", cityName: "Tallinn"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Tirane", cityName: "Tirane"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Tiraspol", cityName: "Tiraspol"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Uzhgorod", cityName: "Uzhgorod"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Vaduz", cityName: "Vaduz"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Vatican", cityName: "Vatican"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Vienna", cityName: "Vienna"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Vilnius", cityName: "Vilnius"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Volgograd", cityName: "Volgograd"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Warsaw", cityName: "Warsaw"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Zagreb", cityName: "Zagreb"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Zaporozhye", cityName: "Zaporozhye"),
            TimeModelz(region: "Europe", timeZoneCode: "Europe/Zurich", cityName: "Zurich"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Aden", cityName: "Aden"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Almaty", cityName: "Almaty"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Amman", cityName: "Amman"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Anadyr", cityName: "Anadyr"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Aqtau", cityName: "Aqtau"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Aqtobe", cityName: "Aqtobe"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Ashgabat", cityName: "Ashgabat"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Ashkhabad", cityName: "Ashkhabad"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Baghdad", cityName: "Baghdad"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Bahrain", cityName: "Bahrain"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Baku", cityName: "Baku"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Bangkok", cityName: "Bangkok"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Beirut", cityName: "Beirut"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Bishkek", cityName: "Bishkek"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Brunei", cityName: "Brunei"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Calcutta", cityName: "Calcutta"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Choibalsan", cityName: "Choibalsan"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Chongqing", cityName: "Chongqing"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Chungking", cityName: "Chungking"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Colombo", cityName: "Colombo"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Dacca", cityName: "Dacca"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Damascus", cityName: "Damascus"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Dhaka", cityName: "Dhaka"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Dili", cityName: "Dili"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Dubai", cityName: "Dubai"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Dushanbe", cityName: "Dushanbe"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Gaza", cityName: "Gaza"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Harbin", cityName: "Harbin"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Ho_Chi_Minh", cityName: "Ho Chi Minh"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Hong_Kong", cityName: "Hong Kong"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Hovd", cityName: "Hovd"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Irkutsk", cityName: "Irkutsk"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Istanbul", cityName: "Istanbul"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Jakarta", cityName: "Jakarta"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Jayapura", cityName: "Jayapura"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Jerusalem", cityName: "Jerusalem"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Kabul", cityName: "Kabul"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Kamchatka", cityName: "Kamchatka"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Karachi", cityName: "Karachi"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Kashgar", cityName: "Kashgar"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Kathmandu", cityName: "Kathmandu"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Katmandu", cityName: "Katmandu"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Kolkata", cityName: "Kolkata"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Krasnoyarsk", cityName: "Krasnoyarsk"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Kuala_Lumpur", cityName: "Kuala Lumpur"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Kuching", cityName: "Kuching"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Kuwait", cityName: "Kuwait"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Macao", cityName: "Macao"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Macau", cityName: "Macau"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Magadan", cityName: "Magadan"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Makassar", cityName: "Makassar"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Manila", cityName: "Manila"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Muscat", cityName: "Muscat"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Nicosia", cityName: "Nicosia"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Novokuznetsk", cityName: "Novokuznetsk"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Novosibirsk", cityName: "Novosibirsk"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Omsk", cityName: "Omsk"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Oral", cityName: "Oral"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Phnom_Penh", cityName: "Phnom Penh"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Pontianak", cityName: "Pontianak"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Pyongyang", cityName: "Pyongyang"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Qatar", cityName: "Qatar"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Qyzylorda", cityName: "Qyzylorda"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Rangoon", cityName: "Rangoon"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Riyadh", cityName: "Riyadh"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Saigon", cityName: "Saigon"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Sakhalin", cityName: "Sakhalin"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Samarkand", cityName: "Samarkand"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Seoul", cityName: "Seoul"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Shanghai", cityName: "Shanghai"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Singapore", cityName: "Singapore"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Taipei", cityName: "Taipei"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Tashkent", cityName: "Tashkent"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Tbilisi", cityName: "Tbilisi"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Tehran", cityName: "Tehran"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Tel_Aviv", cityName: "Tel Aviv"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Thimbu", cityName: "Thimbu"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Thimphu", cityName: "Thimphu"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Tokyo", cityName: "Tokyo"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Ujung_Pandang", cityName: "Ujung Pandang"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Ulaanbaatar", cityName: "Ulaanbaatar"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Ulan_Bator", cityName: "Ulan Bator"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Urumqi", cityName: "Urumqi"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Vientiane", cityName: "Vientiane"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Vladivostok", cityName: "Vladivostok"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Yakutsk", cityName: "Yakutsk"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Yekaterinburg", cityName: "Yekaterinburg"),
            TimeModelz(region: "Asia", timeZoneCode: "Asia/Yerevan", cityName: "Yerevan"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Abidjan", cityName: "Abidjan"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Accra", cityName: "Accra"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Addis_Ababa", cityName: "Addis Ababa"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Algiers", cityName: "Algiers"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Asmara", cityName: "Asmara"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Asmera", cityName: "Asmera"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Bamako", cityName: "Bamako"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Bangui", cityName: "Bangui"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Banjul", cityName: "Banjul"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Bissau", cityName: "Bissau"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Blantyre", cityName: "Blantyre"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Brazzaville", cityName: "Brazzaville"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Bujumbura", cityName: "Bujumbura"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Cairo", cityName: "Cairo"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Casablanca", cityName: "Casablanca"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Ceuta", cityName: "Ceuta"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Conakry", cityName: "Conakry"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Dakar", cityName: "Dakar"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Dar_es_Salaam", cityName: "Dar es Salaam"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Djibouti", cityName: "Djibouti"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Douala", cityName: "Douala"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/El_Aaiun", cityName: "El Aaiun"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Freetown", cityName: "Freetown"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Gaborone", cityName: "Gaborone"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Harare", cityName: "Harare"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Johannesburg", cityName: "Johannesburg"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Kampala", cityName: "Kampala"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Khartoum", cityName: "Khartoum"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Kigali", cityName: "Kigali"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Kinshasa", cityName: "Kinshasa"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Lagos", cityName: "Lagos"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Libreville", cityName: "Libreville"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Lome", cityName: "Lome"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Luanda", cityName: "Luanda"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Lubumbashi", cityName: "Lubumbashi"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Lusaka", cityName: "Lusaka"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Malabo", cityName: "Malabo"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Maputo", cityName: "Maputo"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Maseru", cityName: "Maseru"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Mbabane", cityName: "Mbabane"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Mogadishu", cityName: "Mogadishu"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Monrovia", cityName: "Monrovia"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Nairobi", cityName: "Nairobi"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Ndjamena", cityName: "Ndjamena"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Niamey", cityName: "Niamey"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Nouakchott", cityName: "Nouakchott"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Ouagadougou", cityName: "Ouagadougou"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Porto-Novo", cityName: "Porto-Novo"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Sao_Tome", cityName: "Sao Tome"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Timbuktu", cityName: "Timbuktu"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Tripoli", cityName: "Tripoli"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Tunis", cityName: "Tunis"),
            TimeModelz(region: "Africa", timeZoneCode: "Africa/Windhoek", cityName: "Windhoek"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/ACT", cityName: "ACT"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Adelaide", cityName: "Adelaide"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Brisbane", cityName: "Brisbane"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Broken_Hill", cityName: "Broken Hill"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Canberra", cityName: "Canberra"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Currie", cityName: "Currie"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Darwin", cityName: "Darwin"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Eucla", cityName: "Eucla"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Hobart", cityName: "Hobart"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/LHI", cityName: "LHI"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Lindeman", cityName: "Lindeman"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Lord_Howe", cityName: "Lord Howe"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Melbourne", cityName: "Melbourne"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/North", cityName: "North"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/NSW", cityName: "NSW"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Perth", cityName: "Perth"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Queensland", cityName: "Queensland"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/South", cityName: "South"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Sydney", cityName: "Sydney"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Tasmania", cityName: "Tasmania"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Victoria", cityName: "Victoria"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/West", cityName: "West"),
            TimeModelz(region: "Australia", timeZoneCode: "Australia/Yancowinna", cityName: "Yancowinna"),
            TimeModelz(region: "Indian", timeZoneCode: "Indian/Antananarivo", cityName: "Antananarivo"),
            TimeModelz(region: "Indian", timeZoneCode: "Indian/Chagos", cityName: "Chagos"),
            TimeModelz(region: "Indian", timeZoneCode: "Indian/Christmas", cityName: "Christmas"),
            TimeModelz(region: "Indian", timeZoneCode: "Indian/Cocos", cityName: "Cocos"),
            TimeModelz(region: "Indian", timeZoneCode: "Indian/Comoro", cityName: "Comoro"),
            TimeModelz(region: "Indian", timeZoneCode: "Indian/Kerguelen", cityName: "Kerguelen"),
            TimeModelz(region: "Indian", timeZoneCode: "Indian/Mahe", cityName: "Mahe"),
            TimeModelz(region: "Indian", timeZoneCode: "Indian/Maldives", cityName: "Maldives"),
            TimeModelz(region: "Indian", timeZoneCode: "Indian/Mauritius", cityName: "Mauritius"),
            TimeModelz(region: "Indian", timeZoneCode: "Indian/Mayotte", cityName: "Mayotte"),
            TimeModelz(region: "Indian", timeZoneCode: "Indian/Reunion", cityName: "Reunion"),
            TimeModelz(region: "Atlantic", timeZoneCode: "Atlantic/Azores", cityName: "Azores"),
            TimeModelz(region: "Atlantic", timeZoneCode: "Atlantic/Bermuda", cityName: "Bermuda"),
            TimeModelz(region: "Atlantic", timeZoneCode: "Atlantic/Canary", cityName: "Canary"),
            TimeModelz(region: "Atlantic", timeZoneCode: "Atlantic/Cape_Verde", cityName: "Cape Verde"),
            TimeModelz(region: "Atlantic", timeZoneCode: "Atlantic/Faeroe", cityName: "Faeroe"),
            TimeModelz(region: "Atlantic", timeZoneCode: "Atlantic/Faroe", cityName: "Faroe"),
            TimeModelz(region: "Atlantic", timeZoneCode: "Atlantic/Jan_Mayen", cityName: "Jan Mayen"),
            TimeModelz(region: "Atlantic", timeZoneCode: "Atlantic/Madeira", cityName: "Madeira"),
            TimeModelz(region: "Atlantic", timeZoneCode: "Atlantic/Reykjavik", cityName: "Reykjavik"),
            TimeModelz(region: "Atlantic", timeZoneCode: "Atlantic/South_Georgia", cityName: "South Georgia"),
            TimeModelz(region: "Atlantic", timeZoneCode: "Atlantic/Stanley", cityName: "Stanley"),
            TimeModelz(region: "Atlantic", timeZoneCode: "Atlantic/St_Helena", cityName: "St Helena"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Apia", cityName: "Apia"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Auckland", cityName: "Auckland"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Chatham", cityName: "Chatham"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Easter", cityName: "Easter"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Efate", cityName: "Efate"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Enderbury", cityName: "Enderbury"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Fakaofo", cityName: "Fakaofo"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Fiji", cityName: "Fiji"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Funafuti", cityName: "Funafuti"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Galapagos", cityName: "Galapagos"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Gambier", cityName: "Gambier"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Guadalcanal", cityName: "Guadalcanal"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Guam", cityName: "Guam"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Honolulu", cityName: "Honolulu"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Johnston", cityName: "Johnston"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Kiritimati", cityName: "Kiritimati"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Kosrae", cityName: "Kosrae"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Kwajalein", cityName: "Kwajalein"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Majuro", cityName: "Majuro"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Marquesas", cityName: "Marquesas"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Midway", cityName: "Midway"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Nauru", cityName: "Nauru"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Niue", cityName: "Niue"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Norfolk", cityName: "Norfolk"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Noumea", cityName: "Noumea"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Pago_Pago", cityName: "Pago Pago"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Palau", cityName: "Palau"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Pitcairn", cityName: "Pitcairn"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Ponape", cityName: "Ponape"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Port_Moresby", cityName: "Port Moresby"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Rarotonga", cityName: "Rarotonga"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Saipan", cityName: "Saipan"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Samoa", cityName: "Samoa"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Tahiti", cityName: "Tahiti"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Tarawa", cityName: "Tarawa"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Tongatapu", cityName: "Tongatapu"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Truk", cityName: "Truk"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Wake", cityName: "Wake"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Wallis", cityName: "Wallis"),
            TimeModelz(region: "Pacific", timeZoneCode: "Pacific/Yap", cityName: "Yap"),
            TimeModelz(region: "Antarctica", timeZoneCode: "Antarctica/Casey", cityName: "Casey"),
            TimeModelz(region: "Antarctica", timeZoneCode: "Antarctica/Davis", cityName: "Davis"),
            TimeModelz(region: "Antarctica", timeZoneCode: "Antarctica/DumontDUrville", cityName: "DumontDUrville"),
            TimeModelz(region: "Antarctica", timeZoneCode: "Antarctica/Macquarie", cityName: "Macquarie"),
            TimeModelz(region: "Antarctica", timeZoneCode: "Antarctica/Mawson", cityName: "Mawson"),
            TimeModelz(region: "Antarctica", timeZoneCode: "Antarctica/McMurdo", cityName: "McMurdo"),
            TimeModelz(region: "Antarctica", timeZoneCode: "Antarctica/Palmer", cityName: "Palmer"),
            TimeModelz(region: "Antarctica", timeZoneCode: "Antarctica/Rothera", cityName: "Rothera"),
            TimeModelz(region: "Antarctica", timeZoneCode: "Antarctica/South_Pole", cityName: "South Pole"),
            TimeModelz(region: "Antarctica", timeZoneCode: "Antarctica/Syowa", cityName: "Syowa"),
            TimeModelz(region: "Antarctica", timeZoneCode: "Antarctica/Vostok", cityName: "Vostok")
        
        ]
    }
    


   

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
         if isFiltering() {
               return filteredTimeZones.count
             }
               
             return listOfTimeZones.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let tim: TimeModelz
        if isFiltering() {
          tim = filteredTimeZones[indexPath.row]
        }
        else
        {
          tim = listOfTimeZones[indexPath.row]
        }
        cell.textLabel!.text = tim.cityName
        cell.detailTextLabel!.text = tim.timeZoneCode
        return cell
        
    }
    
    func whichRegion(tim : TimeModelz)
    {
        switch tim.region {
        case "Asia":
        break
        case "US (Common)":
        break
        case "America":
        break
        case "Europe":
        break
        case "Africa":
        break
        case "Australia":
        break
        case "Atlantic":
        break
        case "Pacific":
        break
        case "Antartica":
        break
        case "Artic":
        break

        default:
            break
        }
    }
    
}




extension SeachingCities: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
     filterContentForSearchText(searchController.searchBar.text!)
  }
    
    func isFiltering() -> Bool {
      return searchController.isActive && !searchBarIsEmpty()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if isFiltering() {
            
            print(filteredTimeZones[indexPath.row])
           
        }
        else
        {
            print(listOfTimeZones[indexPath.row])
        }
        
    }
    
     func filterContentForSearchText(_ searchText: String, scope: String = "All") {
         filteredTimeZones = listOfTimeZones.filter({( acronym : TimeModelz) -> Bool in
           return acronym.cityName.lowercased().contains(searchText.lowercased())
         })

         tableView.reloadData()
       }
    
    func searchBarIsEmpty() -> Bool {
      // Returns true if the text is empty or nil
      return searchController.searchBar.text?.isEmpty ?? true
    }

}
