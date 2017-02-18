import SwiftyJSON

public struct Book {
    public let id: String?
    public let title: String
    public let author: String?
    public let pages: Double?

    public init(id: String?, title: String, author: String?, pages: Double?) {
        self.id = id
        self.title = title
        self.author = author
        self.pages = pages
    }

    public init(json: JSON) throws {
        // Required properties
        guard json["title"].exists() else {
            throw ModelError.requiredPropertyMissing(name: "title")
        }
        guard let title = json["title"].string else {
            throw ModelError.propertyTypeMismatch(name: "title", type: "string", value: json["title"].description, valueType: String(describing: json["title"].type))
        }
        self.title = title

        // Optional properties
        if json["id"].exists() &&
           json["id"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "id", type: "string", value: json["id"].description, valueType: String(describing: json["id"].type))
        }
        self.id = json["id"].string
        if json["author"].exists() &&
           json["author"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "author", type: "string", value: json["author"].description, valueType: String(describing: json["author"].type))
        }
        self.author = json["author"].string
        if json["pages"].exists() &&
           json["pages"].type != .number {
            throw ModelError.propertyTypeMismatch(name: "pages", type: "number", value: json["pages"].description, valueType: String(describing: json["pages"].type))
        }
        self.pages = json["pages"].number.map { Double($0) }

        // Check for extraneous properties
        if let jsonProperties = json.dictionary?.keys {
            let properties: [String] = ["id", "title", "author", "pages"]
            for jsonPropertyName in jsonProperties {
                if !properties.contains(where: { $0 == jsonPropertyName }) {
                    throw ModelError.extraneousProperty(name: jsonPropertyName)
                }
            }
        }
    }

    public func settingID(_ newId: String?) -> Book {
      return Book(id: newId, title: title, author: author, pages: pages)
    }

    public func updatingWith(json: JSON) throws -> Book {
        if json["id"].exists() &&
           json["id"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "id", type: "string", value: json["id"].description, valueType: String(describing: json["id"].type))
        }
        let id = json["id"].string ?? self.id

        if json["title"].exists() &&
           json["title"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "title", type: "string", value: json["title"].description, valueType: String(describing: json["title"].type))
        }
        let title = json["title"].string ?? self.title

        if json["author"].exists() &&
           json["author"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "author", type: "string", value: json["author"].description, valueType: String(describing: json["author"].type))
        }
        let author = json["author"].string ?? self.author

        if json["pages"].exists() &&
           json["pages"].type != .number {
            throw ModelError.propertyTypeMismatch(name: "pages", type: "number", value: json["pages"].description, valueType: String(describing: json["pages"].type))
        }
        let pages = json["pages"].number.map { Double($0) } ?? self.pages

        return Book(id: id, title: title, author: author, pages: pages)
    }

    public func toJSON() -> JSON {
        var result = JSON([
            "title": JSON(title),
        ])
        if let id = id {
            result["id"] = JSON(id)
        }
        if let author = author {
            result["author"] = JSON(author)
        }
        if let pages = pages {
            result["pages"] = JSON(pages)
        }

        return result
    }
}
