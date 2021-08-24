//
//  modelCart.swift
//  sehatQ
//
//  Created by adriansalim on 23/08/21.
//  Copyright © 2020 adriansalim. All rights reserved.
//

import UIKit

class modelCart: NSObject, Encodable, Decodable  {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var price : String?
    var title : String?
    var desc : String?
    var image: String?
    var id : String?
    
    init(price: String?, title: String?, desc: String?, image:String?, id:String?){
        self.price = price
        self.title = title
        self.desc = desc
        self.image = image
        self.id = id
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let price = aDecoder.decodeObject(forKey: "price") as! String
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let desc = aDecoder.decodeObject(forKey: "desc") as! String
        let image = aDecoder.decodeObject(forKey: "image") as! String
        let id = aDecoder.decodeObject(forKey: "id") as! String
        self.init(price: price, title: title, desc: desc, image: image, id:id)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(price, forKey: "price")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(desc, forKey: "desc")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(id, forKey: "id")
    }
}
