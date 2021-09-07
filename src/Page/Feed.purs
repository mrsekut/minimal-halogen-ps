module MiniHalo.Page.Feed where

import Prelude

import Halogen as H
import Halogen.HTML as HH
import Type.Prelude (Proxy(..))



type Slot p = ∀ query. H.Slot query Void p


_feed :: Proxy "feed"
_feed = Proxy


component :: ∀ q i o m. H.Component q i o m
component =
  H.mkComponent
  { initialState: identity
  , render
  , eval: H.mkEval H.defaultEval
  }
  where
  render :: ∀ state action m. state -> H.ComponentHTML action () m
  render _ = HH.h1_ [ HH.text "Feed Page" ]