//
//  Networking.swift
//  WorldTok
//
//  Created by Swapnanil Dhol on 10/17/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension HomeScreen
{
    func networkRequest()
    {
        let url = Bundle.main.url(forResource: "Timezones", withExtension: "json")
        Alamofire.request(url!).responseJSON { (response) in
            
            switch response.result
            {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}


//Group 0: US(Common)
//Group 1: America
//Group 2: Europe
//Group 3: Asia
//Group 4: Africa
//Group 5: Australia
//Group 6: Indian
//Group 7: Atlantic
//Group 8: Pacific
//Group 9: Antarctica
//Group 10: Artic
