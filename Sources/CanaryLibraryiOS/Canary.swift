import Logging
import Foundation

var uiLogger: Logger!

public class Canary
{
    private var chirp: CanaryTest

    public required init(configDirectoryURL: URL, resultsDirectoryURL: URL? = nil, logger: Logger, timesToRun: Int = 1, debugPrints: Bool = false, runWebTests: Bool = false)
    {
        uiLogger = logger
        chirp = CanaryTest(configDirectoryURL: configDirectoryURL, resultsDirectoryURL: resultsDirectoryURL, testCount: timesToRun, debugPrints: debugPrints, runWebTests: runWebTests)
    }
    
    public func runTest()
    {
        chirp.begin()
    }
}
