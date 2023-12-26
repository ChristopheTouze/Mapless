"
I am global storage of mongo healthcheck dedicated clients.
"
Class {
	#name : #MaplessMongoRSHealthCheckerClients,
	#superclass : #MaplessAbstracMongoPool,
	#instVars : [
		'dictionary'
	],
	#classInstVars : [
		'default'
	],
	#category : #'Mapless-Mongo-Core-Connections'
}

{ #category : #accessing }
MaplessMongoRSHealthCheckerClients class >> default [ 
	^default ifNil: [ default := self new ]
]

{ #category : #initialization }
MaplessMongoRSHealthCheckerClients class >> reset [
"self reset"
	self stop.
	default := nil
]

{ #category : #accessing }
MaplessMongoRSHealthCheckerClients class >> stop [ 
	^default ifNotNil: [ default stop ]
]

{ #category : #acccessing }
MaplessMongoRSHealthCheckerClients >> dictionary [
	^dictionary
]

{ #category : #actions }
MaplessMongoRSHealthCheckerClients >> getHealthCheckClientFor: aMongoUrl addIfMissing: aBlock [
	| client key |
	key := self keyFrom: aMongoUrl.
	client := self dictionary at: key ifAbsent: [  ].
	(client notNil and: [ self isClientHealthy: client ])
		ifTrue: [ client close.
			client := nil ].
	^ client
		ifNil: [ client := self dictionary at: key put: aBlock value ]

]

{ #category : #initialization }
MaplessMongoRSHealthCheckerClients >> initialize [
	dictionary := Dictionary new
]

{ #category : #testing }
MaplessMongoRSHealthCheckerClients >> isClientHealthy: client [
	"Answers true if client is healthy"
	^ client notNil
		and: [ client isValid
				and:
					[ (MongoDatabase root: client name: 'admin') collectionNames notEmpty ] ]
]

{ #category : #acccessing }
MaplessMongoRSHealthCheckerClients >> keyFrom: aMongoUrl [
	^aMongoUrl asMongoUrlString
]

{ #category : #actions }
MaplessMongoRSHealthCheckerClients >> stop [
	dictionary valuesDo: [ :eachClient | [eachClient close] on: Error do:[] ]
]
