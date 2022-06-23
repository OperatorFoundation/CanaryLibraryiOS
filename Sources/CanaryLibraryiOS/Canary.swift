import Logging
import Foundation

var uiLogger: Logger!

public class Canary
{
    private var chirp: CanaryTest

    public required init(configDirectoryURL: URL, savePath: String? = nil, logger: Logger, timesToRun: Int = 1, interface: String? = nil, debugPrints: Bool = false, runWebTests: Bool = false)
    {
        uiLogger = logger
        chirp = CanaryTest(configDirectoryURL: configDirectoryURL, savePath: savePath, testCount: timesToRun, interface: interface, debugPrints: debugPrints, runWebTests: runWebTests)
    }
    
    public func runTest()
    {
        chirp.begin()
    }
}
