module MiniHalo.Data.Username (Username, mkUsername) where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Newtype (class Newtype)



-- Username

newtype Username
  = Username String

derive instance Newtype Username _
derive instance Eq Username
derive instance Ord Username

instance Show Username where
  show (Username user) = user


mkUsername :: String -> Username
mkUsername user = Username user
-- mkUsername :: String -> Maybe Username
-- mkUsername user = case user of
--   "" -> Nothing
--   _  -> Just $ Username user

