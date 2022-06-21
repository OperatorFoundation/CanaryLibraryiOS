import Logging
import XCTest
@testable import CanaryLibraryiOS

final class CanaryLibraryiOSTests: XCTestCase {
    
    func testQuickSetUpCanaryLibraryiOS()
    {
        let gadot = XCTestExpectation(description: "Never arrives")
        
        // iOS specific pathing:
        do
        {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let testFileURL = documentDirectory.appendingPathComponent("shadowSocksClient.json")
            
            if !FileManager.default.fileExists(atPath: testFileURL.path)
            {
                let testFileContents = "{\"password\": \"9caa4132c724f137c67928e9338c72cfe37e0dd28b298d14d5b5981effa038c9\", \"cipherName\": \"DarkStar\", \"serverIP\": \"164.92.71.230\", \"port\": 1234}"
                
                try testFileContents.write(to: testFileURL, atomically: true, encoding: .utf8)
            }
            
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
            
            print("Printing contents of the document directory: ")
            for fileURL in directoryContents
            {
                print(fileURL.path)
            }
            
            let logger = Logger(label: "CanaryLibraryiOSExample")
            let canary = Canary(configDirectoryURL: documentDirectory, logger: logger)
            
            canary.runTest(runAsync: true)
        }
        catch
        {
            print("Failed to find the document directory.")
            XCTFail()
        }
                                  
        wait(for: [gadot], timeout: 30)
    }
}
