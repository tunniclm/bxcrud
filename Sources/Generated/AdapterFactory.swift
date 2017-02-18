import Foundation
import Configuration
import CloudFoundryConfig
import CouchDB

public class AdapterFactory {
    let manager: ConfigurationManager

    init(manager: ConfigurationManager) {
        self.manager = manager
    }

    public func getBookAdapter() throws -> BookAdapter {
      let service = try manager.getCloudantService(name: "cloudantCrudService")
      return BookCloudantAdapter(ConnectionProperties(
          host:     service.host,
          port:     Int16(service.port),
          secured:  true, // FIXME Fix CloudConfiguration
          username: service.username,
          password: service.password
      ))
    }

}
