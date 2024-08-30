/*
   Project: DSA3

   Copyright (C) 2024 Free Software Foundation

   Author: Sebastian Reitenbach

   Created: 2024-08-23 22:53:20 +0200 by sebastia

   This application is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This application is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111 USA.
*/

#import "NSDictionary+Extras.h"

@implementation NSDictionary (Extras)


- (id)findMutableObjectForKey:(NSString *)key {
    for (NSString *currentKey in self) {
        // Check if the current key matches the search key
        if ([currentKey isEqualToString:key]) {
            id value = self[currentKey];
            
            // If it's a dictionary, ensure mutability
            if ([value isKindOfClass:[NSDictionary class]]) {
                if (![value isKindOfClass:[NSMutableDictionary class]]) {
                    value = [value mutableCopy];
                }
            }
            
            return value;
        }
        
        // Get the value associated with the current key
        id value = self[currentKey];
        
        // Recursively search dictionaries
        if ([value isKindOfClass:[NSDictionary class]]) {
            id result = [(NSDictionary *)value findMutableObjectForKey:key];
            if (result) {
                // Ensure result is mutable if it's a dictionary
                if ([result isKindOfClass:[NSDictionary class]] && ![result isKindOfClass:[NSMutableDictionary class]]) {
                    result = [result mutableCopy];
                }
                return result;
            }
        }
        // Recursively search arrays
        else if ([value isKindOfClass:[NSArray class]]) {
            for (id item in (NSArray *)value) {
                if ([item isKindOfClass:[NSDictionary class]] || [item isKindOfClass:[NSArray class]] || [item isKindOfClass:[NSSet class]]) {
                    id result = [item findMutableObjectForKey:key];
                    if (result) {
                        // Ensure result is mutable if it's a dictionary
                        if ([result isKindOfClass:[NSDictionary class]] && ![result isKindOfClass:[NSMutableDictionary class]]) {
                            result = [result mutableCopy];
                        }
                        return result;
                    }
                }
            }
        }
        // Recursively search sets
        else if ([value isKindOfClass:[NSSet class]]) {
            for (id item in (NSSet *)value) {
                if ([item isKindOfClass:[NSDictionary class]] || [item isKindOfClass:[NSArray class]] || [item isKindOfClass:[NSSet class]]) {
                    id result = [item findMutableObjectForKey:key];
                    if (result) {
                        // Ensure result is mutable if it's a dictionary
                        if ([result isKindOfClass:[NSDictionary class]] && ![result isKindOfClass:[NSMutableDictionary class]]) {
                            result = [result mutableCopy];
                        }
                        return result;
                    }
                }
            }
        }
    }
    // If the key is not found, return nil
    return nil;
}

- (id)findObjectForKey:(NSString *)key {
    for (NSString *currentKey in self) {
        // Check if the current key matches the search key
        if ([currentKey isEqualToString:key]) {
            return self[currentKey];
        }
        
        // If the value is another dictionary, search recursively
        id value = self[currentKey];
        if ([value isKindOfClass:[NSDictionary class]]) {
            id result = [(NSDictionary *)value findObjectForKey:key];
            if (result) {
                return result;
            }
        }
    }
    // If the key is not found, return nil
    return nil;
}


- (NSString *)findKeyPathForKey:(NSString *)targetKey {
    // Start the recursive search from the root dictionary
    return [self findKeyPathForKey:targetKey currentPath:@""];
}

- (NSString *)findKeyPathForKey:(NSString *)targetKey currentPath:(NSString *)path {
    for (NSString *currentKey in self) {
        id currentValue = self[currentKey];
        
        // Construct the new path
        NSString *newPath = [path length] > 0 ? [path stringByAppendingFormat:@".%@", currentKey] : currentKey;
        
        // Debugging output
        //NSLog(@"Checking key: %@, path: %@, currentValue: %@", currentKey, newPath, currentValue);
        
        // Check if the current key matches the target key
        if ([currentKey isEqualToString:targetKey]) {
            return newPath;
        }
        
        // If the value is a dictionary, search recursively
        if ([currentValue isKindOfClass:[NSDictionary class]]) {
            NSString *result = [(NSDictionary *)currentValue findKeyPathForKey:targetKey currentPath:newPath];
            if (result) {
                return result;
            }
        }
    }
    
    // If not found, return nil
    return nil;
}

@end