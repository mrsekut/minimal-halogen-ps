module MiniHalo.Data.Route (Route(..), route) where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import MiniHalo.Data.Username (Username)
import Routing.Duplex (RouteDuplex', segment, root)
import Data.Lens.Iso.Newtype (_Newtype)
import Routing.Duplex.Generic as G
import Routing.Duplex.Generic.Syntax ((/))



-- Route

data Route
  = Home
  | Feed
  | Profile Username

derive instance Eq Route
derive instance Ord Route

derive instance Generic Route _

instance Show Route where
  show = genericShow



route :: RouteDuplex' Route
route = root $ G.sum
  { "Home": G.noArgs
  , "Feed": "feed" / G.noArgs
  , "Profile": "user" / username
  }


username :: RouteDuplex' Username
username = _Newtype segment