![Mapless](./header.png)

# Mapless

Schema-less persistence for Smalltalk with support for multiple backends.

![build](https://github.com/sebastianconcept/Mapless/actions/workflows/build.yml/badge.svg)
[![Release](https://img.shields.io/github/v/tag/sebastianconcept/Mapless?label=release)](https://github.com/sebastianconcept/Mapless/releases)
![Tests](https://img.shields.io/badge/tests-178-green)
[![License](https://img.shields.io/badge/license-MIT-green)](./LICENSE.txt)

[![Social](https://img.shields.io/github/stars/sebastianconcept/Mapless?style=social)]()
[![Forks](https://img.shields.io/github/forks/sebastianconcept/Mapless?style=sociall)]()
[![](https://img.shields.io/reddit/subreddit-subscribers/mapless_data?style=social)](https://www.reddit.com/r/mapless_data/)

---

## Features

- Intuitive API for frictionless persistence.
- No need to create and maintain schemas.
- Composable.
- JSON friendly.
- No need to create accessors and mutators.
- Multiple backends to chose from.
- Enables smooth data migration/interoperation among backends.
- Via Redis PUB/SUB, scalable observer-pattern functionality across images.

## Ambition

Mapless gives you performant state plasticity and high availability in a scale that goes beyond one Smalltalk image and without backend vendor locking nor object-mapping impedance mismatch.

## Supported backends

1. MongoDB
2. Redis
3. Memory
4. PostgreSQL
5. UnQLite

## Examples

```Smalltalk
"Instanciates a mapless object."
genius := DummyPerson new
	firstName: 'Aristotle';
	yourself.

"Saves it."
repository save: genius.
```

```Smalltalk
"Loads one by known ID."
identified := repository findOne: DummyPerson atId: genius id.
```

```Smalltalk
"Loads all instances of that class that were stored in that database."
allOrEmpty := repository findAll: DummyPerson.
```

```Smalltalk
"Query to load all the instances that match the condition."
someOrEmpty := repository findAll: DummyPerson where: [ :each | each lastName = 'Peterson' ].
```

```Smalltalk
"Conditionally loading the first matching instance."
oneOrNil := repository findOne: DummyPerson where: [ :each | each lastName = 'Peterson' ].
```

## Installation

Open a Pharo workspace and evaluate:

```smalltalk
Metacello new
  baseline: 'Mapless';
  repository: 'github://sebastianconcept/Mapless:v0.5.4-beta/src';
  load
```

## Include as dependency

In BaselineOf or ConfigurationOf it can be added in this way:

```smalltalk
spec
  baseline: 'Mapless'
    with: [ spec
    repository: 'github://sebastianconcept/Mapless:v0.5.0-alpha/src';
    loads: #('Core' 'Mongo' 'Memory' 'Redis' 'UnQLite') ]
```
