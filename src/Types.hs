module Types
    (
    ) where

import Data.Text (Text)

newtype GraphId =
  GraphId { getGraphId :: Text }

type AttributeName  = Text
type AttributeValue = Text

type AttributePairs = (AttributeName, AttributeValue)

data GraphType =
    Concept
  | ConceptScheme

data GraphNode =
  GraphNode {
      _gnId         :: GraphId
    , _gnType       :: GraphType
    , _gnAttributes :: Map Text [AttributePairs]
  }
