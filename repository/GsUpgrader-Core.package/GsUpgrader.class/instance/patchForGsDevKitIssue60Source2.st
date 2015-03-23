patching
patchForGsDevKitIssue60Source2
  "https://github.com/GsDevKit/GsDevKit/issues/60"

  "HTTPSocket>>getResponseUpTo:ignoring:"

  ^ 'getResponseUpTo: markerString ignoring: ignoreString
  "Keep reading, until the marker is seen, skipping characters in ignoreString when
      comparing to the marker.  Return three parts: header, marker, beginningOfData.
     Fails if no marker in first 2000 chars."

  | buf response bytesRead tester mm skipped tries |
  Transcript cr; show: ''getResponseUpTo:ignoring:[0] ''. 
  buf _ ByteArray new: 2000.
  response _ WriteStream on: ByteArray new.
  tester _ 1.
  mm _ 1.
  skipped _ 0.
  tries := 3.
  [ 
  tester _ tester - markerString size + 1 max: 1.	"rewind a little, in case the marker crosses a read boundary"
  tester to: response position - 1 do: [ :tt | 
    (Character value: (buf at: tt)) = (markerString at: mm)
      ifFalse: [ 
        [ ignoreString includes: (markerString at: mm) ]
          whileTrue: [ 
            mm _ mm + 1.
            skipped _ skipped + 1 ] ].
    (Character value: (buf at: tt)) = (markerString at: mm)
      ifTrue: [ mm _ mm + 1 ]
      ifFalse: [ 
        mm _ 1.
        skipped _ 0 ].	"Not totally correct for markers like xx0xx"
    mm > markerString size
      ifTrue: [ 
        "got it"
        ^ Array
          with: (buf asString copyFrom: 1 to: tt + 1 - mm + skipped)
          with: markerString
          with: (buf asString copyFrom: tt + 1 to: response position - 1) ] ].
  tester _ 1 max: response position.	"OK if mm in the middle"
  response position < buf size & (self isActive | self readyForRead)
    & ((tries := tries - 1) >= 0) ]
    whileTrue: [
      Transcript cr; show: ''getResponseUpTo:ignoring:[1] '', tries printString.
self underlyingSocket raiseExceptionOnError: true. 
      (self waitForReadDataUpToMs: 12000)
        ifFalse: [ 
           self error: self underlyingSocket  lastErrorString asString].
      bytesRead _ self readInto: buf startingAt: 1 for: buf size.
      response nextPutAll: (buf copyFrom: 1 to: bytesRead) ].
  ^ Array with: response contents asString with: '' with: ''	"Marker not found and connection closed"'