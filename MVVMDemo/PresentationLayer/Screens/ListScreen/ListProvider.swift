//
//  ListDataProvider.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/13/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

class ListDataProvider {
    
    let api: APIClient
    
    init(api: APIClient) {
        self.api = api
    }
    
    func loadPlanets(completion: @escaping ([Planet])->()) {
        api.performRequest {
            completion([
                Planet(name: "Earth", description: "Third planet from the Sun and the only object in the Universe known to harbor life. It is the densest planet in the Solar System and the largest of the four terrestrial planets."),
                Planet(name: "Mercury", description: "The smallest and innermost planet in the Solar System. Its orbital period around the Sun of 88 days is the shortest of all the planets in the Solar System. It is named after the Roman deity Mercury, the messenger to the gods."),
                Planet(name: "Mars", description: "The fourth planet from the Sun and the second-smallest planet in the Solar System, after Mercury. Named after the Roman god of war, it is often referred to as the \"Red Planet\" because the iron oxide prevalent on its surface gives it a reddish appearance.[15] Mars is a terrestrial planet with a thin atmosphere, having surface features reminiscent both of the impact craters of the Moon and the valleys, deserts, and polar ice caps of Earth.")
                ])
        }
    }
    
}
