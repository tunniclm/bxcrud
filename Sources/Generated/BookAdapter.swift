public protocol BookAdapter {
    func findAll(onCompletion: @escaping ([Book], Error?) -> Void)
    func create(_ model: Book, onCompletion: @escaping (Book?, Error?) -> Void)
    func deleteAll(onCompletion: @escaping (Error?) -> Void)

    func findOne(_ maybeID: String?, onCompletion: @escaping (Book?, Error?) -> Void)
    func update(_ maybeID: String?, with model: Book, onCompletion: @escaping (Book?, Error?) -> Void)
    func delete(_ maybeID: String?, onCompletion: @escaping (Book?, Error?) -> Void)
}
