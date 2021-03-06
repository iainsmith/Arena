//
//  File.swift
//  
//
//  Created by Sven A. Schmidt on 20/12/2019.
//

import Foundation
import PackageLoading
import Path
import Workspace


// see: https://github.com/apple/swift-package-manager/blob/master/Examples/package-info/Sources/package-info/main.swift
let swiftCompiler: AbsolutePath = {
    let string: String
    #if os(macOS)
    string = try! Process.checkNonZeroExit(args: "xcrun", "--sdk", "macosx", "-f", "swiftc").spm_chomp()
    #else
    string = try! Process.checkNonZeroExit(args: "which", "swiftc").spm_chomp()
    #endif
    return AbsolutePath(string)
}()


public struct LibraryInfo {
    var libraryName: String
    var packageName: String
    var path: AbsolutePath
}


public func getLibraryInfo(for package: Path) throws -> [LibraryInfo] {
    let path = AbsolutePath(package.string)
    let manifest = try ManifestLoader.loadManifest(packagePath: path, swiftCompiler: swiftCompiler)
    return manifest.products.filter { p in
        if case .library = p.type {
            return true
        } else {
            return false
        }
    }.map {
        LibraryInfo(libraryName: $0.name, packageName: manifest.name, path: path)
    }
}


extension Foundation.URL {
    public func lastPathComponent(dropExtension ext: String) -> String {
        if pathExtension == ext {
            return deletingPathExtension().lastPathComponent
        }
        return lastPathComponent
    }
}
