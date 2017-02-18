import Foundation
import Kitura
import Configuration

import SwiftMetrics
import SwiftMetricsDash
import SwiftMetricsBluemix

public class GeneratedApplication {
    public let router: Router
    private let manager: ConfigurationManager
    private let factory: AdapterFactory

    public init(configURL: URL) throws {
        router = Router()
        manager = try ConfigurationManager()
                          .load(url: configURL)
                          .load(.environmentVariables)
        // Set up monitoring
        let sm = try SwiftMetrics()
        let _ = try SwiftMetricsDash(swiftMetricsInstance : sm, endpoint: router)
    let _ = AutoScalar(swiftMetricsInstance: sm)

        factory = AdapterFactory(manager: manager)

        try BookResource(factory: factory).setupRoutes(router: router)
    }
}
