module MiniHalo.Data.Route (Route(..), route) where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Lens.Iso.Newtype (_Newtype)
import Data.Newtype (class Newtype)
import Data.Show.Generic (genericShow)
import Routing.Duplex (RouteDuplex', root, segment)
import Routing.Duplex.Generic as G



-- Route

data Route
  = Home
  -- | Feed
  -- | Profile Username

derive instance Eq Route
derive instance Ord Route

derive instance Generic Route _

instance Show Route where
  show = genericShow



route :: RouteDuplex' Route
route = root $ G.sum
  { "Home": G.noArgs
  -- , "Feed": "feed" / G.noArgs
  -- , "Profile": "user" / username
  }



-- Username

newtype Username
  = Username String

derive instance Newtype Username _

instance Show Username where
  show (Username user) = user


username :: RouteDuplex' Username
username = _Newtype segment
