patching
patchForGsDevKitIssue60Source1
  "https://github.com/GsDevKit/GsDevKit/issues/60"

  "HTTPSocket>>getResponseUpTo:"

  ^ 'getResponseUpTo: markerString
  "Keep reading until the marker is seen.  Return three parts: header, marker, beginningOfData.  Fails if no marker in first 2000 chars."

  | buf response bytesRead tester mm tries |
  buf := ByteArray new: 2000.
  response := WriteStream on: ByteArray new.
  tester := 1.
  mm := 1.
  tries := 3.
  [ 
  tester := tester - markerString size + 1 max: 1.	"rewind a little, in case the marker crosses a read boundary"
  tester to: response position - 1 do: [ :tt | 
    (Character value: (buf at: tt)) = (markerString at: mm)
      ifTrue: [ mm := mm + 1 ]
      ifFalse: [ mm := 1 ].	"Not totally correct for markers like xx0xx"
    mm > markerString size
      ifTrue: [ 
        "got it"
        ^ Array
          with: (buf asString copyFrom: 1 to: tt + 1 - mm)
          with: markerString
          with: (buf asString copyFrom: tt + 1 to: response position - 1) ] ].
  tester := 1 max: response position.	"OK if mm in the middle"
  response position < buf size & (self isActive | self readyForRead)
    & ((tries := tries - 1) >= 0) ]
    whileTrue: [ 
      (self waitForReadDataUpToMs: 1000)
        ifFalse: [ 
          tries < 0
            ifTrue: [ self error: ''data was late'' ]].
      bytesRead := self readInto: buf startingAt: 1 for: buf size.
      response nextPutAll: (buf copyFrom: 1 to: bytesRead) ].
  ^ Array with: response contents asString with: '' with: ''	"Marker not found and connection closed"'