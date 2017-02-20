Haskell-Learning-Exercise-1
---------------------------

This is a simple Haskell exercise - divided into two parts:

Part 1 is designed to get you familiar with the basics of Haskell, reading/writing files and parsing/encoding JSON data.
Part 2 extends this by fetching the file to read from a HTTP API and writing the file back to a HTTP API.


The problem:

There are the three JSON-LD (JSON - Linked Data) files associated with this exercise:

1. graph_multischeme.jsonld
2. graph_singlescheme_roletitle.jsonld
3. graph_singlescheme_seniority.jsonld

The JSON-LD files each represents a 'graph' of JSON objects.
Logically, a graph can be thought of as an object that contains one or more 'concept schemes'.
Each concept scheme contains one or more 'concepts'. 
The graph, concept scheme and concepts all have a unique string id (representated as a uri of the form http://graph.seek.com/.../<some-identifier>).
A concept has various attributes like id, creator, prefLabel, altLabels etc.

File #1 - represents a graph with 2 concept schemes: role title and seniority. Each of these concepts schemes have around 3-4 concepts in this file.

We need to split the graph in file #1, into two seperate JSON files - with essentially the same structured - but each having its own graph with one concept scheme.
So there would be a file for the role title, and one for the seniority.

The outputs should look like files #2 and #3.

The actual representation in JSON of graph, concept scheme and concepts is a bit tricky and doesn't match up with the logical model described above.
The data in the file is structured as follows:
	- An array with one item - the graph object.
	- The graph object contains a single '@graph' attribute, that is an array of objects. Some of these objects are concepts, while others are concept schemes. (In this case, in file #1 there would be only 2 objects which are concept schemes).
	- Concept schemes can be identified by inspecting the value of the '@type' attribute, which is an array with one element : [ "http://www.w3.org/2004/02/skos/core#ConceptScheme" ]
	- Concepts have a type : [ "http://www.w3.org/2004/02/skos/core#Concept" ]
	- Many attributes of a concept are actually arrays - even if there is only one item in there.
	- Many attribute names and some values in the JSON are URIs.
	- A concept can be identified as the child of a concept scheme by looking at the value of its 'http://www.w3.org/2004/02/skos/core#topConceptOf' attribute. 
	  For example:
		"http://www.w3.org/2004/02/skos/core#topConceptOf" : [ {
	      "@id" : "http://graph.seek.com/seniority/scheme"
	    } ]
	  says that the concept that has this 'topConceptOf' attribute is a child of the concept scheme with id 'http://graph.seek.com/seniority/scheme'
	  (There would be a JSON object in the '@graph' array with this id)


The second stage is downloading file #1 from a HTTP API (https://help.poolparty.biz/doc/developer-guide/basic-advanced-server-apis/poolparty-api-guide/project-services/method-export-and-download-project-data) 
and 
uploading files #2 and #3 to another HTTP API (https://help.poolparty.biz/doc/developer-guide/basic-advanced-server-apis/poolparty-api-guide/project-services/method-import-project-data).
More details on how the HTTP API works is available in the docs linked.

Talk to Krishna/David from the Structured Data team to get access to the API.


Suggested libraries and tools:
------------------------------
Haskell stack with the latest LTS (8.0 as of 17 Feb 17)
aeson (for JSON)
text (for efficient text manipulation)
http-simple (for talking to the HTTP API)

Atom text editor with the following plugins:
	atom-beautify
	autocomplete-haskell
	haskell-ghc-mod
	haskell-hoogle
	haskell-pointfree
	ide-haskell
	ide-haskell-cabal
	ide-haskell-hasktags
	ide-haskell-hoogle
	ide-haskell-repl
	language-haskell
	linter-hlint

It is best to setup Stackage (https://www.stackage.org/) as a search engine in your favourite browser, because you will be visiting it very often. (The auto-complete and type info tooltips in Atom are not super-awesome for Haskell, and the features are even worse in the VSCode plugins).

Useful resources:
-----------------
Stack - the Haskell toolset: https://docs.haskellstack.org/en/stable/README/
Stackage: (This is like MSDN, except the documentation, like the Haskell language is very terse :)) https://www.stackage.org/
AESON tutorial: https://artyom.me/aeson
General Haskell help: http://learnyouahaskell.com/chapters
This will help when you're stuck in a Monad: http://adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html#functors

