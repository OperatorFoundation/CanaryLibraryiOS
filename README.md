# CanaryLibraryiOS

Canary library for iOS applications. Based on the [original project](https://github.com/OperatorFoundation/CanaryLibrary.git) written in Swift.

Canary is a tool for testing transport connections and recording the results in an easy to share csv format. Canary compiles the results in a daily digest as a csv file with a name that includes the date.

Canary will run a series of transport tests based on the configs that you provide. It is possible to test each transport on a different transport server based on what host information is provided in the transport config files.

Currently [Shadow](https://github.com/OperatorFoundation/ShadowSwift.git) and [Starbridge](https://github.com/OperatorFoundation/Starbridge.git) tests are supported. Replicant support is underway, and will be capable of mimicking other transports when it is complete.

## Using the Library
To use the library you only need to create an instance of Canary and call `runTest()` on that instance.

### Quick Start
To create and run a Canary instance where you only provide the minimum required arguments and allow Canary to use the default settings for everything else:
```
let canary = Canary(configDirectoryURL: configDirectory, logger: logger)
canary.runTest()
```

#### Parameters
The Canary initializer has additional parameters with default values:
```
public required init(configDirectoryURL: URL, resultsDirectoryURL: URL? = nil, logger: Logger, timesToRun: Int = 1, debugPrints: Bool = false, runWebTests: Bool = false)
```
- **configDirectoryURL**: The URL for the directory where all of the config files for the transports to be tested can be found.
- **resultsDirectoryURL**: The URL for the directory where the results files should be saved. *(defaults to the user's documents directory)*
- **logger**: An instance of [swift-log](https://github.com/apple/swift-log.git) Logger.
- **timesToRun**:  An Int representing the number of times you would like Canary to repeat testing all of the transports it finds valid configs for in the provided config directory. These tests will be repeated immediately. *(the default is 1)*
- **debugPrints**:  A Boolean indicating whether you would like Caanry to run in a verbose manner. *(the default is false)*
- **runWebTests**: This option is not yet fully implemented and the argument should not be supplied so that the default value of false remains. *(the default is false)*
    
## Transport Config files

See the documenation for a specific transport if you need instructions on how to generate config files for Canary supported transports:
- [Starbridge](https://github.com/OperatorFoundation/Starbridge.git)
- [ShadowSwift](https://github.com/OperatorFoundation/ShadowSwift.git)

Config files must conform to the following convention:
- They must be valid JSON files that conform to the specific transport requirements (e.g. Shadow, Starbridge).
- File names must include the name of the specific transport (e.g. "ShadowClientConfig.json", "StarbridgeClientConfig.json").
