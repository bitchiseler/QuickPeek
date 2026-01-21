//
//  PermissionManager.swift
//  QuickPeek
//
//  Created by Assistant on 1/21/26.
//

import Foundation

class PermissionManager {
    static let shared = PermissionManager()
    
    private let defaults = UserDefaults.standard
    private let bookmarkKeyPrefix = "bookmark_"
    
    private init() {}
    
    func saveBookmark(for url: URL) {
        do {
            let data = try url.bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
            defaults.set(data, forKey: bookmarkKeyPrefix + url.path)
            print("Bookmarks saved for: \(url.path)")
        } catch {
            print("Failed to save bookmark for \(url.path): \(error)")
        }
    }
    
    func resolveBookmark(for path: String) -> URL? {
        guard let data = defaults.data(forKey: bookmarkKeyPrefix + path) else {
            return nil
        }
        
        var isStale = false
        do {
            let url = try URL(resolvingBookmarkData: data, options: .withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &isStale)
            
            if isStale {
                print("Bookmark is stale, renewing...")
                saveBookmark(for: url)
            }
            
            if url.startAccessingSecurityScopedResource() {
                return url
            } else {
                print("Failed to access security scoped resource for \(path)")
                return nil
            }
        } catch {
            print("Failed to resolve bookmark for \(path): \(error)")
            return nil
        }
    }
    
    func clearBookmark(for path: String) {
        defaults.removeObject(forKey: bookmarkKeyPrefix + path)
    }
}
