extension Collection where Element: BinaryInteger {
    /// Returns the total sum of all elements in the array
    var total: Element { reduce(0, +) }
    
    /// Returns the average of all elements in the array
    var average: Double { isEmpty ? 0 : Double(total) / Double(count) }
}
