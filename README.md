# MappingKit

## Introduction

The `KeyPath` type provided by Swift 4 is an opportunity to map data structures together in a simpler, type-safe way.

## Installation

For now, no cocoapods, on swift package manager are supported (soon !).

Since there are no dependency for this framework, you can use it with Carthage.

### Carthage

Add the following to your `Cartfile`:

`github "zarghol/MappingKit"`


## Usage

For a single Mapping from a A.property1 to B.property2 you can do it with `BaseMapping` :

```
let source = A()
var destination = B() // destination already exist
let mapping = BaseMapping(sourcePath: \A.property1, destinationPath: \B.property2)

destination = mapping.use(source, destination) // replace destination with the new version
```

or by conforming you class to `Updatable` :

```
extension B: Updatable { }

// ...

let source = A()
var destination = B() // destination already exist
let mapping = BaseMapping(sourcePath: \A.property1, destinationPath: \B.property2)

destination.modify(with: mapping, from: source, type: BPropertyType.self) // modify in place, but the value type cannot be inferred properly for now...
```

If you want to perform multiple mapping at once, you can use a `BaseMapper` :

```
let source = A()
var destination = B()

let mapper = BaseMapper(table: [
   BaseMapping(sourcePath: \A.property1, destinationPath: \B.property2),
   BaseMapping(sourcePath: \A.propertyA, destinationPath: \B.propertyB)
])

destination = mapper.use(from: source, to: destination) // can't use modify for now because of inference of multiple type...
```

You can also use a mapper to initialize a data structure with `MappingInitializable` :

```
extension B: MappingInitializable {
   typealias T = A

   init(from mapping: BaseMapper<String, B>, with value: A) throws {
      guard let firstMapping = mapping.table.filter({ $0.destinationPath == \B.property2 }).first else {
         throw MappingError.invalidKeyPath(\B.property2)
      }

      self.property2 = try firstMapping.value(from: value)
   }
}

// ...

let source = A()
let mapper = BaseMapper(table: [
   BaseMapping(sourcePath: \B.property1, destinationPath: \B.property2),
])

do {
   let dest = try B(from: mapper, with: source)
} catch {
   print("error occured : \(error)")
}
```

## TODOs

- [ ] Find a way to use modify without type
- [ ] Find a way to perform modify for mapper
- [ ] Add Cocoapods and Swift Package Manager
- [ ] Maybe refactor with FullMapping with Backing BaseMapping for type safety, and using only degraded type safety in limited cases.

## Contribution

Feel free to contribute, send Pull Request, add issues, etc... :)
